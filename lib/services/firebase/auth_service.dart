import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    await credential.user?.updateDisplayName(displayName);
    final user = UserModel(
      uid: credential.user!.uid,
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
    await _firestore
        .collection('users')
        .doc(credential.user!.uid)
        .set(user.toJson());
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
