import 'package:cloud_firestore/cloud_firestore.dart';
import 'peach_payments_service.dart';

class SubscriptionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Plan definitions — canonical pricing register
  static const Map<String, Map<String, dynamic>> plans = {
    'candidate_free': {
      'name': 'Candidate Free',
      'price': 0.0,
      'currency': 'ZAR',
      'interval': 'month',
      'features': [
        '5 applications per month',
        'Basic job matching',
        'CV upload',
      ],
    },
    'candidate_pro': {
      'name': 'Candidate Pro',
      'price': 29.0,
      'currency': 'ZAR',
      'interval': 'month',
      'features': [
        'Unlimited applications',
        'Full MatchIQ score',
        'PassportIQ verification',
        'ForgeIQ CV builder',
        'UpliftIQ learning path',
      ],
    },
    'employer_starter': {
      'name': 'Employer Starter',
      'price': 799.0,
      'currency': 'ZAR',
      'interval': 'month',
      'features': [
        '3 active jobs',
        'MatchIQ scoring',
        'Basic candidate search',
        '3 team members',
      ],
    },
    'employer_growth': {
      'name': 'Employer Growth',
      'price': 3999.0,
      'currency': 'ZAR',
      'interval': 'month',
      'features': [
        'Unlimited jobs',
        'WildcardIQ blind screening',
        'SignalIQ intelligence',
        'B-BBEE reporting',
        '10 team seats',
      ],
    },
    'recruiter_solo': {
      'name': 'Recruiter Solo',
      'price': 999.0,
      'currency': 'ZAR',
      'interval': 'month',
      'features': [
        'CRM pipeline',
        'CV vault',
        'Brief builder',
        'ShieldIQ fraud detection',
        'SignalIQ intelligence',
      ],
    },
    'recruiter_agency': {
      'name': 'Recruiter Agency',
      'price': 7999.0,
      'currency': 'ZAR',
      'interval': 'month',
      'features': [
        'All Solo features',
        'Multi-seat team',
        'Bulk brief processing',
        'White-label reports',
        'Agency analytics',
      ],
    },
  };

  /// Initiate a subscription purchase.
  /// Stores a pending record in Firestore and creates a Peach Payments checkout.
  Future<Map<String, dynamic>> initiateSubscription({
    required String userId,
    required String planId,
    required String userEmail,
  }) async {
    final plan = plans[planId];
    if (plan == null) throw Exception('Invalid plan: $planId');

    // Store pending subscription record
    await _db.collection('subscriptions').add({
      'userId': userId,
      'planId': planId,
      'planName': plan['name'],
      'amount': plan['price'],
      'currency': plan['currency'],
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Create Peach Payments checkout
    return PeachPaymentsService().createCheckout(
      userId: userId,
      planId: planId,
      amount: (plan['price'] as num).toDouble(),
      currency: plan['currency'] as String,
      planName: plan['name'] as String,
      userEmail: userEmail,
    );
  }

  /// Activate a subscription after successful payment verification.
  Future<void> activateSubscription({
    required String userId,
    required String planId,
    required String checkoutId,
  }) async {
    final now = DateTime.now();
    // Dart correctly overflows month 13 → next year January
    final nextBilling = DateTime(now.year, now.month + 1, now.day);

    await _db.collection('users').doc(userId).update({
      'subscriptionTier': planId,
      'subscriptionStatus': 'active',
      'updatedAt': FieldValue.serverTimestamp(),
    });

    await _db.collection('subscriptions').add({
      'userId': userId,
      'planId': planId,
      'status': 'active',
      'checkoutId': checkoutId,
      'activatedAt': FieldValue.serverTimestamp(),
      'nextBillingDate': Timestamp.fromDate(nextBilling),
    });
  }

  /// Returns true if the user has a paid active subscription.
  Future<bool> hasActiveSubscription(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (!doc.exists) return false;
    final status = doc.data()?['subscriptionStatus'] as String?;
    final tier = doc.data()?['subscriptionTier'] as String?;
    return status == 'active' &&
        tier != null &&
        tier != 'free' &&
        tier != 'candidate_free';
  }

  /// Returns the current plan definition for the user, defaulting to free.
  Future<Map<String, dynamic>?> getUserPlan(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (!doc.exists) return plans['candidate_free'];
    final tier = doc.data()?['subscriptionTier'] as String?;
    if (tier == null || tier == 'free') return plans['candidate_free'];
    return plans[tier] ?? plans['candidate_free'];
  }

  /// Returns the most recent active subscription document, or null.
  Future<Map<String, dynamic>?> getActiveSubscription(String userId) async {
    final snap = await _db
        .collection('subscriptions')
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'active')
        .orderBy('activatedAt', descending: true)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    return snap.docs.first.data();
  }
}
