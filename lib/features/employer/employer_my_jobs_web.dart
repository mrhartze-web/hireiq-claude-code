import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerMyJobsWeb extends ConsumerStatefulWidget {
  const EmployerMyJobsWeb({super.key});
  @override
  ConsumerState<EmployerMyJobsWeb> createState() => _State();
}

class _State extends ConsumerState<EmployerMyJobsWeb> with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 3, vsync: this);

  static const _jobs = [
    _MyJob('Senior Flutter Developer', 'Engineering', 34, 'Active', 'R85k–R120k'),
    _MyJob('Product Manager', 'Product', 22, 'Active', 'R95k–R130k'),
    _MyJob('DevOps Engineer', 'Engineering', 18, 'Active', 'R80k–R110k'),
    _MyJob('UI/UX Designer', 'Design', 29, 'Paused', 'R70k–R95k'),
    _MyJob('Senior Backend Engineer', 'Engineering', 0, 'Draft', 'R90k–R120k'),
  ];

  @override
  void dispose() { _tabs.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('My Jobs', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('Manage all your job postings', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, size: 16), label: Text('Post New Job', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
          ]),
          const SizedBox(height: 24),
          TabBar(controller: _tabs, labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13), unselectedLabelStyle: GoogleFonts.inter(fontSize: 13), labelColor: HireIQTheme.primaryNavy, unselectedLabelColor: HireIQTheme.textMuted, indicatorColor: HireIQTheme.primaryTeal, tabs: const [Tab(text: 'All Jobs'), Tab(text: 'Active'), Tab(text: 'Draft / Paused')]),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), color: HireIQTheme.background, child: Row(children: [_JH('Role', 2), _JH('Department'), _JH('Salary', 2), _JH('Applicants'), _JH('Status'), _JH('')])),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              ..._jobs.asMap().entries.map((e) {
                final j = e.value;
                final isLast = e.key == _jobs.length - 1;
                final statusColor = j.status == 'Active' ? HireIQTheme.success : j.status == 'Paused' ? HireIQTheme.warning : HireIQTheme.textMuted;
                return Column(children: [
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                    Expanded(flex: 2, child: Text(j.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary))),
                    Expanded(child: Text(j.department, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                    Expanded(flex: 2, child: Text(j.salary, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textPrimary))),
                    Expanded(child: Text('${j.applicants}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
                    Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(j.status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: statusColor)))),
                    Expanded(child: Row(children: [
                      IconButton(icon: const Icon(Icons.edit_outlined, size: 16, color: HireIQTheme.primaryNavy), onPressed: () {}),
                      IconButton(icon: const Icon(Icons.more_vert_rounded, size: 16, color: HireIQTheme.textMuted), onPressed: () {}),
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

class _MyJob { const _MyJob(this.title, this.department, this.applicants, this.status, this.salary); final String title, department, status, salary; final int applicants; }
Widget _JH(String t, [int flex = 1]) => Expanded(flex: flex, child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
