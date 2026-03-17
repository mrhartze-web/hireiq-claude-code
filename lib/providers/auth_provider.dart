import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase/auth_service.dart';
import '../models/user_model.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<User?>((ref) =>
    ref.watch(authServiceProvider).authStateChanges);

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
