import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerDashboardWeb extends ConsumerWidget {
  const EmployerDashboardWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Employer Dashboard', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Welcome back, TechFlow Solutions', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          // Stats row
          Row(children: [
            _EStat('Active Jobs', '8', Icons.work_rounded, HireIQTheme.primaryNavy, '+2 this month'),
            const SizedBox(width: 16),
            _EStat('Total Candidates', '142', Icons.people_rounded, HireIQTheme.primaryTeal, '34 new this week'),
            const SizedBox(width: 16),
            _EStat('Interviews Scheduled', '12', Icons.video_call_rounded, HireIQTheme.info, '5 this week'),
            const SizedBox(width: 16),
            _EStat('Offers Extended', '3', Icons.handshake_rounded, HireIQTheme.success, '2 accepted'),
          ]),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Active jobs table
            Expanded(flex: 2, child: Container(
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(padding: const EdgeInsets.all(20), child: Row(children: [
                  Text('Active Job Posts', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const Spacer(),
                  ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, size: 14), label: Text('Post Job', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
                ])),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), color: HireIQTheme.background, child: Row(children: [_ETH('Role', 2), _ETH('Applicants'), _ETH('MatchIQ avg'), _ETH('Status')])),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                ...[
                  ['Senior Flutter Developer', '34', '88%', 'Active'],
                  ['Product Manager', '22', '81%', 'Active'],
                  ['DevOps Engineer', '18', '76%', 'Active'],
                  ['UI/UX Designer', '29', '85%', 'Paused'],
                ].asMap().entries.map((e) {
                  final row = e.value;
                  final isLast = e.key == 3;
                  final isActive = row[3] == 'Active';
                  return Column(children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                      Expanded(flex: 2, child: Text(row[0], style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary))),
                      Expanded(child: Text(row[1], style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                      Expanded(child: Text(row[2], style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))),
                      Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: isActive ? HireIQTheme.success.withValues(alpha: 0.1) : HireIQTheme.warning.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), alignment: Alignment.center, child: Text(row[3], style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: isActive ? HireIQTheme.success : HireIQTheme.warning)))),
                    ])),
                    if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                  ]);
                }),
              ]),
            )),
            const SizedBox(width: 24),
            // Right: recent activity
            Expanded(child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Recent Activity', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 14),
                ...[
                  [Icons.person_add_rounded, 'New application', 'Sipho M. applied to Flutter Dev', '5m'],
                  [Icons.auto_awesome_rounded, 'SignalIQ alert', 'High-match candidate spotted', '22m'],
                  [Icons.calendar_today_rounded, 'Interview set', 'Meeting confirmed with Anele K.', '1h'],
                  [Icons.handshake_rounded, 'Offer accepted', 'Priya N. accepted offer', '3h'],
                  [Icons.rate_review_rounded, 'Review pending', 'Stage 2 feedback due', '1d'],
                ].map((a) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(children: [
                    Container(width: 36, height: 36, decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.08), shape: BoxShape.circle), child: Center(child: Icon(a[0] as IconData, size: 16, color: HireIQTheme.primaryTeal))),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(a[1] as String, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                      Text(a[2] as String, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                    ])),
                    Text(a[3] as String, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                  ]),
                )),
              ]),
            )),
          ]),
        ]),
      ),
    );
  }
}

Widget _EStat(String label, String value, IconData icon, Color color, String sub) => Expanded(child: Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(icon, color: color, size: 20), const Spacer(), TextButton(onPressed: () {}, child: Text('View', style: GoogleFonts.inter(fontSize: 12, color: color)))]), const SizedBox(height: 8), Text(value, style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: color)), Text(label, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)), Text(sub, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))])));
Widget _ETH(String t, [int flex = 1]) => Expanded(flex: flex, child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
