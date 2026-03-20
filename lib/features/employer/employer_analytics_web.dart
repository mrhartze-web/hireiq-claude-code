import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerAnalyticsWeb extends ConsumerWidget {
  const EmployerAnalyticsWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Recruitment Analytics', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Data-driven insights across all your hiring pipelines', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          // KPI row
          Row(children: [
            _KPI('Time to Hire', '18 days', '↓ 3d vs last month', HireIQTheme.success, Icons.speed_rounded),
            const SizedBox(width: 16),
            _KPI('Offer Acceptance', '78%', '↑ 5% vs last month', HireIQTheme.primaryTeal, Icons.handshake_rounded),
            const SizedBox(width: 16),
            _KPI('Avg MatchIQ', '84%', '↑ 2% vs last month', HireIQTheme.primaryNavy, Icons.auto_awesome_rounded),
            const SizedBox(width: 16),
            _KPI('Cost per Hire', 'R2,400', '↓ R150 vs last month', HireIQTheme.info, Icons.savings_rounded),
          ]),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(flex: 2, child: Column(children: [
              // Funnel
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Hiring Funnel', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 20),
                  ...[
                    ['Applied', 142, HireIQTheme.primaryNavy, 1.0],
                    ['Screened', 68, HireIQTheme.primaryTeal, 0.479],
                    ['Interviewed', 32, HireIQTheme.info, 0.225],
                    ['Offer Made', 8, HireIQTheme.warning, 0.056],
                    ['Hired', 5, HireIQTheme.success, 0.035],
                  ].map((row) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(children: [
                      SizedBox(width: 80, child: Text(row[0] as String, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                      Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: LinearProgressIndicator(value: row[3] as double, minHeight: 24, backgroundColor: HireIQTheme.borderLight, valueColor: AlwaysStoppedAnimation<Color>(row[2] as Color)))),
                      const SizedBox(width: 12),
                      SizedBox(width: 30, child: Text('${row[1]}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: row[2] as Color))),
                    ]),
                  )),
                ]),
              ),
              const SizedBox(height: 20),
              // Source breakdown
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Application Sources', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 20),
                  ...[
                    ['HireIQ MatchIQ', 0.65, HireIQTheme.primaryTeal],
                    ['Direct Applications', 0.20, HireIQTheme.primaryNavy],
                    ['Referrals', 0.10, HireIQTheme.amber],
                    ['Other', 0.05, HireIQTheme.textMuted],
                  ].map((r) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(children: [
                      SizedBox(width: 160, child: Text(r[0] as String, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                      Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: LinearProgressIndicator(value: r[1] as double, minHeight: 10, backgroundColor: HireIQTheme.borderLight, valueColor: AlwaysStoppedAnimation<Color>(r[2] as Color)))),
                      const SizedBox(width: 10),
                      Text('${((r[1] as double) * 100).round()}%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)),
                    ]),
                  )),
                ]),
              ),
            ])),
            const SizedBox(width: 24),
            // Right: monthly trend bar chart
            Expanded(child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Monthly Hires', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 24),
                SizedBox(
                  height: 220,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    ['Oct', 2],['Nov', 5],['Dec', 3],['Jan', 4],['Feb', 6],['Mar', 5],
                  ].map((m) {
                    final val = m[1] as int;
                    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Text('$val', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                      const SizedBox(height: 4),
                      Container(width: 36, height: val * 28.0, decoration: BoxDecoration(color: HireIQTheme.primaryNavy, borderRadius: const BorderRadius.vertical(top: Radius.circular(4)))),
                      const SizedBox(height: 8),
                      Text(m[0] as String, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                    ]);
                  }).toList()),
                ),
              ]),
            )),
          ]),
        ]),
      ),
    );
  }
}

Widget _KPI(String label, String value, String sub, Color color, IconData icon) => Expanded(child: Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: color, size: 18), const SizedBox(height: 10), Text(value, style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: color)), Text(label, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textPrimary)), Text(sub, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))])));
