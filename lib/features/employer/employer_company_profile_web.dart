import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerCompanyProfileWeb extends ConsumerWidget {
  const EmployerCompanyProfileWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Hero banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(gradient: LinearGradient(colors: [HireIQTheme.primaryNavy, Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Row(children: [
            Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), child: Center(child: Text('TF', style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white)))),
            const SizedBox(width: 20),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('TechFlow Solutions', style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white)),
              Text('Fintech · Cape Town, Western Cape', style: GoogleFonts.inter(fontSize: 14, color: Colors.white70)),
              const SizedBox(height: 8),
              Row(children: [
                _PTag('180+ employees'),
                const SizedBox(width: 10),
                _PTag('Founded 2019'),
                const SizedBox(width: 10),
                _PTag('techflow.co.za'),
              ]),
            ]),
            const Spacer(),
            ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Edit Profile', style: GoogleFonts.inter(fontWeight: FontWeight.w700))),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(40),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _CPCard('About TechFlow Solutions', Text('TechFlow Solutions is Cape Town\'s leading fintech startup, building next-generation banking products used by 2 million+ South Africans. Our engineering-first culture values clean code, performance, and developer happiness.', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted, height: 1.65))),
              const SizedBox(height: 20),
              _CPCard('Our Values', Wrap(spacing: 10, runSpacing: 10, children: ['Innovation', 'Inclusivity', 'Excellence', 'Collaboration', 'Transparency', 'Impact'].map((v) => Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.3))), child: Text(v, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.primaryTeal)))).toList())),
              const SizedBox(height: 20),
              _CPCard('Benefits', Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                '🏥  Medical Aid (Discovery Health)'.split('').join().let((s) => Text(s, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                const SizedBox(height: 8),
                Text('💰  Competitive salaries + equity options', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)),
                const SizedBox(height: 8),
                Text('🏡  Remote-first with optional Cape Town office', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)),
                const SizedBox(height: 8),
                Text('📚  R15,000 annual learning budget', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)),
              ])),
            ])),
            const SizedBox(width: 28),
            SizedBox(width: 280, child: Column(children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Hiring Stats', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 14),
                  _PStatRow('Active Job Posts', '8'),
                  _PStatRow('Hires This Year', '23'),
                  _PStatRow('Avg MatchIQ Score', '87%'),
                  _PStatRow('Offer Acceptance Rate', '78%'),
                ]),
              ),
            ])),
          ]),
        ),
      ]),
    );
  }
}

extension _Let<T> on T { V let<V>(V Function(T) fn) => fn(this); }
Widget _PTag(String t) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(t, style: GoogleFonts.inter(fontSize: 12, color: Colors.white70)));
Widget _CPCard(String title, Widget child) => Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)), const SizedBox(height: 14), child]));
Widget _PStatRow(String label, String val) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(children: [Expanded(child: Text(label, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))), Text(val, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))]));
