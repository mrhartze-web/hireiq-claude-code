import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerDiversityReportWeb extends ConsumerWidget {
  const EmployerDiversityReportWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Diversity & Inclusion Report', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('BBBEE alignment and workforce diversity overview', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          // BBBEE score
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [HireIQTheme.primaryNavy, Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
            child: Row(children: [
              Stack(alignment: Alignment.center, children: [
                SizedBox(width: 120, height: 120, child: CircularProgressIndicator(value: 0.78, strokeWidth: 12, backgroundColor: Colors.white24, color: HireIQTheme.amber)),
                Column(mainAxisSize: MainAxisSize.min, children: [
                  Text('78', style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white)),
                  Text('/100', style: GoogleFonts.inter(fontSize: 12, color: Colors.white54)),
                ]),
              ]),
              const SizedBox(width: 28),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('BBBEE Score', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                Text('Level 2 Contributor · Excellent', style: GoogleFonts.inter(fontSize: 14, color: HireIQTheme.amber)),
                const SizedBox(height: 12),
                Text('Last updated: March 2026', style: GoogleFonts.inter(fontSize: 12, color: Colors.white54)),
              ])),
              Column(children: [
                _MIndi('Ownership', 0.85, Colors.white),
                const SizedBox(height: 10),
                _MIndi('Management', 0.72, Colors.white),
                const SizedBox(height: 10),
                _MIndi('Skills Development', 0.90, Colors.white),
              ]),
            ]),
          ),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: _DCard('Race', [('African', 0.42, HireIQTheme.primaryTeal), ('Coloured', 0.18, HireIQTheme.primaryNavy), ('Indian/Asian', 0.12, HireIQTheme.info), ('White', 0.28, HireIQTheme.textMuted)])),
            const SizedBox(width: 20),
            Expanded(child: _DCard('Gender', [('Male', 0.58, HireIQTheme.primaryNavy), ('Female', 0.42, HireIQTheme.primaryTeal)])),
            const SizedBox(width: 20),
            Expanded(child: _DCard('Disability', [('No disability', 0.96, HireIQTheme.primaryNavy), ('PWD', 0.04, HireIQTheme.primaryTeal)])),
            const SizedBox(width: 20),
            Expanded(child: _DCard('Age Group', [('18–30', 0.35, HireIQTheme.primaryTeal), ('31–45', 0.48, HireIQTheme.primaryNavy), ('46+', 0.17, HireIQTheme.info)])),
          ]),
        ]),
      ),
    );
  }
}

Widget _MIndi(String label, double value, Color color) => Row(children: [SizedBox(width: 120, child: Text(label, style: GoogleFonts.inter(fontSize: 12, color: Colors.white70))), SizedBox(width: 120, child: ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: LinearProgressIndicator(value: value, minHeight: 6, backgroundColor: Colors.white24, valueColor: AlwaysStoppedAnimation<Color>(HireIQTheme.amber)))), const SizedBox(width: 8), Text('${(value * 100).round()}%', style: GoogleFonts.inter(fontSize: 11, color: Colors.white70))]);

Widget _DCard(String title, List<(String, double, Color)> items) => Container(
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
    const SizedBox(height: 16),
    ...items.map((item) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Expanded(child: Text(item.$1, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))), Text('${(item.$2 * 100).round()}%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: item.$3))]),
      const SizedBox(height: 4),
      ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: LinearProgressIndicator(value: item.$2, minHeight: 8, backgroundColor: HireIQTheme.borderLight, valueColor: AlwaysStoppedAnimation<Color>(item.$3))),
    ]))),
  ]),
);
