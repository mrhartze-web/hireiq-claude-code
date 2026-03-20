import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateSubscriptionUpgradeWeb extends ConsumerStatefulWidget {
  const CandidateSubscriptionUpgradeWeb({super.key});
  @override
  ConsumerState<CandidateSubscriptionUpgradeWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateSubscriptionUpgradeWeb> {
  bool _annual = false;

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text('Upgrade Your Plan', style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w900, color: HireIQTheme.primaryNavy), textAlign: TextAlign.center),
          Text('Unlock South Africa\'s most powerful AI recruitment tools', style: GoogleFonts.inter(fontSize: 16, color: HireIQTheme.textMuted), textAlign: TextAlign.center),
          const SizedBox(height: 20),
          // Billing toggle
          Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: HireIQTheme.background, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), border: Border.all(color: HireIQTheme.borderLight)), child: Row(mainAxisSize: MainAxisSize.min, children: [
            GestureDetector(onTap: () => setState(() => _annual = false), child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), decoration: BoxDecoration(color: !_annual ? HireIQTheme.surfaceWhite : Colors.transparent, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), boxShadow: !_annual ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : null), child: Text('Monthly', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: !_annual ? HireIQTheme.primaryNavy : HireIQTheme.textMuted)))),
            GestureDetector(onTap: () => setState(() => _annual = true), child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), decoration: BoxDecoration(color: _annual ? HireIQTheme.surfaceWhite : Colors.transparent, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), boxShadow: _annual ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : null), child: Row(children: [Text('Annual', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: _annual ? HireIQTheme.primaryNavy : HireIQTheme.textMuted)), const SizedBox(width: 6), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: HireIQTheme.success, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('Save 20%', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w800, color: Colors.white)))]))),
          ])),
          const SizedBox(height: 28),
          // Plans row
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _PlanCard(name: 'Free', price: 'R0', period: 'forever', color: HireIQTheme.textMuted, current: true, annual: _annual, features: const ['3 job applications/month', 'Basic MatchIQ score', 'Profile creation', 'Community forum access']),
            const SizedBox(width: 16),
            _PlanCard(name: 'Pro', price: _annual ? 'R39' : 'R49', period: '/month', color: HireIQTheme.primaryTeal, recommended: true, annual: _annual, features: const ['Unlimited applications', 'Full MatchIQ score + insights', 'ForgeIQ CV Builder', 'SmartApply bulk apply', 'UpliftIQ career coaching', 'Interview prep tools', 'PassportIQ verification', 'Priority profile placement']),
            const SizedBox(width: 16),
            _PlanCard(name: 'Elite', price: _annual ? 'R79' : 'R99', period: '/month', color: HireIQTheme.primaryNavy, annual: _annual, features: const ['Everything in Pro', 'Dedicated career coach', 'Salary negotiation training', 'Executive job access', 'LinkedIn profile optimisation', '1-on-1 interview mock sessions', 'WildcardIQ personality report', 'Gig marketplace access']),
          ]),
          const SizedBox(height: 24),
          // Feature comparison table
          Container(
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Table(columnWidths: const {0: FlexColumnWidth(3), 1: FlexColumnWidth(), 2: FlexColumnWidth(), 3: FlexColumnWidth()}, children: [
              TableRow(decoration: const BoxDecoration(color: HireIQTheme.background, borderRadius: BorderRadius.vertical(top: Radius.circular(HireIQTheme.radiusLg))), children: [_FH('Feature'), _FH('Free'), _FH('Pro'), _FH('Elite')]),
              ...[
                ('Unlimited Applications', false, true, true),
                ('Full MatchIQ Score', false, true, true),
                ('ForgeIQ CV Builder', false, true, true),
                ('Interview Prep', false, true, true),
                ('1-on-1 Coaching', false, false, true),
                ('Executive Job Board', false, false, true),
              ].map((r) => TableRow(children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Text(r.$1, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textPrimary))),
                _FC(r.$2),
                _FC(r.$3),
                _FC(r.$4),
              ])),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.name, required this.price, required this.period, required this.color, required this.features, required this.annual, this.current = false, this.recommended = false});
  final String name, price, period;
  final Color color;
  final List<String> features;
  final bool current, recommended, annual;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: recommended ? HireIQTheme.primaryTeal : HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: recommended ? HireIQTheme.primaryTeal : HireIQTheme.borderLight, width: recommended ? 2 : 1), boxShadow: recommended ? [BoxShadow(color: HireIQTheme.primaryTeal.withValues(alpha: 0.15), blurRadius: 16, offset: const Offset(0, 4))] : null),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (recommended) Align(alignment: Alignment.centerRight, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: HireIQTheme.amber, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('RECOMMENDED', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w900, color: HireIQTheme.primaryNavy)))),
        Text(name, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w900, color: recommended ? Colors.white : color)),
        const SizedBox(height: 8),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(price, style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w900, color: recommended ? Colors.white : HireIQTheme.primaryNavy)),
          Text(period, style: GoogleFonts.inter(fontSize: 13, color: recommended ? Colors.white70 : HireIQTheme.textMuted, fontWeight: FontWeight.w500)),
        ]),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: recommended ? HireIQTheme.amber : color.withValues(alpha: 0.1), foregroundColor: recommended ? HireIQTheme.primaryNavy : color, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 12), minimumSize: const Size.fromHeight(0), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text(current ? 'Current Plan' : 'Get Started', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700))),
        const SizedBox(height: 16),
        ...features.map((f) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.check_rounded, size: 14, color: recommended ? Colors.white70 : HireIQTheme.success), const SizedBox(width: 8), Expanded(child: Text(f, style: GoogleFonts.inter(fontSize: 12, color: recommended ? Colors.white70 : HireIQTheme.textMuted)))]))),
      ]),
    ));
  }
}

Widget _FH(String t) => Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
Widget _FC(bool v) => Center(child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Icon(v ? Icons.check_circle_rounded : Icons.remove_rounded, size: 18, color: v ? HireIQTheme.success : HireIQTheme.borderMedium)));
