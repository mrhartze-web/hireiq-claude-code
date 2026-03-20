import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerBilling extends ConsumerWidget {
  const EmployerBilling({super.key});

  static const _invoices = [
    _Invoice(
        date: 'Mar 2026',
        description: 'Professional Plan — March',
        amount: 'R2,499',
        status: 'Paid'),
    _Invoice(
        date: 'Feb 2026',
        description: 'Professional Plan — February',
        amount: 'R2,499',
        status: 'Paid'),
    _Invoice(
        date: 'Jan 2026',
        description: 'Professional Plan + Talent Boost',
        amount: 'R3,299',
        status: 'Paid'),
    _Invoice(
        date: 'Dec 2025',
        description: 'Professional Plan — December',
        amount: 'R2,499',
        status: 'Paid'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            // ── Current Plan ──────────────────────────────────────────────
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Employer Professional',
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'R2,499/month',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.7)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Renews on 01 Apr 2026',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.5)),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: HireIQTheme.success.withValues(alpha: 0.2),
                            borderRadius:
                                BorderRadius.circular(HireIQTheme.radiusFull),
                          ),
                          child: Text(
                            '✓ Active',
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: HireIQTheme.success),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HireIQTheme.amber,
                      foregroundColor: HireIQTheme.primaryNavy,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusMd)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                    child: Text(
                      'Upgrade',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Usage Stats ───────────────────────────────────────────────
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

class _Invoice {
  const _Invoice(
      {required this.date,
      required this.description,
      required this.amount,
      required this.status});

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
