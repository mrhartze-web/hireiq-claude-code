import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateDashboardHomeWeb extends ConsumerWidget {
  const CandidateDashboardHomeWeb({super.key});

  static const _jobs = [
    _Job('Senior Flutter Developer', 'TechFlow Solutions', 'Cape Town · Hybrid', 'R85k–R120k', 94),
    _Job('Lead Mobile Engineer', 'Capitec Bank', 'Stellenbosch · On-site', 'R95k–R130k', 88),
    _Job('Software Engineer III', 'Standard Bank', 'Johannesburg · Remote', 'R80k–R115k', 82),
    _Job('React Native Developer', 'Discovery Health', 'Cape Town · Hybrid', 'R75k–R100k', 79),
  ];

  static const _activity = [
    _Activity('Application viewed', 'TechFlow Solutions viewed your profile', '2h ago', Icons.visibility_outlined, HireIQTheme.info),
    _Activity('Shortlisted!', 'Capitec Bank shortlisted you for Lead Engineer', '5h ago', Icons.star_rounded, HireIQTheme.amber),
    _Activity('New match', 'Standard Bank — 82% MatchIQ match found', '1d ago', Icons.auto_awesome_rounded, HireIQTheme.primaryTeal),
    _Activity('Message received', 'Nomvula from AgentFlow sent a message', '2d ago', Icons.message_outlined, HireIQTheme.primaryNavy),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Header
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Welcome back, Thabo 👋', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('Thursday, 20 Mar 2026  · Cape Town', style: GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.search_rounded, size: 16),
              label: Text('Browse Jobs', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)),
              style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))),
            ),
          ]),
          const SizedBox(height: 28),

          // Top stats row
          Row(children: [
            _DashStat('MatchIQ Score', '94%', Icons.auto_awesome_rounded, HireIQTheme.primaryTeal, '+3% this week'),
            const SizedBox(width: 16),
            _DashStat('Applications', '12', Icons.work_outline_rounded, HireIQTheme.primaryNavy, '3 active'),
            const SizedBox(width: 16),
            _DashStat('Profile Completion', '87%', Icons.person_rounded, HireIQTheme.info, '2 sections left'),
            const SizedBox(width: 16),
            _DashStat('Saved Jobs', '8', Icons.bookmark_rounded, HireIQTheme.amber, 'View all'),
          ]),
          const SizedBox(height: 32),

          // Two-column main content
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: Job recommendations
            Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text('Top Matches for You', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const Spacer(),
                TextButton(onPressed: () {}, child: Text('View all →', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.primaryTeal, fontWeight: FontWeight.w600))),
              ]),
              const SizedBox(height: 12),
              ..._jobs.map((job) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight), boxShadow: [BoxShadow(color: HireIQTheme.primaryNavy.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 2))]),
                child: Row(children: [
                  Container(width: 44, height: 44, decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), child: Center(child: Text(job.company.substring(0, 2), style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)))),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(job.title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                    Text('${job.company} · ${job.location}', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                    Text(job.salary, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.primaryTeal)),
                  ])),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Row(children: [
                      const Icon(Icons.auto_awesome_rounded, size: 11, color: HireIQTheme.primaryTeal),
                      const SizedBox(width: 4),
                      Text('${job.matchiq}%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
                    ])),
                    const SizedBox(height: 8),
                    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Apply', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700))),
                  ]),
                ]),
              )),
            ])),
            const SizedBox(width: 28),
            // Right: Activity feed
            Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Recent Activity', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(children: _activity.asMap().entries.map((e) {
                  final act = e.value;
                  final isLast = e.key == _activity.length - 1;
                  return Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(children: [
                        Container(width: 36, height: 36, decoration: BoxDecoration(color: act.color.withValues(alpha: 0.1), shape: BoxShape.circle), child: Icon(act.icon, size: 16, color: act.color)),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(act.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                          Text(act.body, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                        ])),
                        Text(act.time, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                      ]),
                    ),
                    if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                  ]);
                }).toList()),
              ),
              const SizedBox(height: 20),
              // Profile completion nudge
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.2))),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    const Icon(Icons.person_add_rounded, color: HireIQTheme.primaryTeal, size: 18),
                    const SizedBox(width: 8),
                    Text('Complete Your Profile', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  ]),
                  const SizedBox(height: 8),
                  ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: const LinearProgressIndicator(value: 0.87, minHeight: 8, backgroundColor: HireIQTheme.borderLight, valueColor: AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal))),
                  const SizedBox(height: 8),
                  Text('Add references and salary expectations to reach 100%', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                  const SizedBox(height: 12),
                  ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.primaryTeal, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), minimumSize: Size.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Complete Now', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600))),
                ]),
              ),
            ])),
          ]),
        ]),
      ),
    );
  }
}

class _Job { const _Job(this.title, this.company, this.location, this.salary, this.matchiq); final String title, company, location, salary; final int matchiq; }
class _Activity { const _Activity(this.title, this.body, this.time, this.icon, this.color); final String title, body, time; final IconData icon; final Color color; }

Widget _DashStat(String label, String value, IconData icon, Color color, String sub) {
  return Expanded(child: Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Icon(icon, color: color, size: 20), const Spacer(), Text(sub, style: GoogleFonts.inter(fontSize: 10, color: HireIQTheme.textMuted))]),
      const SizedBox(height: 12),
      Text(value, style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: color)),
      Text(label, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
    ]),
  ));
}
