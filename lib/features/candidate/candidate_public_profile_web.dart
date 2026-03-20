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
        // Full-width hero
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [HireIQTheme.primaryNavy, Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('As seen by employers', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white60))),
            const SizedBox(height: 20),
            Row(children: [
              CircleAvatar(radius: 52, backgroundColor: Colors.white.withValues(alpha: 0.15), child: Text('TM', style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white))),
              const SizedBox(width: 20),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Thabo Mokoena', style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white)),
                Text('Senior Flutter Developer', style: GoogleFonts.inter(fontSize: 15, color: Colors.white70)),
                Text('Cape Town, Western Cape · Available immediately', style: GoogleFonts.inter(fontSize: 13, color: Colors.white54)),
              ]),
              const Spacer(),
              ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.send_rounded, size: 16), label: Text('Contact Candidate', style: GoogleFonts.inter(fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
            ]),
            const SizedBox(height: 24),
            Row(children: [
              Row(children: [const Icon(Icons.auto_awesome_rounded, size: 14, color: HireIQTheme.primaryTeal), const SizedBox(width: 4), Text('94% MatchIQ', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))]),
              const SizedBox(width: 24),
              Row(children: [const Icon(Icons.verified_user_rounded, size: 14, color: HireIQTheme.success), const SizedBox(width: 4), Text('PassportIQ Verified', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.success))]),
              const SizedBox(width: 24),
              Row(children: [const Icon(Icons.work_outline_rounded, size: 14, color: Colors.white54), const SizedBox(width: 4), Text('6 years experience', style: GoogleFonts.inter(fontSize: 13, color: Colors.white54))]),
            ]),
            const SizedBox(height: 24),
          ]),
        ),
        // Below hero
        Padding(
          padding: const EdgeInsets.all(40),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Main left
            Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _PublicCard('About', Text('Results-driven Flutter developer with 6+ years building cross-platform mobile applications for South African enterprises. Passionate about clean code, performance optimisation, and mentoring junior developers.', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted, height: 1.65))),
              const SizedBox(height: 20),
              _PublicCard('Key Skills', Wrap(spacing: 8, runSpacing: 8, children: ['Flutter', 'Dart', 'Firebase', 'Riverpod', 'BLoC', 'TypeScript', 'REST APIs', 'CI/CD', 'Git'].map((s) => Chip(label: Text(s, style: GoogleFonts.inter(fontSize: 12)), backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.08), side: BorderSide(color: HireIQTheme.primaryTeal.withValues(alpha: 0.3)), padding: EdgeInsets.zero)).toList())),
              const SizedBox(height: 20),
              _PublicCard('Salary Expectation', Text('R85,000 – R120,000 per month', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
            ])),
            const SizedBox(width: 28),
            // Right sidebar
            SizedBox(width: 280, child: Column(children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Quick Stats', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 14),
                  _StatRow('Applications Sent', '12'),
                  _StatRow('Interview Rate', '67%'),
                  _StatRow('Response Rate', '83%'),
                  _StatRow('Profile Views', '148'),
                ]),
              ),
            ])),
          ]),
        ),
      ]),
    );
  }
}

Widget _PublicCard(String title, Widget child) => Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)), const SizedBox(height: 12), child]));
Widget _StatRow(String label, String value) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(children: [Expanded(child: Text(label, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))), Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))]));
