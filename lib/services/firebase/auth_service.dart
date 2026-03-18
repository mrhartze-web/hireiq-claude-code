import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '206938404491-t0l2bkj102o475i11je8jphr31840ovs.apps.googleusercontent.com',
  );

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
    required String role,
  }) async {
    debugPrint('[AuthService] signUpWithEmail: starting for $email, role=$role');

    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    debugPrint('[AuthService] signUpWithEmail: Firebase Auth user created, uid=${credential.user!.uid}');

    await credential.user?.updateDisplayName(displayName);

    final uid = credential.user!.uid;
    final user = UserModel(
      uid: uid,
      email: email.trim(),
      displayName: displayName,
      role: role,
      isVerified: false,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      subscriptionTier: 'free',
      subscriptionStatus: 'inactive',
    );

    try {
      debugPrint('[AuthService] signUpWithEmail: writing Firestore document for uid=$uid');
      await _firestore.collection('users').doc(uid).set(user.toJson());
      debugPrint('[AuthService] signUpWithEmail: Firestore write complete, verifying...');

      // Verify the document was actually persisted
      final verification = await _firestore.collection('users').doc(uid).get();
      if (verification.exists) {
        debugPrint('[AuthService] signUpWithEmail: Firestore document verified ✓ uid=$uid role=${verification.data()?['role']}');
      } else {
        debugPrint('[AuthService] signUpWithEmail: WARNING — Firestore document NOT found after write for uid=$uid');
      }
    } catch (e, stack) {
      debugPrint('[AuthService] signUpWithEmail: ERROR writing Firestore document — $e');
      debugPrint('[AuthService] signUpWithEmail: stack trace — $stack');
      // Rethrow so the caller can surface the error to the user
      rethrow;
    }

    return credential;
  }

  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw Exception('Google sign-in cancelled');
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential = await _auth.signInWithCredential(credential);
    // Create Firestore record if first sign-in
    final uid = userCredential.user!.uid;
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) {
      final user = UserModel(
        uid: uid,
        email: userCredential.user?.email ?? '',
        displayName: userCredential.user?.displayName ?? '',
        role: 'candidate',
        isVerified: false,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        subscriptionTier: 'free',
        subscriptionStatus: 'inactive',
      );
      await _firestore.collection('users').doc(uid).set(user.toJson());
    }
    return userCredential;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async =>
      await _auth.sendPasswordResetEmail(email: email.trim());

  Future<void> sendEmailVerification() async =>
      await _auth.currentUser?.sendEmailVerification();

  Future<String?> getUserRole(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.data()?['role'] as String?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> getUserModel(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
