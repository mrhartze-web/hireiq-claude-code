import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateReferralWeb extends ConsumerWidget {
  const CandidateReferralWeb({super.key});

  static const _referrals = [
    _Ref('Bongani Dlamini', 'Signed up', '10 Mar 2026', false),
    _Ref('Zanele Mokoena', 'Subscribed to Pro', '05 Mar 2026', true),
    _Ref('Sipho Khumalo', 'Signed up', '27 Feb 2026', false),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Refer & Earn', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Earn R100 credit for every friend who subscribes to HireIQ Pro', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Earn
            Expanded(child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [HireIQTheme.amber, Color(0xFFF7B731)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Your Referral Earnings', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 8),
                Text('R100', style: GoogleFonts.inter(fontSize: 44, fontWeight: FontWeight.w900, color: HireIQTheme.primaryNavy)),
                Text('earned from 1 paid referral', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.primaryNavy.withValues(alpha: 0.7))),
                const SizedBox(height: 16),
                Row(children: [
                  _REStat('3', 'Total Referred'),
                  const SizedBox(width: 20),
                  _REStat('1', 'Paid'),
                  const SizedBox(width: 20),
                  _REStat('R100', 'Earned'),
                ]),
              ]),
            )),
            const SizedBox(width: 20),
            // Referral code
            Expanded(child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Your Referral Code', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 14),
                Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.borderMedium)), child: Row(children: [
                  Text('THABO2026', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 3, color: HireIQTheme.primaryNavy)),
                  const Spacer(),
                  IconButton(icon: const Icon(Icons.copy_rounded, color: HireIQTheme.primaryTeal), onPressed: () {}),
                ])),
                const SizedBox(height: 14),
                Text('Share your referral link:', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                const SizedBox(height: 6),
                Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), decoration: BoxDecoration(color: HireIQTheme.background, borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.borderLight)), child: Row(children: [
                  Expanded(child: Text('hireiq.co.za/ref/THABO2026', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.primaryTeal))),
                  IconButton(icon: const Icon(Icons.share_rounded, size: 16, color: HireIQTheme.primaryTeal), onPressed: () {}),
                ])),
                const SizedBox(height: 14),
                Row(children: [
                  Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.email_rounded, size: 14), label: Text('Email', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.primaryNavy, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 11), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))))),
                  const SizedBox(width: 10),
                  Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.share_rounded, size: 14), label: Text('WhatsApp', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.success, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 11), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))))),
                ]),
              ]),
            )),
            const SizedBox(width: 20),
            // History
            Expanded(child: Container(
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(children: [
                Padding(padding: const EdgeInsets.fromLTRB(18, 16, 18, 12), child: Text('Referral History', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                ..._referrals.asMap().entries.map((e) {
                  final r = e.value;
                  final isLast = e.key == _referrals.length - 1;
                  return Column(children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14), child: Row(children: [
                      CircleAvatar(radius: 16, backgroundColor: HireIQTheme.primaryNavy.withValues(alpha: 0.1), child: Text(r.name[0], style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy))),
                      const SizedBox(width: 10),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(r.name, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)), Text(r.date, style: GoogleFonts.inter(fontSize: 10, color: HireIQTheme.textMuted))])),
                      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: (r.earned ? HireIQTheme.success : HireIQTheme.textMuted).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(r.status, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: r.earned ? HireIQTheme.success : HireIQTheme.textMuted))),
                        if (r.earned) Text('+R100', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: HireIQTheme.success)),
                      ]),
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

class _Ref {
  const _Ref(this.name, this.status, this.date, this.earned);
  final String name, status, date;
  final bool earned;
}

Widget _REStat(String v, String l) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(v, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w900, color: HireIQTheme.primaryNavy)), Text(l, style: GoogleFonts.inter(fontSize: 10, color: HireIQTheme.primaryNavy.withValues(alpha: 0.7)))]);
