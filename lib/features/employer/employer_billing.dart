import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_provider.dart';
import '../../providers/subscription_provider.dart';
import '../../services/payments/subscription_service.dart';
import '../../shared/theme.dart';

class EmployerBilling extends ConsumerStatefulWidget {
  const EmployerBilling({super.key});

  @override
  ConsumerState<EmployerBilling> createState() => _EmployerBillingState();
}

class _EmployerBillingState extends ConsumerState<EmployerBilling> {
  String? _upgradingPlanId;

  static const _invoices = [
    _Invoice(
        date: 'Mar 2026',
        description: 'Employer Starter — March',
        amount: 'R799',
        status: 'Paid'),
    _Invoice(
        date: 'Feb 2026',
        description: 'Employer Starter — February',
        amount: 'R799',
        status: 'Paid'),
    _Invoice(
        date: 'Jan 2026',
        description: 'Employer Starter — January',
        amount: 'R799',
        status: 'Paid'),
    _Invoice(
        date: 'Dec 2025',
        description: 'Employer Starter — December',
        amount: 'R799',
        status: 'Paid'),
  ];

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  Future<void> _upgrade(String planId) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return;
    setState(() => _upgradingPlanId = planId);
    try {
      await SubscriptionService().initiateSubscription(
        userId: user.uid,
        planId: planId,
        userEmail: user.email ?? '',
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Redirecting to secure payment — powered by Peach Payments'),
          backgroundColor: HireIQTheme.primaryNavy,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment error: ${e.toString()}'),
          backgroundColor: HireIQTheme.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _upgradingPlanId = null);
    }
  }

  @override
  Widget build(BuildContext context, ) {
    final uid = ref.watch(authStateProvider).value?.uid ?? '';
    final userAsync = ref.watch(currentUserProvider);
    final planAsync = ref.watch(currentUserPlanProvider);
    final activeSubAsync = ref.watch(activeSubscriptionProvider(uid));

    final subscriptionStatus =
        userAsync.value?.subscriptionStatus ?? 'inactive';
    final isActive = subscriptionStatus == 'active';

    // Real plan data from Firestore
    final plan = planAsync.value ?? SubscriptionService.plans['employer_starter']!;
    final planName = plan['name'] as String? ?? 'Employer Starter';
    final planPrice = (plan['price'] as num?)?.toDouble() ?? 799.0;
    final planFeatures =
        (plan['features'] as List?)?.map((e) => e.toString()).toList() ?? [];

    // Next billing date
    String nextBillingText = '';
    activeSubAsync.whenData((sub) {
      if (sub != null && sub['nextBillingDate'] is Timestamp) {
        final d = (sub['nextBillingDate'] as Timestamp).toDate();
        nextBillingText =
            '${d.day.toString().padLeft(2, '0')} ${_monthName(d.month)} ${d.year}';
      }
    });

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Billing & Invoices',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Current Plan ──────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [HireIQTheme.primaryNavy, Color(0xFF243659)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
              ),
              child: planAsync.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white))
                  : Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                planName,
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'R${planPrice.toStringAsFixed(0)}/month',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color:
                                        Colors.white.withValues(alpha: 0.7)),
                              ),
                              if (nextBillingText.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                Text(
                                  'Renews $nextBillingText',
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.white
                                          .withValues(alpha: 0.5)),
                                ),
                              ],
                              const SizedBox(height: 14),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? HireIQTheme.success
                                          .withValues(alpha: 0.2)
                                      : HireIQTheme.amber
                                          .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(
                                      HireIQTheme.radiusFull),
                                ),
                                child: Text(
                                  isActive ? '✓ Active' : '⚠ Inactive',
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: isActive
                                          ? HireIQTheme.success
                                          : HireIQTheme.amber),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 24),

            // ── Usage Stats ───────────────────────────────────────────
            Text(
              'Monthly Usage',
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(color: HireIQTheme.borderLight),
                boxShadow: [
                  BoxShadow(
                    color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _UsageRow('Active Job Posts', '3 / 10'),
                  const SizedBox(height: 12),
                  _UsageRow('CV Database Unlocks', '47 / 100'),
                  const SizedBox(height: 12),
                  _UsageRow('MatchIQ AI Matches', '234 / 500'),
                  const SizedBox(height: 12),
                  _UsageRow('Team Seats', '2 / 5'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Upgrade Plans ─────────────────────────────────────────
            Text(
              'Upgrade Your Plan',
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 12),
            _UpgradePlanTile(
              name: 'Employer Starter',
              planId: 'employer_starter',
              price: 'R799/month',
              features: SubscriptionService
                      .plans['employer_starter']?['features']
                      as List? ??
                  [],
              isLoading: _upgradingPlanId == 'employer_starter',
              onTap: () => _upgrade('employer_starter'),
            ),
            const SizedBox(height: 10),
            _UpgradePlanTile(
              name: 'Employer Growth',
              planId: 'employer_growth',
              price: 'R3,999/month',
              features: SubscriptionService
                      .plans['employer_growth']?['features']
                      as List? ??
                  [],
              isHighlighted: true,
              isLoading: _upgradingPlanId == 'employer_growth',
              onTap: () => _upgrade('employer_growth'),
            ),
            const SizedBox(height: 8),
            // Peach badge below upgrade section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock,
                    size: 14, color: HireIQTheme.textMuted),
                const SizedBox(width: 4),
                Text(
                  'Secured by Peach Payments',
                  style: GoogleFonts.inter(
                      fontSize: 11, color: HireIQTheme.textMuted),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── Payment Method ────────────────────────────────────────
            Text(
              'Payment Method',
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(color: HireIQTheme.borderLight),
                boxShadow: [
                  BoxShadow(
                    color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: HireIQTheme.primaryNavy.withValues(alpha: 0.08),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusSm),
                    ),
                    child: Text(
                      'EFT',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: HireIQTheme.primaryNavy),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FNB Business Account',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: HireIQTheme.primaryNavy),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Acc: •••• 7732 • ABSA',
                          style: GoogleFonts.inter(
                              fontSize: 12, color: HireIQTheme.textMuted),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Change',
                      style: GoogleFonts.inter(
                          color: HireIQTheme.primaryTeal,
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Invoice History ───────────────────────────────────────
            Text(
              'Invoice History',
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(color: HireIQTheme.borderLight),
                boxShadow: [
                  BoxShadow(
                    color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: _invoices.asMap().entries.map((e) {
                  final isLast = e.key == _invoices.length - 1;
                  return Column(
                    children: [
                      _InvoiceRow(invoice: e.value),
                      if (!isLast)
                        const Divider(
                            height: 1, color: HireIQTheme.borderLight),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 28),

            // ── Peach trust note ──────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: HireIQTheme.background,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock,
                      size: 14, color: HireIQTheme.textMuted),
                  const SizedBox(width: 6),
                  Text(
                    'Payments secured by Peach Payments',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: HireIQTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Upgrade plan tile ─────────────────────────────────────────────────────────

class _UpgradePlanTile extends StatelessWidget {
  const _UpgradePlanTile({
    required this.name,
    required this.planId,
    required this.price,
    required this.features,
    required this.isLoading,
    required this.onTap,
    this.isHighlighted = false,
  });

  final String name;
  final String planId;
  final String price;
  final List features;
  final bool isLoading;
  final VoidCallback onTap;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHighlighted
            ? HireIQTheme.primaryNavy
            : HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
          color: isHighlighted
              ? HireIQTheme.primaryNavy
              : HireIQTheme.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isHighlighted
                            ? Colors.white
                            : HireIQTheme.primaryNavy,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      price,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isHighlighted
                            ? Colors.white.withValues(alpha: 0.75)
                            : HireIQTheme.primaryTeal,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: isLoading ? null : onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isHighlighted ? HireIQTheme.amber : HireIQTheme.primaryTeal,
                  foregroundColor: isHighlighted
                      ? HireIQTheme.primaryNavy
                      : Colors.white,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusMd)),
                ),
                child: isLoading
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: isHighlighted
                              ? HireIQTheme.primaryNavy
                              : Colors.white,
                        ),
                      )
                    : Text('Upgrade',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700, fontSize: 13)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: features
                .map((f) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_rounded,
                            size: 13,
                            color: isHighlighted
                                ? Colors.white.withValues(alpha: 0.8)
                                : HireIQTheme.primaryTeal),
                        const SizedBox(width: 4),
                        Text(
                          f.toString(),
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: isHighlighted
                                ? Colors.white.withValues(alpha: 0.8)
                                : HireIQTheme.textSecondary,
                          ),
                        ),
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ── Helpers ───────────────────────────────────────────────────────────────────

class _Invoice {
  const _Invoice({
    required this.date,
    required this.description,
    required this.amount,
    required this.status,
  });

  final String date;
  final String description;
  final String amount;
  final String status;
}

Widget _UsageRow(String label, String usage) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: HireIQTheme.textPrimary),
      ),
      Text(
        usage,
        style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: HireIQTheme.primaryNavy),
      ),
    ],
  );
}

class _InvoiceRow extends StatelessWidget {
  const _InvoiceRow({required this.invoice});
  final _Invoice invoice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          const Icon(Icons.receipt_long_outlined,
              size: 18, color: HireIQTheme.textMuted),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoice.description,
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.textPrimary),
                ),
                Text(
                  invoice.date,
                  style: GoogleFonts.inter(
                      fontSize: 11, color: HireIQTheme.textMuted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            invoice.amount,
            style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: HireIQTheme.primaryNavy),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.download_outlined,
                size: 16, color: HireIQTheme.primaryTeal),
          ),
        ],
      ),
    );
  }
}
