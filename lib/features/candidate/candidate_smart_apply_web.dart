import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateSmartApplyWeb extends ConsumerStatefulWidget {
  const CandidateSmartApplyWeb({super.key});
  @override
  ConsumerState<CandidateSmartApplyWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateSmartApplyWeb> {
  final Set<int> _selected = {0, 1, 2};

  static const _jobs = [
    _SAJob('Senior Flutter Developer', 'TechFlow Solutions', 'Cape Town', 94, 'R85k–R120k'),
    _SAJob('Lead Mobile Engineer', 'Capitec Bank', 'Johannesburg', 91, 'R95k–R130k'),
    _SAJob('Software Engineer III', 'Standard Bank', 'Remote', 88, 'R80k–R110k'),
    _SAJob('React Native Dev', 'OUTsurance', 'Cape Town', 84, 'R70k–R95k'),
    _SAJob('Frontend Developer', 'Nedbank', 'Johannesburg', 81, 'R65k–R90k'),
    _SAJob('Mobile Architect', 'Discovery', 'Cape Town', 79, 'R110k–R145k'),
  ];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [const Icon(Icons.smart_button_rounded, color: HireIQTheme.primaryTeal, size: 22), const SizedBox(width: 8), Text('SmartApply', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy))]),
              Text('Apply to multiple high-match jobs with one click', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.rocket_launch_rounded, size: 16), label: Text('Apply to ${_selected.length} Jobs', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
          ]),
          const SizedBox(height: 20),
          // Summary strip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.2))),
            child: Row(children: [
              const Icon(Icons.auto_awesome_rounded, color: HireIQTheme.primaryTeal, size: 16),
              const SizedBox(width: 8),
              Text('SmartApply uses your ForgeIQ CV and tailors the cover letter for each role automatically.', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
              const Spacer(),
              Text('${_selected.length} selected · avg match ${_selected.isEmpty ? "0" : (_jobs.where((j) => _selected.contains(_jobs.indexOf(j))).map((j) => j.matchiq).fold(0, (a, b) => a + b) ~/ _selected.length)}%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
            ]),
          ),
          const SizedBox(height: 16),
          // Job selection table
          Container(
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), decoration: const BoxDecoration(color: HireIQTheme.background, borderRadius: BorderRadius.vertical(top: Radius.circular(HireIQTheme.radiusLg))),
                child: Row(children: [const SizedBox(width: 36), const SizedBox(width: 14), _SAH('Job Title', 3), _SAH('Company', 2), _SAH('Location'), _SAH('Salary', 2), _SAH('MatchIQ')])),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              ..._jobs.asMap().entries.map((e) {
                final j = e.value;
                final i = e.key;
                final isLast = i == _jobs.length - 1;
                final sel = _selected.contains(i);
                return Column(children: [
                  InkWell(
                    onTap: () => setState(() => sel ? _selected.remove(i) : _selected.add(i)),
                    child: Container(
                      color: sel ? HireIQTheme.primaryTeal.withValues(alpha: 0.03) : null,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      child: Row(children: [
                        SizedBox(width: 36, child: Checkbox(value: sel, onChanged: (_) => setState(() => sel ? _selected.remove(i) : _selected.add(i)), activeColor: HireIQTheme.primaryTeal, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)))),
                        const SizedBox(width: 14),
                        Expanded(flex: 3, child: Text(j.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary))),
                        Expanded(flex: 2, child: Text(j.company, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                        Expanded(child: Text(j.location, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                        Expanded(flex: 2, child: Text(j.salary, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
                        Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.auto_awesome_rounded, size: 10, color: HireIQTheme.primaryTeal), const SizedBox(width: 3), Text('${j.matchiq}%', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))]))),
                      ]),
                    ),
                  ),
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

class _SAJob {
  const _SAJob(this.title, this.company, this.location, this.matchiq, this.salary);
  final String title, company, location, salary;
  final int matchiq;
}

Widget _SAH(String t, [int flex = 1]) => Expanded(flex: flex, child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
