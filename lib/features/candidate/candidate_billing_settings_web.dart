import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateBillingSettingsWeb extends ConsumerWidget {
  const CandidateBillingSettingsWeb({super.key});

  static const _invoices = [
    _Invoice('INV-2026-003', '01 Mar 2026', 'Pro Monthly', 'R299', 'Paid'),
    _Invoice('INV-2026-002', '01 Feb 2026', 'Pro Monthly', 'R299', 'Paid'),
    _Invoice('INV-2026-001', '01 Jan 2026', 'Pro Monthly', 'R299', 'Paid'),
    _Invoice('INV-2025-012', '01 Dec 2025', 'Pro Monthly', 'R299', 'Paid'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Billing & Subscription', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Manage your subscription and payment history', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 32),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: Plan card
            Expanded(flex: 2, child: Column(children: [
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [HireIQTheme.primaryNavy, Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: HireIQTheme.amber, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('Pro', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy))),
                    const Spacer(),
                    Text('ACTIVE', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.success)),
                  ]),
                  const SizedBox(height: 16),
                  Text('R299', style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w800, color: Colors.white)),
                  Text('per month', style: GoogleFonts.inter(fontSize: 13, color: Colors.white60)),
                  const SizedBox(height: 20),
                  ...['Unlimited job applications', 'MatchIQ score visibility', 'ForgeIQ CV builder', 'UpliftIQ recommendations', 'Priority support'].map((f) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(children: [
                      const Icon(Icons.check_circle_rounded, color: HireIQTheme.success, size: 16),
                      const SizedBox(width: 8),
                      Text(f, style: GoogleFonts.inter(fontSize: 13, color: Colors.white.withValues(alpha: 0.85))),
                    ]),
                  )),
                  const SizedBox(height: 20),
                  Text('Next billing: 01 Apr 2026', style: GoogleFonts.inter(fontSize: 12, color: Colors.white54)),
                ]),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Payment Method', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 12),
                  Row(children: [
                    Container(width: 40, height: 26, color: HireIQTheme.info, child: Center(child: Text('VISA', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white)))),
                    const SizedBox(width: 12),
                    Text('•••• •••• •••• 4242', style: GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textPrimary)),
                    const Spacer(),
                    TextButton(onPressed: () {}, child: Text('Update', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.primaryTeal, fontWeight: FontWeight.w600))),
                  ]),
                ]),
              ),
              const SizedBox(height: 12),
              SizedBox(width: double.infinity, child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, padding: const EdgeInsets.symmetric(vertical: 14), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))),
                child: Text('Cancel Subscription', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
              )),
            ])),
            const SizedBox(width: 28),
            // Right: Invoice table
            Expanded(flex: 3, child: Container(
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(children: [
                    Text('Invoice History', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                    const Spacer(),
                    TextButton.icon(onPressed: () {}, icon: const Icon(Icons.download_rounded, size: 14, color: HireIQTheme.primaryTeal), label: Text('Export All', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.primaryTeal, fontWeight: FontWeight.w600))),
                  ]),
                ),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  color: HireIQTheme.background,
                  child: Row(children: [
                    _ITH('Invoice No.', flex: 2), _ITH('Date', flex: 2), _ITH('Description', flex: 2), _ITH('Amount', flex: 1), _ITH('Status', flex: 1), _ITH('', flex: 1),
                  ]),
                ),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                ..._invoices.asMap().entries.map((e) {
                  final inv = e.value;
                  final isLast = e.key == _invoices.length - 1;
                  return Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      child: Row(children: [
                        Expanded(flex: 2, child: Text(inv.id, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary))),
                        Expanded(flex: 2, child: Text(inv.date, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                        Expanded(flex: 2, child: Text(inv.desc, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                        Expanded(flex: 1, child: Text(inv.amount, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary))),
                        Expanded(flex: 1, child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: HireIQTheme.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
                          child: Text(inv.status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.success)),
                        )),
                        Expanded(flex: 1, child: IconButton(onPressed: () {}, icon: const Icon(Icons.download_outlined, size: 16, color: HireIQTheme.primaryTeal), tooltip: 'Download')),
                      ]),
                    ),
                    if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                  ]);
                }),
              ]),
            )),
          ]),
        ]),
      ),
    );
  }
}

class _Invoice {
  const _Invoice(this.id, this.date, this.desc, this.amount, this.status);
  final String id, date, desc, amount, status;
}

Widget _ITH(String label, {int flex = 1}) => Expanded(flex: flex, child: Text(label, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
