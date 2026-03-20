import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateProfileWeb extends ConsumerWidget {
  const CandidateProfileWeb({super.key});

  static const _experiences = [
    _Exp('Senior Flutter Developer', 'TechFlow Solutions', 'Jan 2023 – Present', '2 yrs'),
    _Exp('Mobile Developer', 'Standard Bank', 'Mar 2021 – Dec 2022', '1 yr 10 mo'),
    _Exp('Junior Developer', 'Nedbank', 'Jun 2019 – Feb 2021', '1 yr 9 mo'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left sidebar: photo + quick stats
          SizedBox(width: 260, child: Column(children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(children: [
                CircleAvatar(radius: 48, backgroundColor: HireIQTheme.primaryNavy, child: Text('TM', style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white))),
                const SizedBox(height: 14),
                Text('Thabo Mokoena', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
                Text('Senior Flutter Developer', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)),
                Text('Cape Town, Western Cape', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.auto_awesome_rounded, size: 14, color: HireIQTheme.primaryTeal),
                  const SizedBox(width: 4),
                  Text('94% MatchIQ', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
                ]),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  _QStat('12', 'Applied'),
                  _QStat('3', 'Offers'),
                  _QStat('5', 'Saved'),
                ]),
                const SizedBox(height: 16),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Edit Profile', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)))),
              ]),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Contact', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 12),
                _CRow(Icons.email_outlined, 'thabo@email.co.za'),
                _CRow(Icons.phone_outlined, '+27 82 000 1234'),
                _CRow(Icons.web_rounded, 'thabodev.co.za'),
              ]),
            ),
          ])),
          const SizedBox(width: 24),
          // Centre: main profile content
          Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _ProfileCard('Work Experience', Icons.work_outline_rounded, Column(children: _experiences.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(children: [
                Container(width: 40, height: 40, decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.07), borderRadius: BorderRadius.circular(HireIQTheme.radiusSm)), child: Center(child: Text(e.company.substring(0, 2), style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)))),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(e.role, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                  Text(e.company, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                  Text('${e.period} · ${e.duration}', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                ])),
              ]),
            )).toList())),
            const SizedBox(height: 20),
            _ProfileCard('Skills', Icons.hub_outlined, Wrap(spacing: 8, runSpacing: 8, children: ['Flutter', 'Dart', 'Firebase', 'Riverpod', 'BLoC', 'REST APIs', 'Git', 'CI/CD', 'TypeScript', 'React Native'].map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.3))), child: Text(s, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.primaryTeal)))).toList())),
          ])),
          const SizedBox(width: 24),
          // Right: strength card + recs
          SizedBox(width: 240, child: Column(children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(children: [
                Text('Profile Strength', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 16),
                Stack(alignment: Alignment.center, children: [
                  SizedBox(width: 100, height: 100, child: CircularProgressIndicator(value: 0.87, strokeWidth: 10, backgroundColor: HireIQTheme.borderLight, color: HireIQTheme.primaryTeal)),
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    Text('87%', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
                    Text('Strong', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                  ]),
                ]),
              ]),
            ),
          ])),
        ]),
      ),
    );
  }
}

class _Exp { const _Exp(this.role, this.company, this.period, this.duration); final String role, company, period, duration; }

Widget _QStat(String value, String label) => Column(children: [Text(value, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)), Text(label, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))]);
Widget _CRow(IconData icon, String t) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(children: [Icon(icon, size: 14, color: HireIQTheme.textMuted), const SizedBox(width: 8), Expanded(child: Text(t, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)))]));
Widget _ProfileCard(String title, IconData icon, Widget child) => Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(icon, size: 18, color: HireIQTheme.primaryNavy), const SizedBox(width: 8), Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))]), const SizedBox(height: 16), child]));
