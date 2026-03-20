import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateReferralWeb extends ConsumerWidget {
  const CandidateReferralWeb({super.key});

  static const _referred = [
    _Ref2('Nomvula Dlamini', 'nomvula@email.co.za', '15 Mar 2026', 'Signed up', HireIQTheme.success),
    _Ref2('Ayanda Nkosi', 'ayanda@email.co.za', '10 Mar 2026', 'Applied', HireIQTheme.primaryTeal),
    _Ref2('Priya Naidoo', 'priya@email.co.za', '01 Mar 2026', 'Pending', HireIQTheme.warning),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Referral Programme', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Earn rewards for every friend you bring onto HireIQ', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          // Stats row
          Row(children: [
            _RStat('Friends Referred', '3', Icons.people_rounded, HireIQTheme.primaryNavy),
            const SizedBox(width: 16),
            _RStat('Rewards Earned', 'R150', Icons.card_giftcard_rounded, HireIQTheme.success),
            const SizedBox(width: 16),
            _RStat('Pending', 'R50', Icons.hourglass_empty_rounded, HireIQTheme.warning),
          ]),
          const SizedBox(height: 28),
          // Referral link card
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [HireIQTheme.primaryNavy, Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Your Referral Link', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)),
                  child: Row(children: [
                    Expanded(child: Text('hireiq.co.za/join?ref=THABO2026', style: GoogleFonts.inter(fontSize: 13, color: Colors.white))),
                    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Copy', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700))),
                  ]),
                ),
              ])),
              const SizedBox(width: 32),
              Column(children: [
                Text('Earn per referral', style: GoogleFonts.inter(fontSize: 13, color: Colors.white54)),
                Text('R50', style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w800, color: HireIQTheme.amber)),
                Text('when they sign up', style: GoogleFonts.inter(fontSize: 11, color: Colors.white54)),
              ]),
            ]),
          ),
          const SizedBox(height: 28),
          // How it works
          Text('How It Works', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 16),
          Row(children: [
            _HowStep('1', 'Share Your Link', 'Send your unique referral link to friends or post on social media'),
            const SizedBox(width: 16),
            _HowStep('2', 'They Sign Up', 'Your friend creates a HireIQ account using your link'),
            const SizedBox(width: 16),
            _HowStep('3', 'You Both Win', 'You earn R50, they get 1 month Pro free'),
          ]),
          const SizedBox(height: 28),
          // Referred friends table
          Text('Your Referrals', style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), color: HireIQTheme.background, child: Row(children: [_RTH('Name', flex: 2), _RTH('Email', flex: 2), _RTH('Date', flex: 2), _RTH('Status')])),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              ..._referred.asMap().entries.map((e) {
                final r = e.value;
                final isLast = e.key == _referred.length - 1;
                return Column(children: [
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                    Expanded(flex: 2, child: Text(r.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary))),
                    Expanded(flex: 2, child: Text(r.email, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                    Expanded(flex: 2, child: Text(r.date, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                    Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: r.statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(r.status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: r.statusColor)))),
                  ])),
                  if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                ]);
              }),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _Ref2 { const _Ref2(this.name, this.email, this.date, this.status, this.statusColor); final String name, email, date, status; final Color statusColor; }
Widget _RTH(String l, {int flex = 1}) => Expanded(flex: flex, child: Text(l, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
Widget _RStat(String label, String value, IconData icon, Color color) => Expanded(child: Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Row(children: [Icon(icon, color: color, size: 24), const SizedBox(width: 14), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value, style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w800, color: color)), Text(label, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))])])));
Widget _HowStep(String num, String title, String desc) => Expanded(child: Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [CircleAvatar(radius: 16, backgroundColor: HireIQTheme.primaryNavy, child: Text(num, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white))), const SizedBox(height: 12), Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)), const SizedBox(height: 6), Text(desc, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))])));
