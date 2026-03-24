import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/payments/subscription_service.dart';
import 'auth_provider.dart';

final subscriptionServiceProvider =
    Provider<SubscriptionService>((ref) => SubscriptionService());

/// Current plan for any user by uid.
final userPlanProvider =
    FutureProvider.family<Map<String, dynamic>?, String>(
        (ref, userId) async {
  return ref.watch(subscriptionServiceProvider).getUserPlan(userId);
});

/// Whether any user has an active paid subscription.
final hasActiveSubscriptionProvider =
    FutureProvider.family<bool, String>((ref, userId) async {
  return ref
      .watch(subscriptionServiceProvider)
      .hasActiveSubscription(userId);
});

/// Current plan for the signed-in user — no uid param needed.
final currentUserPlanProvider =
    FutureProvider<Map<String, dynamic>?>((ref) async {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) async {
      if (user == null) return SubscriptionService.plans['candidate_free'];
      return ref
          .watch(subscriptionServiceProvider)
          .getUserPlan(user.uid);
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

/// Most recent active subscription document for a user.
/// Used to surface nextBillingDate on billing screens.
final activeSubscriptionProvider =
    FutureProvider.family<Map<String, dynamic>?, String>(
        (ref, userId) async {
  return ref
      .read(subscriptionServiceProvider)
      .getActiveSubscription(userId);
});

// Suppress unused import warning — Timestamp used by callers of this provider.
final _unusedFirestore = FirebaseFirestore.instance;
