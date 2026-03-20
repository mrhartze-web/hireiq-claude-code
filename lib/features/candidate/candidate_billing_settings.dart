import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateBillingSettings extends ConsumerStatefulWidget {
  const CandidateBillingSettings({super.key});

  @override
  ConsumerState<CandidateBillingSettings> createState() =>
      _CandidateBillingSettingsState();
}

class _CandidateBillingSettingsState
    extends ConsumerState<CandidateBillingSettings> {
  String _currentPlan = 'Professional';

  static const _plans = [
    _Plan(
      name: 'Free',
      price: 'R0',
      period: 'Forever',
      features: [
        '5 applications/month',
        'Basic MatchIQ score',
        'Standard job alerts',
      ],
      isCurrent: false,
      isRecommended: false,
    ),
    _Plan(
      name: 'Professional',
      price: 'R199',
      period: 'per month',
      features: [
        'Unlimited applications',
        'Full MatchIQ AI matching',
        'ForgeIQ CV builder',
        'Priority job alerts',
        'Salary benchmarks',
      ],
      isCurrent: true,
      isRecommended: true,
    ),
    _Plan(
      name: 'Elite',
      price: 'R499',
      period: 'per month',
      features: [
        'Everything in Professional',
        '1-on-1 career coaching',
        'ShieldIQ deal protection',
        'Guaranteed interview prep',
        'Dedicated account manager',
      ],
      isCurrent: false,
      isRecommended: false,
    ),
  ];

  static const _invoices = [
    _Invoice(date: 'Mar 2026', amount: 'R199.00', status: 'Paid'),
    _Invoice(date: 'Feb 2026', amount: 'R199.00', status: 'Paid'),
    _Invoice(date: 'Jan 2026', amount: 'R199.00', status: 'Paid'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Plans & Billing',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Plans ─────────────────────────────────────────────────────
            Text(
              'Choose Your Plan',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 12),
            ..._plans.map((p) => _PlanCard(
                  plan: p,
                  isSelected: _currentPlan == p.name,
                  onSelect: () {
                    if (!p.isCurrent) {
                      setState(() => _currentPlan = p.name);
                    }
                  },
                )),
            const SizedBox(height: 24),

            // ── Payment Method ────────────────────────────────────────────
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
                      color: const Color(0xFF1A2B4A).withValues(alpha: 0.08),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusSm),
                    ),
                    child: Text(
                      'VISA',
                      style: GoogleFonts.inter(
                          fontSize: 13,
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
                          '•••• •••• •••• 4821',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: HireIQTheme.primaryNavy),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Expires 09/28',
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

            // ── Next Billing Date ─────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                border: Border.all(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.25)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined,
                      size: 16, color: HireIQTheme.primaryTeal),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Next charge: R199.00 on 01 Apr 2026',
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: HireIQTheme.primaryTeal),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: HireIQTheme.error,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Invoice History ───────────────────────────────────────────
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
          ],
        ),
      ),
    );
  }
}

class _Plan {
  const _Plan({
    required this.name,
    required this.price,
    required this.period,
    required this.features,
    required this.isCurrent,
    required this.isRecommended,
  });

  final String name;
  final String price;
  final String period;
  final List<String> features;
  final bool isCurrent;
  final bool isRecommended;
}

class _Invoice {
  const _Invoice(
      {required this.date, required this.amount, required this.status});
  final String date;
  final String amount;
  final String status;
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.plan,
    required this.isSelected,
    required this.onSelect,
  });

  final _Plan plan;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    final isRecommended = plan.isRecommended;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
          color: isSelected
              ? HireIQTheme.primaryNavy
              : HireIQTheme.borderLight,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy
                .withValues(alpha: isSelected ? 0.08 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
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
                    Row(
                      children: [
                        Text(
                          plan.name,
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: HireIQTheme.primaryNavy),
                        ),
                        if (isRecommended) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: HireIQTheme.amber
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(
                                  HireIQTheme.radiusFull),
                            ),
                            child: Text(
                              'Most Popular',
                              style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: HireIQTheme.amber),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.inter(
                            color: HireIQTheme.primaryNavy),
                        children: [
                          TextSpan(
                            text: plan.price,
                            style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.w800),
                          ),
                          TextSpan(
                            text: ' ${plan.period}',
                            style: GoogleFonts.inter(
                                fontSize: 12, color: HireIQTheme.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (plan.isCurrent)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: HireIQTheme.success.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: Text(
                    'Active',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.success),
                  ),
                )
              else
                ElevatedButton(
                  onPressed: onSelect,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRecommended
                        ? HireIQTheme.amber
                        : HireIQTheme.primaryNavy,
                    foregroundColor: isRecommended
                        ? HireIQTheme.primaryNavy
                        : Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd)),
                  ),
                  child: Text(
                    isSelected ? 'Selected' : 'Upgrade',
                    style:
                        GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          ...plan.features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline_rounded,
                      size: 14, color: HireIQTheme.primaryTeal),
                  const SizedBox(width: 6),
                  Text(
                    f,
                    style: GoogleFonts.inter(
                        fontSize: 13, color: HireIQTheme.textPrimary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
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
          const Icon(Icons.receipt_outlined, size: 18, color: HireIQTheme.textMuted),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Professional Plan — ${invoice.date}',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: HireIQTheme.textPrimary),
            ),
          ),
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
