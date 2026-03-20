import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class RecruiterDashboardWeb extends ConsumerWidget {
  const RecruiterDashboardWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Recruiter Dashboard', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Good morning, Lindiwe — here\'s your pipeline today', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          Row(children: [
            _RDStat('Active Briefs', '6', Icons.description_rounded, HireIQTheme.primaryNavy, '2 expiring soon'),
            const SizedBox(width: 16),
            _RDStat('Candidates Submitted', '28', Icons.people_rounded, HireIQTheme.primaryTeal, '+5 this week'),
            const SizedBox(width: 16),
            _RDStat('Interviews Arranged', '9', Icons.video_call_rounded, HireIQTheme.info, '3 this week'),
            const SizedBox(width: 16),
            _RDStat('Placements MTD', '2', Icons.handshake_rounded, HireIQTheme.success, 'R48,000 earned'),
          ]),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(flex: 2, child: Column(children: [
              Container(
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(children: [
                  Padding(padding: const EdgeInsets.all(18), child: Row(children: [Text('Active Briefs', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)), const Spacer(), TextButton(onPressed: () {}, child: Text('View all', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.primaryTeal, fontWeight: FontWeight.w600)))])),
                  const Divider(height: 1, color: HireIQTheme.borderLight),
                  ...[
                    ['Senior Flutter Developer', 'TechFlow Solutions', 'Closing 25 Mar', HireIQTheme.error],
                    ['Product Manager', 'Capitec Bank', 'Closing 30 Mar', HireIQTheme.warning],
                    ['DevOps Engineer', 'Standard Bank', 'Closing 10 Apr', HireIQTheme.success],
                    ['UI/UX Designer', 'Nedbank', 'Closing 15 Apr', HireIQTheme.success],
                  ].asMap().entries.map((e) {
                    final row = e.value;
                    final isLast = e.key == 3;
                    return Column(children: [
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14), child: Row(children: [
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(row[0] as String, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                          Text(row[1] as String, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                        ])),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: (row[3] as Color).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(row[2] as String, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: row[3] as Color))),
                      ])),
                      if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                    ]);
                  }),
                ]),
              ),
            ])),
            const SizedBox(width: 24),
            Expanded(child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Today\'s Tasks', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 14),
                ...[
                  [true, 'Call Thabo re: TechFlow offer', '09:00'],
                  [false, 'Submit 3 CVs to Capitec Bank', 'ASAP'],
                  [false, 'Arrange interview for Sipho', 'Today'],
                  [false, 'Send placement agreement to Nedbank', 'EOD'],
                  [false, 'Follow up: Priya N. interview feedback', 'Tomorrow'],
                ].map((t) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(children: [
                  Icon(t[0] as bool ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded, size: 18, color: t[0] as bool ? HireIQTheme.success : HireIQTheme.borderMedium),
                  const SizedBox(width: 10),
                  Expanded(child: Text(t[1] as String, style: GoogleFonts.inter(fontSize: 12, color: t[0] as bool ? HireIQTheme.textMuted : HireIQTheme.textPrimary, decoration: t[0] as bool ? TextDecoration.lineThrough : null))),
                  Text(t[2] as String, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                ]))),
              ]),
            )),
          ]),
        ]),
      ),
    );
  }
}

Widget _RDStat(String l, String v, IconData icon, Color c, String sub) => Expanded(child: Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: c, size: 18), const SizedBox(height: 8), Text(v, style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w800, color: c)), Text(l, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textPrimary)), Text(sub, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))])));
