import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerPayments extends ConsumerWidget {
  const EmployerPayments({super.key});

  static const _transactions = [
    _Tx(date: '20 Mar 2026', desc: 'Professional Plan — March', amount: 'R2,499', credit: false),
    _Tx(date: '15 Mar 2026', desc: 'CV Unlock × 5', amount: 'R275', credit: false),
    _Tx(date: '10 Mar 2026', desc: 'Job Boost — Senior Developer', amount: 'R499', credit: false),
    _Tx(date: '05 Mar 2026', desc: 'ShieldIQ Credit', amount: 'R499', credit: true),
    _Tx(date: '20 Feb 2026', desc: 'Professional Plan — February', amount: 'R2,499', credit: false),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('Payments',
            style: GoogleFonts.inter(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Balance Card ──────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [HireIQTheme.primaryNavy, Color(0xFF243659)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Available Credits',
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.6))),
                  const SizedBox(height: 8),
                  Text('R499.00',
                      style: GoogleFonts.inter(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: Colors.white)),
                  const SizedBox(height: 4),
                  Text('From ShieldIQ guarantee credit',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: HireIQTheme.success)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HireIQTheme.amber,
                      foregroundColor: HireIQTheme.primaryNavy,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)),
                    ),
                    child: Text('Add Funds',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Transaction History ───────────────────────────────────────
            Text('Transaction History',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: HireIQTheme.primaryNavy)),
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
                children: _transactions.asMap().entries.map((e) {
                  final isLast = e.key == _transactions.length - 1;
                  final tx = e.value;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: (tx.credit ? HireIQTheme.success : HireIQTheme.primaryNavy)
                                    .withValues(alpha: 0.08),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                tx.credit
                                    ? Icons.add_rounded
                                    : Icons.remove_rounded,
                                size: 14,
                                color: tx.credit ? HireIQTheme.success : HireIQTheme.primaryNavy,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(tx.desc,
                                      style: GoogleFonts.inter(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: HireIQTheme.textPrimary)),
                                  Text(tx.date,
                                      style: GoogleFonts.inter(
                                          fontSize: 11, color: HireIQTheme.textMuted)),
                                ],
                              ),
                            ),
                            Text(
                              '${tx.credit ? '+' : '-'}${tx.amount}',
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: tx.credit ? HireIQTheme.success : HireIQTheme.primaryNavy),
                            ),
                          ],
                        ),
                      ),
                      if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
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

class _Tx {
  const _Tx({required this.date, required this.desc, required this.amount, required this.credit});
  final String date;
  final String desc;
  final String amount;
  final bool credit;
}
