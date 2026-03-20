import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateBillingSettingsWeb extends ConsumerWidget {
  const CandidateBillingSettingsWeb({super.key});

  static const _invoices = [
    _Inv('01 Mar 2026', 'HireIQ Pro — March 2026', 'R49.00', 'Paid'),
    _Inv('01 Feb 2026', 'HireIQ Pro — February 2026', 'R49.00', 'Paid'),
    _Inv('01 Jan 2026', 'HireIQ Pro — January 2026', 'R49.00', 'Paid'),
    _Inv('01 Dec 2025', 'HireIQ Pro — December 2025', 'R49.00', 'Paid'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Billing & Subscription', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Manage your plan and view payment history', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left — plan
            Expanded(child: Column(children: [
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [HireIQTheme.primaryNavy, Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: HireIQTheme.amber, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('PRO', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w900, color: HireIQTheme.primaryNavy))),
                    const Spacer(),
                    Text('Active', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.success, fontWeight: FontWeight.w700)),
                  ]),
                  const SizedBox(height: 16),
                  Text('R49', style: GoogleFonts.inter(fontSize: 44, fontWeight: FontWeight.w900, color: Colors.white)),
                  Text('/month', style: GoogleFonts.inter(fontSize: 14, color: Colors.white60)),
                  const SizedBox(height: 8),
                  Text('Next billing: 01 Apr 2026', style: GoogleFonts.inter(fontSize: 12, color: Colors.white60)),
                ]),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Plan Includes', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 14),
                  ...[
                    'Unlimited job applications',
                    'MatchIQ score for every job',
                    'ForgeIQ CV Builder with AI',
                    'UpliftIQ career coaching',
                    'PassportIQ verification badge',
                    'Priority profile placement',
                    'SmartApply bulk applications',
                  ].map((f) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(children: [
                      const Icon(Icons.check_circle_rounded, color: HireIQTheme.success, size: 16),
                      const SizedBox(width: 10),
                      Text(f, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textPrimary)),
                    ]),
                  )),
                ]),
              ),
              const SizedBox(height: 14),
              SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.error), foregroundColor: HireIQTheme.error, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Cancel Subscription', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)))),
            ])),
            const SizedBox(width: 28),
            // Right — invoices
            Expanded(flex: 2, child: Container(
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
                  child: Row(children: [
                    Text('Payment History', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                    const Spacer(),
                    Text('Payment method: Visa •••• 4242', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                  ]),
                ),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), color: HireIQTheme.background, child: Row(children: [_IH('Date', 2), _IH('Description', 3), _IH('Amount'), _IH('Status'), _IH('')])),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                ..._invoices.asMap().entries.map((e) {
                  final inv = e.value;
                  final isLast = e.key == _invoices.length - 1;
                  return Column(children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                      Expanded(flex: 2, child: Text(inv.date, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                      Expanded(flex: 3, child: Text(inv.description, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary))),
                      Expanded(child: Text(inv.amount, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
                      Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(inv.status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.success)))),
                      Expanded(child: TextButton.icon(onPressed: () {}, icon: const Icon(Icons.download_rounded, size: 14), label: Text('PDF', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)), style: TextButton.styleFrom(foregroundColor: HireIQTheme.primaryTeal))),
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

class _Inv {
  const _Inv(this.date, this.description, this.amount, this.status);
  final String date, description, amount, status;
}

Widget _IH(String t, [int flex = 1]) => Expanded(flex: flex, child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
