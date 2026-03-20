import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerBillingWeb extends ConsumerWidget {
  const EmployerBillingWeb({super.key});

  static const _invoices = [
    _Inv('INV-2026-003', 'Mar 2026', 'Pro Plan · 5 seats', 'R4,995', 'Paid'),
    _Inv('INV-2026-002', 'Feb 2026', 'Pro Plan · 5 seats', 'R4,995', 'Paid'),
    _Inv('INV-2026-001', 'Jan 2026', 'Pro Plan · 3 seats', 'R2,997', 'Paid'),
    _Inv('INV-2025-012', 'Dec 2025', 'Starter Plan · 2 seats', 'R1,598', 'Paid'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Billing & Subscription', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: plan card
            Expanded(child: Column(children: [
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(gradient: const LinearGradient(colors: [HireIQTheme.primaryNavy, Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), decoration: BoxDecoration(color: HireIQTheme.amber, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('EMPLOYER PRO', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy))),
                  const SizedBox(height: 16),
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text('R999', style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w800, color: Colors.white)),
                    Text('/seat/month', style: GoogleFonts.inter(fontSize: 13, color: Colors.white54)),
                  ]),
                  const SizedBox(height: 8),
                  Text('5 seats · Next billing 01 Apr 2026', style: GoogleFonts.inter(fontSize: 13, color: Colors.white70)),
                  const SizedBox(height: 20),
                  ...['Unlimited job postings', 'WildcardIQ AI matching', 'SignalIQ talent alerts', 'Full analytics dashboard', 'Priority support'].map((f) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(children: [const Icon(Icons.check_rounded, size: 14, color: HireIQTheme.success), const SizedBox(width: 8), Text(f, style: GoogleFonts.inter(fontSize: 13, color: Colors.white70))]))),
                ]),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Payment Method', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 14),
                  Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: HireIQTheme.primaryNavy, borderRadius: BorderRadius.circular(HireIQTheme.radiusSm)), child: Text('VISA', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white))), const SizedBox(width: 12), Text('•••• •••• •••• 4832', style: GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textPrimary)), const Spacer(), TextButton(onPressed: () {}, child: Text('Update', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.primaryTeal, fontWeight: FontWeight.w600)))]),
                ]),
              ),
            ])),
            const SizedBox(width: 28),
            // Right: invoice history
            Expanded(child: Container(
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(children: [
                Padding(padding: const EdgeInsets.all(20), child: Row(children: [Text('Invoice History', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)), const Spacer(), OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download_rounded, size: 14), label: Text('Export All', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)), style: OutlinedButton.styleFrom(foregroundColor: HireIQTheme.primaryNavy, side: const BorderSide(color: HireIQTheme.borderMedium), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))))])),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), color: HireIQTheme.background, child: Row(children: [_BH('Invoice', 2), _BH('Period'), _BH('Description', 2), _BH('Amount'), _BH('Status'), _BH('')])),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                ..._invoices.asMap().entries.map((e) {
                  final inv = e.value;
                  final isLast = e.key == _invoices.length - 1;
                  return Column(children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                      Expanded(flex: 2, child: Text(inv.id, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy))),
                      Expanded(child: Text(inv.period, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                      Expanded(flex: 2, child: Text(inv.desc, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                      Expanded(child: Text(inv.amount, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary))),
                      Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(inv.status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.success)))),
                      Expanded(child: IconButton(icon: const Icon(Icons.download_rounded, size: 16, color: HireIQTheme.primaryNavy), onPressed: () {})),
                    ])),
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

class _Inv { const _Inv(this.id, this.period, this.desc, this.amount, this.status); final String id, period, desc, amount, status; }
Widget _BH(String t, [int flex = 1]) => Expanded(flex: flex, child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
