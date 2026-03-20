import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateSubscriptionUpgradeWeb extends ConsumerWidget {
  const CandidateSubscriptionUpgradeWeb({super.key});

  static const _features = [
    _Feat('Job Applications', 'Limited (5/month)', 'Unlimited'),
    _Feat('MatchIQ Score', 'Basic', 'Full breakdown + tips'),
    _Feat('ForgeIQ CV Builder', false, true),
    _Feat('UpliftIQ Recommendations', false, true),
    _Feat('PassportIQ Verification', false, true),
    _Feat('Salary Intelligence', false, true),
    _Feat('Priority Matching', false, true),
    _Feat('Support', 'Email only', 'Priority + WhatsApp'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Column(children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), decoration: BoxDecoration(color: HireIQTheme.amber.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('LIMITED OFFER', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: HireIQTheme.amber))),
            const SizedBox(height: 12),
            Text('Unlock Your Full Potential', style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 8),
            Text('Upgrade to Pro and get noticed by top SA employers', style: GoogleFonts.inter(fontSize: 16, color: HireIQTheme.textMuted)),
          ])),
          const SizedBox(height: 40),
          // Comparison grid
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Free plan
            Expanded(child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Free', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: HireIQTheme.textPrimary)),
                Text('R0 / month', style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w800, color: HireIQTheme.textPrimary)),
                const SizedBox(height: 24),
                ..._features.map((f) => _FeatureRow(f.title, _featureStr(f.free), false)),
                const SizedBox(height: 24),
                SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.borderMedium), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Current Plan', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)))),
              ]),
            )),
            const SizedBox(width: 20),
            // Pro plan
            Expanded(child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [HireIQTheme.primaryNavy, Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.amber.withValues(alpha: 0.4))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Text('Pro', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                  const SizedBox(width: 10),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: HireIQTheme.amber, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('POPULAR', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy))),
                ]),
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text('R299', style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white)),
                  Text(' / month', style: GoogleFonts.inter(fontSize: 14, color: Colors.white60)),
                ]),
                const SizedBox(height: 24),
                ..._features.map((f) => _ProFeatureRow(f.title, _featureStr(f.pro))),
                const SizedBox(height: 24),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Upgrade to Pro', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 15)))),
                const SizedBox(height: 12),
                Center(child: Text('Cancel anytime · No contracts', style: GoogleFonts.inter(fontSize: 12, color: Colors.white54))),
              ]),
            )),
          ]),
          const SizedBox(height: 32),
          // Savings calculator
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.2))),
            child: Row(children: [
              const Icon(Icons.calculate_rounded, color: HireIQTheme.primaryTeal, size: 28),
              const SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('ROI Calculator', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                Text('Get hired just once — average first-month salary via HireIQ Pro: R75,000. Pro subscription: R299/month = 250× return on investment.', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)),
              ])),
              Text('250×', style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal)),
            ]),
          ),
        ]),
      ),
    );
  }

  String _featureStr(dynamic v) => v is bool ? (v ? '✓' : '✗') : v.toString();
}

String _featureStr2(dynamic v) => v is bool ? (v ? '✓' : '✗') : v.toString();

Widget _FeatureRow(String title, String value, bool isPro) => Padding(
  padding: const EdgeInsets.only(bottom: 12),
  child: Row(children: [
    Expanded(child: Text(title, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textPrimary))),
    Text(value, style: GoogleFonts.inter(fontSize: 13, color: value == '✗' ? HireIQTheme.textMuted : HireIQTheme.textPrimary, fontWeight: FontWeight.w600)),
  ]),
);

Widget _ProFeatureRow(String title, String value) => Padding(
  padding: const EdgeInsets.only(bottom: 12),
  child: Row(children: [
    Expanded(child: Text(title, style: GoogleFonts.inter(fontSize: 13, color: Colors.white70))),
    Text(value, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.success, fontWeight: FontWeight.w700)),
  ]),
);

class _Feat { const _Feat(this.title, this.free, this.pro); final String title; final dynamic free, pro; }
