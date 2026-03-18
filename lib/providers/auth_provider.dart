import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase/auth_service.dart';
import '../models/user_model.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

/// Live auth-state stream.  Seeded with [FirebaseAuth.instance.currentUser]
/// so the first read is never null while the stream warms up.
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

/// Synchronous role cache.  Set by the splash screen (returning users) and
/// by the signup/login screens (new and returning users).
/// The router redirect reads this to make instant role decisions.
final cachedRoleProvider = StateProvider<String?>((ref) => null);

final currentUserProvider = FutureProvider<UserModel?>((ref) async {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) async {
      if (user == null) return null;
      return ref.read(authServiceProvider).getUserModel(user.uid);
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

final userRoleProvider = FutureProvider<String?>((ref) async {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) async {
      if (user == null) return null;
      return ref.read(authServiceProvider).getUserRole(user.uid);
    },
    loading: () => null,
    error: (_, __) => null,
  );
});
