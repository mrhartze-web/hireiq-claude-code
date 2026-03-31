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

class _State extends ConsumerState<CandidateApplicationsWeb>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  static const _labels = ['All', 'Applied', 'Reviewing', 'Shortlisted', 'Interviewing', 'Offered'];

  static const _apps = [
    _App('Senior Flutter Developer', 'TechFlow Solutions', '15 Mar 2026', 'Reviewing', 92),
    _App('Lead Mobile Engineer', 'Capitec Bank', '10 Mar 2026', 'Shortlisted', 88),
    _App('Software Engineer III', 'Standard Bank', '01 Mar 2026', 'Applied', 76),
    _App('React Native Developer', 'OUTsurance', '25 Feb 2026', 'Offered', 95),
    _App('Frontend Developer', 'Nedbank', '18 Feb 2026', 'Reviewing', 61),
    _App('Mobile Developer', 'Shoprite Holdings', '12 Feb 2026', 'Interviewing', 79),
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

  static Color _statusColor(String s) {
    switch (s) {
      case 'Offered': return HireIQTheme.success;
      case 'Shortlisted': return HireIQTheme.primaryTeal;
      case 'Interviewing': return HireIQTheme.info;
      case 'Reviewing': return HireIQTheme.warning;
      default: return HireIQTheme.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Header
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('My Applications', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('${_apps.length} applications across all stages', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download_rounded, size: 14),
              label: Text('Export CSV', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(foregroundColor: HireIQTheme.primaryNavy, side: const BorderSide(color: HireIQTheme.borderMedium), padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))),
            ),
          ]),
          const SizedBox(height: 24),
          // Stats
          Row(children: [
            _AppStatCard(label: 'Total', value: '${_apps.length}', color: HireIQTheme.primaryNavy),
            const SizedBox(width: 12),
            _AppStatCard(label: 'In Progress', value: '${_apps.where((a) => a.status != 'Offered' && a.status != 'Rejected').length}', color: HireIQTheme.primaryTeal),
            const SizedBox(width: 12),
            _AppStatCard(label: 'Offers', value: '${_apps.where((a) => a.status == 'Offered').length}', color: HireIQTheme.success),
            const SizedBox(width: 12),
            _AppStatCard(label: 'Avg MatchIQ', value: '${(_apps.map((a) => a.matchiq).reduce((a, b) => a + b) / _apps.length).round()}%', color: HireIQTheme.amber),
          ]),
          const SizedBox(height: 24),
          // Tab Bar
          TabBar(
            controller: _tab,
            labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
            unselectedLabelStyle: GoogleFonts.inter(fontSize: 13),
            labelColor: HireIQTheme.primaryNavy,
            unselectedLabelColor: HireIQTheme.textMuted,
            indicatorColor: HireIQTheme.primaryTeal,
            tabs: _labels.map((l) => Tab(text: l)).toList(),
          ),
          const SizedBox(height: 16),
          // Table
          Container(
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(children: [
              // Header row
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: const BoxDecoration(color: HireIQTheme.background, borderRadius: BorderRadius.vertical(top: Radius.circular(HireIQTheme.radiusLg))),
                child: const Row(children: [
                  _TableHeader('Job Title', 3),
                  _TableHeader('Company', 2),
                  _TableHeader('Applied Date', 2),
                  _TableHeader('Status', 2),
                  _TableHeader('MatchIQ'),
                  _TableHeader(''),
                ]),
              ),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              ..._apps.asMap().entries.map((e) {
                final a = e.value;
                final isLast = e.key == _apps.length - 1;
                final sc = _statusColor(a.status);
                return Column(children: [
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: Row(children: [
                        Expanded(flex: 3, child: Text(a.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary))),
                        Expanded(flex: 2, child: Text(a.company, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                        Expanded(flex: 2, child: Text(a.date, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                        Expanded(flex: 2, child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: sc.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
                          child: Text(a.status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: sc)),
                        )),
                        Expanded(child: Row(children: [
                          const Icon(Icons.auto_awesome_rounded, size: 11, color: HireIQTheme.primaryTeal),
                          const SizedBox(width: 4),
                          Text('${a.matchiq}%', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
                        ])),
                        Expanded(child: IconButton(icon: const Icon(Icons.chevron_right_rounded, size: 20, color: HireIQTheme.textMuted), onPressed: () {})),
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

class _App {
  const _App(this.title, this.company, this.date, this.status, this.matchiq);
  final String title, company, date, status;
  final int matchiq;
}

class _AppStatCard extends StatelessWidget {
  const _AppStatCard({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: HireIQTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
          border: Border.all(color: HireIQTheme.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: color)),
            Text(label, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
          ],
        ),
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader(this.label, [this.flex = 1]);

  final String label;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(label, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)),
    );
  }
}
