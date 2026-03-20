import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateSavedJobsWeb extends ConsumerStatefulWidget {
  const CandidateSavedJobsWeb({super.key});
  @override
  ConsumerState<CandidateSavedJobsWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateSavedJobsWeb>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  static const _labels = ['All Saved', 'Closing Soon', 'High Match'];

  static final _jobs = [
    _SJob('Senior Flutter Developer', 'TechFlow Solutions', 'Cape Town', 'R85k–R120k', 94, 5, false),
    _SJob('Lead Mobile Engineer', 'Capitec Bank', 'Johannesburg', 'R95k–R130k', 91, 2, true),
    _SJob('Software Engineer III', 'Standard Bank', 'Remote', 'R80k–R110k', 88, 14, false),
    _SJob('React Native Dev', 'OUTsurance', 'Cape Town', 'R70k–R95k', 84, 1, true),
    _SJob('Frontend Developer', 'Nedbank', 'Johannesburg', 'R65k–R90k', 81, 20, false),
    _SJob('Mobile Architect', 'Discovery', 'Cape Town', 'R110k–R145k', 79, 3, true),
  ];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: _labels.length, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Saved Jobs', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('${_jobs.length} saved roles — 3 closing soon', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.smart_button_rounded, size: 14), label: Text('SmartApply All', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
          ]),
          const SizedBox(height: 20),
          TabBar(controller: _tab, labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13), unselectedLabelStyle: GoogleFonts.inter(fontSize: 13), labelColor: HireIQTheme.primaryNavy, unselectedLabelColor: HireIQTheme.textMuted, indicatorColor: HireIQTheme.primaryTeal, tabs: _labels.map((l) => Tab(text: l)).toList()),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), decoration: const BoxDecoration(color: HireIQTheme.background, borderRadius: BorderRadius.vertical(top: Radius.circular(HireIQTheme.radiusLg))),
                child: Row(children: [_H('Job Title', 3), _H('Company', 2), _H('Location'), _H('Salary', 2), _H('MatchIQ'), _H('Closes'), _H('')])),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              ..._jobs.asMap().entries.map((e) {
                final j = e.value;
                final isLast = e.key == _jobs.length - 1;
                return Column(children: [
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                    Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      if (j.urgent) Container(margin: const EdgeInsets.only(bottom: 4), padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1), decoration: BoxDecoration(color: HireIQTheme.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('CLOSING SOON', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w800, color: HireIQTheme.error))),
                      Text(j.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                    ])),
                    Expanded(flex: 2, child: Text(j.company, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                    Expanded(child: Text(j.location, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                    Expanded(flex: 2, child: Text(j.salary, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
                    Expanded(child: Row(children: [const Icon(Icons.auto_awesome_rounded, size: 10, color: HireIQTheme.primaryTeal), const SizedBox(width: 3), Text('${j.matchiq}%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))])),
                    Expanded(child: Text('${j.closesIn}d', style: GoogleFonts.inter(fontSize: 12, color: j.urgent ? HireIQTheme.error : HireIQTheme.textMuted, fontWeight: j.urgent ? FontWeight.w700 : FontWeight.w400))),
                    Expanded(child: Row(children: [
                      ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Apply', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700))),
                      const SizedBox(width: 6),
                      InkWell(onTap: () {}, child: const Icon(Icons.bookmark_remove_rounded, size: 18, color: HireIQTheme.textMuted)),
                    ])),
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

class _SJob {
  const _SJob(this.title, this.company, this.location, this.salary, this.matchiq, this.closesIn, this.urgent);
  final String title, company, location, salary;
  final int matchiq, closesIn;
  final bool urgent;
}

Widget _H(String t, [int flex = 1]) => Expanded(flex: flex, child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
