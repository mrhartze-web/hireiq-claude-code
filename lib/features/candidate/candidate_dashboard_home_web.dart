import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateDashboardHomeWeb extends ConsumerWidget {
  const CandidateDashboardHomeWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Greeting
          Text('Good morning, Thabo 👋', style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Here\'s your job-search summary for today', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          // Stats row
          Row(children: [
            _DStat('MatchIQ Score', '87%', Icons.auto_awesome_rounded, HireIQTheme.primaryTeal, '+3 this week'),
            const SizedBox(width: 16),
            _DStat('Applications', '6', Icons.send_rounded, HireIQTheme.primaryNavy, '2 in review'),
            const SizedBox(width: 16),
            _DStat('Profile Completion', '72%', Icons.person_rounded, HireIQTheme.warning, 'Add 3 more items'),
            const SizedBox(width: 16),
            _DStat('Saved Jobs', '14', Icons.bookmark_rounded, HireIQTheme.info, '3 closing soon'),
          ]),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: Recommended jobs
            Expanded(flex: 2, child: Container(
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(children: [
                Padding(padding: const EdgeInsets.fromLTRB(20, 18, 20, 14), child: Row(children: [
                  Text('Recommended for You', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const Spacer(),
                  TextButton(onPressed: () {}, child: Text('Browse all', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.primaryTeal, fontWeight: FontWeight.w600))),
                ])),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                ...[
                  ('Senior Flutter Developer', 'TechFlow Solutions', 'Cape Town', 'R85k–R120k', 94),
                  ('Lead Mobile Engineer', 'Capitec Bank', 'Johannesburg', 'R95k–R130k', 91),
                  ('Software Engineer', 'Standard Bank', 'Remote', 'R80k–R110k', 88),
                  ('React Native Dev', 'OUTsurance', 'Cape Town', 'R70k–R95k', 84),
                  ('Frontend Dev', 'Discovery', 'Johannesburg', 'R65k–R90k', 81),
                ].asMap().entries.map((e) {
                  final j = e.value;
                  return Column(children: [
                    InkWell(onTap: () {}, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(j.$1, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                        Text('${j.$2} · ${j.$3}', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                        Text(j.$4, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                      ])),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.auto_awesome_rounded, size: 10, color: HireIQTheme.primaryTeal), const SizedBox(width: 3), Text('${j.$5}%', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))])),
                      const SizedBox(width: 10),
                      ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Apply', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700))),
                    ]))),
                    if (e.key < 4) const Divider(height: 1, color: HireIQTheme.borderLight),
                  ]);
                }),
              ]),
            )),
            const SizedBox(width: 24),
            // Right: Activity feed
            Expanded(child: Column(children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Recent Activity', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 14),
                  ...[
                    (Icons.check_circle_rounded, HireIQTheme.success, 'TechFlow shortlisted you', '2h ago'),
                    (Icons.visibility_rounded, HireIQTheme.info, 'Capitec viewed your profile', '5h ago'),
                    (Icons.send_rounded, HireIQTheme.primaryTeal, 'Applied to Standard Bank', 'Yesterday'),
                    (Icons.bookmark_rounded, HireIQTheme.warning, 'Saved: OUTsurance Dev role', '2 days ago'),
                    (Icons.auto_awesome_rounded, HireIQTheme.primaryTeal, 'MatchIQ updated +3 points', '3 days ago'),
                  ].map((a) => Padding(padding: const EdgeInsets.only(bottom: 14), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(width: 32, height: 32, decoration: BoxDecoration(color: a.$2.withValues(alpha: 0.1), shape: BoxShape.circle), child: Icon(a.$1, color: a.$2, size: 16)),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(a.$3, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)),
                      Text(a.$4, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                    ])),
                  ]))),
                ]),
              ),
              const SizedBox(height: 16),
              // Quick actions
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.primaryNavy, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Quick Actions', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 14),
                  _QA(Icons.edit_document, 'Update CV with ForgeIQ'),
                  const SizedBox(height: 8),
                  _QA(Icons.search_rounded, 'Search new jobs'),
                  const SizedBox(height: 8),
                  _QA(Icons.verified_rounded, 'Complete PassportIQ'),
                ]),
              ),
            ])),
          ]),
        ]),
      ),
    );
  }
}

Widget _DStat(String l, String v, IconData icon, Color c, String sub) => Expanded(child: Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(icon, color: c, size: 18), const Spacer()]), const SizedBox(height: 8), Text(v, style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w800, color: c)), Text(l, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textPrimary)), Text(sub, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))])));

Widget _QA(IconData icon, String label) => InkWell(onTap: () {}, child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), child: Row(children: [Icon(icon, color: Colors.white70, size: 16), const SizedBox(width: 10), Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)), const Spacer(), const Icon(Icons.chevron_right_rounded, color: Colors.white54, size: 16)])));
