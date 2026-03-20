import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidatePublicProfileWeb extends ConsumerWidget {
  const CandidatePublicProfileWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Navy hero banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(40, 40, 40, 32),
          decoration: const BoxDecoration(gradient: LinearGradient(colors: [HireIQTheme.primaryNavy, Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            CircleAvatar(radius: 52, backgroundColor: Colors.white.withValues(alpha: 0.1), child: Text('TM', style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white))),
            const SizedBox(width: 20),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text('Thabo Mokoena', style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white)),
                const SizedBox(width: 12),
                Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.5))), child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.verified_rounded, color: HireIQTheme.primaryTeal, size: 12), const SizedBox(width: 4), Text('PassportIQ', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))])),
              ]),
              Text('Senior Flutter Developer', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white70)),
              const SizedBox(height: 4),
              Row(children: [const Icon(Icons.location_on_rounded, color: Colors.white54, size: 14), const SizedBox(width: 4), Text('Cape Town, South Africa', style: GoogleFonts.inter(fontSize: 13, color: Colors.white60))]),
            ])),
            ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.send_rounded, size: 14), label: Text('Contact Candidate', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
          ]),
        ),
        // Stats row
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
          decoration: const BoxDecoration(color: HireIQTheme.surfaceWhite, border: Border(bottom: BorderSide(color: HireIQTheme.borderLight))),
          child: Row(children: [
            _PubStat('MatchIQ Score', '87%', HireIQTheme.primaryTeal),
            _PubDivider(),
            _PubStat('Projects Completed', '12', HireIQTheme.primaryNavy),
            _PubDivider(),
            _PubStat('Response Rate', '94%', HireIQTheme.success),
            _PubDivider(),
            _PubStat('Open to Work', 'Actively Seeking', HireIQTheme.success),
          ]),
        ),
        // Main content
        Padding(
          padding: const EdgeInsets.all(40),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: experience + education
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _PubCard('Experience', [
                ('Senior Flutter Developer', 'TechFlow Solutions · 2022 – Present', 'Led development of the flagship banking app with 2M+ users. Managed a team of 4 developers.'),
                ('Flutter Developer', 'Capitec Bank · 2020 – 2022', 'Contributed to the Capitec mobile app serving 8M+ daily active users.'),
              ]),
              const SizedBox(height: 16),
              _PubCard('Education', [
                ('BSc Computer Science', 'University of Cape Town · 2015 – 2018', 'Graduated with distinction. Focus on software engineering and algorithms.'),
              ]),
            ])),
            const SizedBox(width: 24),
            // Right: skills, wildcard, references
            SizedBox(width: 320, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Skills', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 12),
                  Wrap(spacing: 8, runSpacing: 6, children: ['Flutter', 'Dart', 'Firebase', 'Riverpod', 'BLoC', 'REST APIs', 'CI/CD', 'Git', 'Agile'].map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.07), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(s, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)))).toList()),
                ]),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.amber.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.amber.withValues(alpha: 0.3))),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [const Icon(Icons.bolt_rounded, color: HireIQTheme.amber, size: 18), const SizedBox(width: 6), Text('WildcardIQ Score', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))]),
                  const SizedBox(height: 8),
                  Text('78 / 100', style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w900, color: HireIQTheme.amber)),
                  Text('High adaptability • Leadership potential • Innovation-oriented', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted, height: 1.4)),
                ]),
              ),
            ])),
          ]),
        ),
      ]),
    );
  }
}

Widget _PubStat(String l, String v, Color c) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(v, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: c)), Text(l, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))]);
Widget _PubDivider() => Container(width: 1, height: 36, color: HireIQTheme.borderLight, margin: const EdgeInsets.symmetric(horizontal: 24));
Widget _PubCard(String title, List<(String, String, String)> items) => Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)), const Divider(height: 20, color: HireIQTheme.borderLight), ...items.map((e) => Padding(padding: const EdgeInsets.only(bottom: 16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(e.$1, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)), Text(e.$2, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.primaryTeal)), const SizedBox(height: 4), Text(e.$3, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.5))])))]));
