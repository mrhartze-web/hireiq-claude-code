import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateApplicationsWeb extends ConsumerStatefulWidget {
  const CandidateApplicationsWeb({super.key});
  @override
  ConsumerState<CandidateApplicationsWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateApplicationsWeb> with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _tabs2 = ['All', 'Applied', 'Reviewing', 'Shortlisted', 'Offered', 'Rejected'];

  static const _apps = [
    _App('Senior Flutter Developer', 'TechFlow Solutions', '15 Mar 2026', 'Reviewing', 92),
    _App('Lead Mobile Engineer', 'Capitec Bank', '10 Mar 2026', 'Shortlisted', 88),
    _App('Software Engineer III', 'Standard Bank', '01 Mar 2026', 'Applied', 76),
    _App('React Native Developer', 'OUTsurance', '25 Feb 2026', 'Offered', 95),
    _App('Frontend Developer', 'Nedbank', '18 Feb 2026', 'Rejected', 61),
    _App('Mobile Developer', 'Shoprite Holdings', '12 Feb 2026', 'Applied', 79),
  ];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: _tabs2.length, vsync: this);
  }

  @override
  void dispose() { _tabs.dispose(); super.dispose(); }

  Color _statusColor(String s) {
    switch (s) {
      case 'Reviewing': return HireIQTheme.info;
      case 'Shortlisted': return HireIQTheme.primaryTeal;
      case 'Offered': return HireIQTheme.success;
      case 'Rejected': return HireIQTheme.error;
      default: return HireIQTheme.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('My Applications', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('Track your job applications across all stages', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ])),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download_rounded, size: 16),
              label: Text('Export CSV', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
              style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.primaryNavy, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))),
            ),
          ]),
          const SizedBox(height: 28),
          // Stats row
          Row(children: [
            _StatCard('Total Applications', '${_apps.length}', Icons.work_outline_rounded, HireIQTheme.primaryNavy),
            const SizedBox(width: 16),
            _StatCard('In Progress', '3', Icons.hourglass_empty_rounded, HireIQTheme.info),
            const SizedBox(width: 16),
            _StatCard('Shortlisted', '1', Icons.star_outline_rounded, HireIQTheme.primaryTeal),
            const SizedBox(width: 16),
            _StatCard('Offers Received', '1', Icons.celebration_rounded, HireIQTheme.success),
          ]),
          const SizedBox(height: 28),
          // Tab bar
          Container(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: HireIQTheme.borderLight))),
            child: TabBar(
              controller: _tabs,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700),
              unselectedLabelStyle: GoogleFonts.inter(fontSize: 13),
              labelColor: HireIQTheme.primaryNavy,
              unselectedLabelColor: HireIQTheme.textMuted,
              indicatorColor: HireIQTheme.primaryTeal,
              indicatorWeight: 2,
              tabs: _tabs2.map((t) => Tab(text: t)).toList(),
            ),
          ),
          const SizedBox(height: 20),
          // Data table
          Container(
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(children: [
              // Header row
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(color: HireIQTheme.background, borderRadius: const BorderRadius.vertical(top: Radius.circular(HireIQTheme.radiusLg))),
                child: Row(children: [
                  _TH('Job Title', flex: 3),
                  _TH('Company', flex: 2),
                  _TH('Applied Date', flex: 2),
                  _TH('Status', flex: 2),
                  _TH('MatchIQ', flex: 1),
                  _TH('Actions', flex: 2),
                ]),
              ),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              ..._apps.asMap().entries.map((e) {
                final app = e.value;
                final isLast = e.key == _apps.length - 1;
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Row(children: [
                      Expanded(flex: 3, child: Text(app.title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary))),
                      Expanded(flex: 2, child: Text(app.company, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                      Expanded(flex: 2, child: Text(app.date, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                      Expanded(flex: 2, child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: _statusColor(app.status).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
                        child: Text(app.status, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: _statusColor(app.status))),
                      )),
                      Expanded(flex: 1, child: Row(children: [
                        const Icon(Icons.auto_awesome_rounded, size: 13, color: HireIQTheme.primaryTeal),
                        const SizedBox(width: 4),
                        Text('${app.matchiq}%', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
                      ])),
                      Expanded(flex: 2, child: Row(children: [
                        TextButton(onPressed: () {}, child: Text('View', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.primaryNavy, fontWeight: FontWeight.w600))),
                        TextButton(onPressed: () {}, child: Text('Withdraw', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.error, fontWeight: FontWeight.w600))),
                      ])),
                    ]),
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

class _App {
  const _App(this.title, this.company, this.date, this.status, this.matchiq);
  final String title, company, date, status;
  final int matchiq;
}

Widget _StatCard(String label, String value, IconData icon, Color color) {
  return Expanded(child: Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
    child: Row(children: [
      Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), child: Icon(icon, color: color, size: 20)),
      const SizedBox(width: 14),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(value, style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: color)),
        Text(label, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
      ]),
    ]),
  ));
}

Widget _TH(String label, {int flex = 1}) => Expanded(flex: flex, child: Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
