import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateCareerGoalsWeb extends ConsumerStatefulWidget {
  const CandidateCareerGoalsWeb({super.key});
  @override
  ConsumerState<CandidateCareerGoalsWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateCareerGoalsWeb> {
  String _timeline = '6 months';

  static const _goals = [
    _Goal('Land a Senior Flutter role', 0.65),
    _Goal('Earn R100k+ per month', 0.40),
    _Goal('Lead a product team', 0.20),
    _Goal('Build a side project portfolio', 0.80),
  ];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Career Goals', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Track progress toward your career milestones', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: goals
            Expanded(child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Text('My Goals', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const Spacer(),
                  ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, size: 14), label: Text('Add Goal', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
                ]),
                const SizedBox(height: 18),
                ..._goals.map((g) => Padding(padding: const EdgeInsets.only(bottom: 18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Text(g.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary))),
                    Text('${(g.progress * 100).round()}%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
                  ]),
                  const SizedBox(height: 8),
                  ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: LinearProgressIndicator(value: g.progress, minHeight: 10, backgroundColor: HireIQTheme.borderLight, valueColor: const AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal))),
                ]))),
              ]),
            )),
            const SizedBox(width: 20),
            // Centre: target role & salary
            Expanded(child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Target Role', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 16),
                TextField(controller: TextEditingController(text: 'Senior Flutter Developer'), decoration: InputDecoration(labelText: 'Target Role / Title', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14))),
                const SizedBox(height: 14),
                TextField(controller: TextEditingController(text: 'R100,000/month'), decoration: InputDecoration(labelText: 'Target Salary', prefixIcon: const Icon(Icons.currency_exchange_rounded, size: 16), border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14))),
                const SizedBox(height: 14),
                Text('Timeline', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textMuted)),
                const SizedBox(height: 8),
                Wrap(spacing: 8, children: ['3 months', '6 months', '1 year', '2 years'].map((t) => ChoiceChip(label: Text(t, style: GoogleFonts.inter(fontSize: 12)), selected: _timeline == t, onSelected: (_) => setState(() => _timeline = t), selectedColor: HireIQTheme.primaryTeal, labelStyle: TextStyle(color: _timeline == t ? Colors.white : HireIQTheme.textMuted))).toList()),
                const SizedBox(height: 20),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.primaryNavy, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 13), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Save Goals', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)))),
              ]),
            )),
            const SizedBox(width: 20),
            // Right: UpliftIQ recommendations
            Expanded(child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.recruiterAccent.withValues(alpha: 0.3))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [const Icon(Icons.auto_awesome_rounded, color: HireIQTheme.recruiterAccent, size: 18), const SizedBox(width: 8), Text('UpliftIQ', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.recruiterAccent))]),
                const SizedBox(height: 4),
                Text('Personalised next steps', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                const SizedBox(height: 16),
                ...[
                  ('📚', 'Complete Flutter Advanced course on Coursera', 'Skill Gap'),
                  ('📄', 'Add 2 more projects to your portfolio', 'Profile Gap'),
                  ('🎯', '5 targeted applications this week', 'Activity'),
                  ('✅', 'Request a reference from Capitec Bank', 'Credibility'),
                  ('💪', 'Prepare for system design interviews', 'Interview Prep'),
                ].map((r) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: HireIQTheme.recruiterAccent.withValues(alpha: 0.04), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.recruiterAccent.withValues(alpha: 0.1))),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(r.$1, style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 10),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(r.$2, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)),
                      Container(margin: const EdgeInsets.only(top: 4), padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: HireIQTheme.recruiterAccent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(r.$3, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: HireIQTheme.recruiterAccent))),
                    ])),
                  ]),
                )),
              ]),
            )),
          ]),
        ]),
      ),
    );
  }
}

class _Goal {
  const _Goal(this.title, this.progress);
  final String title;
  final double progress;
}
