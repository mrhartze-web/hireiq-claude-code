import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateGigDashboardWeb extends ConsumerStatefulWidget {
  const CandidateGigDashboardWeb({super.key});
  @override
  ConsumerState<CandidateGigDashboardWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateGigDashboardWeb> {
  String _selectedCat = 'All';
  int _selectedGig = 0;

  static const _gigs = [
    _Gig('Flutter UI Implementation', 'R8,000 – R15,000', '2 weeks', ['Flutter', 'Dart', 'Figma'], 12),
    _Gig('Firebase Backend Integration', 'R12,000 – R20,000', '3 weeks', ['Firebase', 'Cloud Functions', 'Firestore'], 8),
    _Gig('Mobile App Audit', 'R5,000 – R8,000', '1 week', ['Flutter', 'Performance', 'UX'], 5),
    _Gig('REST API Integration', 'R6,000 – R10,000', '1 week', ['REST', 'Dart', 'JSON'], 15),
    _Gig('CI/CD Pipeline Setup', 'R4,000 – R7,000', '3 days', ['GitHub Actions', 'Fastlane', 'CI/CD'], 4),
    _Gig('BLoC State Refactor', 'R10,000 – R18,000', '2 weeks', ['BLoC', 'Flutter', 'Architecture'], 7),
  ];

  @override
  Widget build(BuildContext context) {
    final gig = _gigs[_selectedGig];
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Gig Marketplace', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Find short-term freelance contracts matched to your skills', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 24),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left sidebar: filters
            SizedBox(width: 220, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Filters', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 12),
                Text('Category', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: HireIQTheme.textMuted)),
                const SizedBox(height: 8),
                Wrap(spacing: 6, runSpacing: 6, children: ['All', 'Mobile', 'Backend', 'DevOps'].map((c) => GestureDetector(onTap: () => setState(() => _selectedCat = c), child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: _selectedCat == c ? HireIQTheme.primaryNavy : HireIQTheme.background, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), border: Border.all(color: _selectedCat == c ? HireIQTheme.primaryNavy : HireIQTheme.borderLight)), child: Text(c, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: _selectedCat == c ? Colors.white : HireIQTheme.textMuted))))).toList()),
                const SizedBox(height: 16),
                Text('Duration', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: HireIQTheme.textMuted)),
                const SizedBox(height: 8),
                ...<String>['Any', '< 1 week', '1-2 weeks', '1 month'].map((d) => Padding(padding: const EdgeInsets.only(bottom: 4), child: Row(children: [const Icon(Icons.circle, size: 6, color: HireIQTheme.borderMedium), const SizedBox(width: 8), Text(d, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))]))),
                const SizedBox(height: 16),
                Text('Budget Range', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: HireIQTheme.textMuted)),
                const SizedBox(height: 6),
                Text('R2,000 – R25,000', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textPrimary)),
                Slider(value: 0.6, onChanged: (v) {}, activeColor: HireIQTheme.primaryTeal, inactiveColor: HireIQTheme.borderLight),
              ])),
            ])),
            const SizedBox(width: 16),
            // Centre: gig grid
            Expanded(child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.3),
              itemCount: _gigs.length,
              itemBuilder: (_, i) {
                final g = _gigs[i];
                final sel = _selectedGig == i;
                return GestureDetector(
                  onTap: () => setState(() => _selectedGig = i),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: sel ? HireIQTheme.primaryTeal : HireIQTheme.borderLight, width: sel ? 2 : 1)),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(g.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                      const SizedBox(height: 6),
                      Text(g.budget, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
                      Text('Duration: ${g.duration}', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                      const SizedBox(height: 8),
                      Wrap(spacing: 4, runSpacing: 4, children: g.skills.map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(s, style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)))).toList()),
                      const Spacer(),
                      Row(children: [
                        Text('${g.proposals} proposals', style: GoogleFonts.inter(fontSize: 10, color: HireIQTheme.textMuted)),
                        const Spacer(),
                        ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Apply', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700))),
                      ]),
                    ]),
                  ),
                );
              },
            )),
            const SizedBox(width: 16),
            // Right: detail panel
            SizedBox(width: 260, child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.3))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Gig Detail', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const Divider(color: HireIQTheme.borderLight, height: 20),
                Text(gig.title, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                const SizedBox(height: 8),
                _GRow(Icons.attach_money_rounded, gig.budget),
                _GRow(Icons.access_time_rounded, gig.duration),
                _GRow(Icons.people_rounded, '${gig.proposals} proposals'),
                const SizedBox(height: 12),
                Wrap(spacing: 6, runSpacing: 6, children: gig.skills.map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.07), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(s, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)))).toList()),
                const SizedBox(height: 16),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 13), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Quick Apply', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)))),
              ]),
            )),
          ]),
        ]),
      ),
    );
  }
}

class _Gig {
  const _Gig(this.title, this.budget, this.duration, this.skills, this.proposals);
  final String title, budget, duration;
  final List<String> skills;
  final int proposals;
}

Widget _GRow(IconData icon, String t) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Row(children: [Icon(icon, size: 14, color: HireIQTheme.textMuted), const SizedBox(width: 8), Text(t, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textPrimary))]));
