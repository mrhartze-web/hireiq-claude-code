import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateJobDetailWeb extends ConsumerWidget {
  const CandidateJobDetailWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left 2/3: full job detail
          Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Company header
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Container(width: 60, height: 60, decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), child: Center(child: Text('TF', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)))),
                  const SizedBox(width: 16),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Senior Flutter Developer', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
                    Text('TechFlow Solutions · Cape Town, Western Cape', style: GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textMuted)),
                  ])),
                  ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.bookmark_add_outlined, size: 16), label: Text('Save', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.primaryNavy.withValues(alpha: 0.06), foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
                ]),
                const SizedBox(height: 16),
                Wrap(spacing: 10, children: [
                  _Tag('Full-time'), _Tag('Hybrid'), _Tag('R85k–R120k'), _Tag('Posted 2d ago'),
                ]),
              ]),
            ),
            const SizedBox(height: 24),
            _JobSection('About the Role', 'TechFlow Solutions is a leading fintech startup building the next generation of banking products. We\'re looking for a seasoned Flutter developer to lead our mobile engineering chapter.\n\nYou\'ll work alongside a world-class team to deliver beautiful, performant mobile apps used by over 2 million South Africans.'),
            const SizedBox(height: 20),
            _JobSection('Requirements', null, bullets: [
              '6+ years of mobile development experience',
              '3+ years working with Flutter and Dart',
              'Strong grasp of state management (Riverpod, BLoC)',
              'Experience with Firebase and REST APIs',
              'Track record of shipping to production at scale',
            ]),
            const SizedBox(height: 20),
            _JobSection('Nice to Have', null, bullets: [
              'Experience with Kotlin or Swift',
              'Open source contributions',
              'Fintech or banking background',
            ]),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('About TechFlow Solutions', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 12),
                Text('TechFlow Solutions is a Cape Town-based fintech company founded in 2019. We serve 2M+ users across South Africa with a team of 180+ engineers, designers, and product thinkers.', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted, height: 1.65)),
                const SizedBox(height: 12),
                Row(children: [
                  _InfoChip2(Icons.people_rounded, '180+ employees'),
                  const SizedBox(width: 12),
                  _InfoChip2(Icons.location_city_rounded, 'Cape Town'),
                  const SizedBox(width: 12),
                  _InfoChip2(Icons.web_rounded, 'techflow.co.za'),
                ]),
              ]),
            ),
          ])),
          const SizedBox(width: 28),
          // Right 1/3: sticky apply card
          SizedBox(width: 320, child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.2))), child: Row(children: [
                const Icon(Icons.auto_awesome_rounded, size: 20, color: HireIQTheme.primaryTeal),
                const SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('94% MatchIQ', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal)), Text('Excellent match!', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))]),
              ])),
              const SizedBox(height: 20),
              _ApplyRow(Icons.payments_outlined, 'Salary', 'R85,000 – R120,000'),
              _ApplyRow(Icons.location_on_outlined, 'Location', 'Cape Town · Hybrid'),
              _ApplyRow(Icons.work_outline_rounded, 'Type', 'Full-time, Senior'),
              _ApplyRow(Icons.calendar_today_rounded, 'Start', 'ASAP / Negotiable'),
              const SizedBox(height: 20),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Quick Apply', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 15)))),
              const SizedBox(height: 12),
              Center(child: Text('25 applicants in the last 24h', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))),
            ]),
          )),
        ]),
      ),
    );
  }
}

Widget _Tag(String t) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), decoration: BoxDecoration(color: HireIQTheme.background, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), border: Border.all(color: HireIQTheme.borderLight)), child: Text(t, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)));
Widget _InfoChip2(IconData icon, String t) => Row(children: [Icon(icon, size: 13, color: HireIQTheme.textMuted), const SizedBox(width: 4), Text(t, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))]);
Widget _ApplyRow(IconData icon, String label, String value) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(children: [Icon(icon, size: 15, color: HireIQTheme.textMuted), const SizedBox(width: 10), Text('$label: ', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)), Expanded(child: Text(value, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)))]));

Widget _JobSection(String title, String? body, {List<String>? bullets}) => Container(
  padding: const EdgeInsets.all(24),
  decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
    const SizedBox(height: 12),
    if (body != null) Text(body, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted, height: 1.65)),
    if (bullets != null) ...bullets.map((b) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Padding(padding: const EdgeInsets.only(top: 5, right: 8), child: Container(width: 5, height: 5, decoration: const BoxDecoration(color: HireIQTheme.primaryTeal, shape: BoxShape.circle))), Expanded(child: Text(b, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted, height: 1.5)))]))),
  ]),
);
