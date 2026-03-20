import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateJobDetailWeb extends ConsumerStatefulWidget {
  const CandidateJobDetailWeb({super.key});
  @override
  ConsumerState<CandidateJobDetailWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateJobDetailWeb> {
  bool _saved = false;

  static const _similar = [
    ('Lead Flutter Dev', 'Capitec Bank', 'Johannesburg', 'R95k', 91),
    ('Mobile Engineer', 'Standard Bank', 'Remote', 'R85k', 88),
    ('Flutter Architect', 'Discovery', 'Cape Town', 'R110k', 84),
    ('Senior Dev', 'Nedbank', 'Johannesburg', 'R80k', 81),
  ];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left: similar jobs list
          SizedBox(width: 280, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Similar Roles', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 12),
            ..._similar.map((j) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(j.$1, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                Text('${j.$2} · ${j.$3}', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                const SizedBox(height: 6),
                Row(children: [
                  Text(j.$4, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const Spacer(),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('${j.$5}%', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal))),
                ]),
              ]),
            )),
          ])),
          const SizedBox(width: 24),
          // Centre: job detail
          Expanded(flex: 2, child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Senior Flutter Developer', style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 4),
              Text('TechFlow Solutions', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: HireIQTheme.primaryTeal)),
              const SizedBox(height: 8),
              Wrap(spacing: 16, children: [
                _JMeta(Icons.location_on_rounded, 'Cape Town, SA'),
                _JMeta(Icons.attach_money_rounded, 'R85,000 – R120,000/month'),
                _JMeta(Icons.work_outline_rounded, 'Full-time · Remote-friendly'),
                _JMeta(Icons.calendar_today_rounded, 'Posted 3 days ago'),
              ]),
              const Divider(color: HireIQTheme.borderLight, height: 28),
              Text('About this role', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 8),
              Text('We are looking for a Senior Flutter Developer to join our growing mobile team at TechFlow Solutions. You will lead the development of our flagship mobile banking application used by over 2 million South Africans. As a senior member you will drive technical decisions, mentor junior developers, and collaborate with product and design teams to ship high-quality features.', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted, height: 1.65)),
              const SizedBox(height: 20),
              Text('Requirements', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 10),
              ...['5+ years Flutter / Dart experience', 'Strong knowledge of state management (Riverpod, BLoC)', 'Experience with Firebase and REST APIs', 'CI/CD pipeline experience (GitHub Actions, Fastlane)', 'Excellent communication in English'].map((r) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.check_circle_outline_rounded, size: 14, color: HireIQTheme.primaryTeal), const SizedBox(width: 8), Expanded(child: Text(r, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textPrimary)))]))),
              const SizedBox(height: 20),
              Text('Skills', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 8),
              Wrap(spacing: 8, runSpacing: 6, children: ['Flutter', 'Dart', 'Firebase', 'Riverpod', 'BLoC', 'REST APIs', 'CI/CD', 'Git', 'Figma'].map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.07), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(s, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)))).toList()),
              const Divider(color: HireIQTheme.borderLight, height: 28),
              Text('About TechFlow Solutions', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 8),
              Text('TechFlow Solutions is South Africa\'s fastest-growing fintech company, building digital banking infrastructure for the next generation of financial services. Founded in 2018, we have 200+ employees across Cape Town and Johannesburg.', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted, height: 1.65)),
            ]),
          )),
          const SizedBox(width: 24),
          // Right: sticky apply panel
          SizedBox(width: 240, child: Column(children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Center(child: Column(children: [
                  SizedBox(width: 90, height: 90, child: Stack(alignment: Alignment.center, children: [
                    CircularProgressIndicator(value: 0.92, strokeWidth: 10, backgroundColor: HireIQTheme.borderLight, valueColor: const AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal)),
                    Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.auto_awesome_rounded, color: HireIQTheme.primaryTeal, size: 14), Text('92%', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy))]),
                  ])),
                  const SizedBox(height: 4),
                  Text('MatchIQ Score', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                ])),
                const SizedBox(height: 20),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Quick Apply', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800)))),
                const SizedBox(height: 10),
                SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: () => setState(() => _saved = !_saved), icon: Icon(_saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded, size: 16), label: Text(_saved ? 'Saved' : 'Save Job', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)), style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.borderMedium), padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), foregroundColor: HireIQTheme.primaryNavy))),
                const SizedBox(height: 10),
                SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.share_rounded, size: 16), label: Text('Share', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)), style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.borderMedium), padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), foregroundColor: HireIQTheme.textMuted))),
              ]),
            ),
          ])),
        ]),
      ),
    );
  }
}

Widget _JMeta(IconData icon, String text) => Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 13, color: HireIQTheme.textMuted), const SizedBox(width: 4), Text(text, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))]);
