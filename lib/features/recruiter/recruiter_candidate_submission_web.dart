import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class RecruiterCandidateSubmissionWeb extends ConsumerWidget {
  const RecruiterCandidateSubmissionWeb({super.key});

  static const _submissions = [
    _Sub('Thabo Mokoena', 'Senior Flutter Dev', 'TechFlow Solutions', '20 Mar 2026', 'Under Review', HireIQTheme.warning),
    _Sub('Sipho Dlamini', 'Mobile Engineer', 'Capitec Bank', '18 Mar 2026', 'Shortlisted', HireIQTheme.primaryTeal),
    _Sub('Priya Naidoo', 'Product Manager', 'Standard Bank', '15 Mar 2026', 'Interview Set', HireIQTheme.info),
    _Sub('Anele Khumalo', 'DevOps Engineer', 'Nedbank', '12 Mar 2026', 'Placed!', HireIQTheme.success),
    _Sub('Nomvula Sithole', 'UI/UX Designer', 'Discovery', '10 Mar 2026', 'Declined', HireIQTheme.error),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Submissions Tracker', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('Track candidates submitted to clients', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download_rounded, size: 14), label: Text('Export CSV', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)), style: OutlinedButton.styleFrom(foregroundColor: HireIQTheme.primaryNavy, side: const BorderSide(color: HireIQTheme.borderMedium), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
          ]),
          const SizedBox(height: 28),
          Container(
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), color: HireIQTheme.background, child: Row(children: [_SSH('Candidate', 2), _SSH('Role', 2), _SSH('Client', 2), _SSH('Submitted'), _SSH('Status', 2)])),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              ..._submissions.asMap().entries.map((e) {
                final s = e.value;
                final isLast = e.key == _submissions.length - 1;
                return Column(children: [
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                    Expanded(flex: 2, child: Row(children: [CircleAvatar(radius: 14, backgroundColor: HireIQTheme.primaryNavy.withValues(alpha: 0.1), child: Text(s.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy))), const SizedBox(width: 8), Expanded(child: Text(s.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)))])),
                    Expanded(flex: 2, child: Text(s.role, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                    Expanded(flex: 2, child: Text(s.client, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                    Expanded(child: Text(s.date, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))),
                    Expanded(flex: 2, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: s.statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(s.status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: s.statusColor)))),
                  ])),
                  if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                ]);
              }),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _Sub { const _Sub(this.name, this.role, this.client, this.date, this.status, this.statusColor); final String name, role, client, date, status; final Color statusColor; }
Widget _SSH(String t, [int flex = 1]) => Expanded(flex: flex, child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
