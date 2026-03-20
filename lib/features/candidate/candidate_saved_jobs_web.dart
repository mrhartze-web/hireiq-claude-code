import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateSavedJobsWeb extends ConsumerWidget {
  const CandidateSavedJobsWeb({super.key});

  static const _jobs = [
    _SJob('Senior Flutter Developer', 'TechFlow Solutions', 'Cape Town · Hybrid', 'R85k–R120k', 94, '2 days ago'),
    _SJob('Lead Mobile Engineer', 'Capitec Bank', 'Stellenbosch · On-site', 'R95k–R130k', 88, '3 days ago'),
    _SJob('Software Engineer III', 'Standard Bank', 'Johannesburg · Remote', 'R80k–R115k', 82, '5 days ago'),
    _SJob('React Native Developer', 'OUTsurance', 'Cape Town · Hybrid', 'R75k–R95k', 79, '1 week ago'),
    _SJob('Frontend Developer', 'Nedbank', 'Johannesburg · On-site', 'R65k–R90k', 74, '1 week ago'),
    _SJob('Mobile Architect', 'Discovery Health', 'Cape Town · Hybrid', 'R120k–R160k', 70, '2 weeks ago'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Saved Jobs', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('${_jobs.length} jobs saved', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.borderLight)), child: DropdownButtonHideUnderline(child: DropdownButton<String>(value: 'MatchIQ Score', items: ['MatchIQ Score', 'Date Saved', 'Salary'].map((v) => DropdownMenuItem(value: v, child: Text(v, style: GoogleFonts.inter(fontSize: 13)))).toList(), onChanged: (_) {}))),
          ]),
          const SizedBox(height: 28),
          LayoutBuilder(builder: (ctx, constraints) {
            const cols = 2;
            const spacing = 16.0;
            final width = (constraints.maxWidth - spacing * (cols - 1)) / cols;
            return Wrap(spacing: spacing, runSpacing: spacing, children: _jobs.map((j) => SizedBox(width: width, child: _SavedJobCard(j))).toList());
          }),
        ]),
      ),
    );
  }
}

class _SavedJobCard extends StatelessWidget {
  const _SavedJobCard(this.job);
  final _SJob job;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), child: Center(child: Text(job.company.substring(0, 2), style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)))),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(job.title, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
            Text(job.company, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
          ])),
          IconButton(icon: const Icon(Icons.bookmark_rounded, color: HireIQTheme.amber), onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          const Icon(Icons.location_on_outlined, size: 13, color: HireIQTheme.textMuted),
          const SizedBox(width: 4),
          Text(job.location, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
        ]),
        const SizedBox(height: 4),
        Row(children: [
          const Icon(Icons.access_time_rounded, size: 13, color: HireIQTheme.textMuted),
          const SizedBox(width: 4),
          Text('Saved ${job.saved}', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
        ]),
        const SizedBox(height: 14),
        Row(children: [
          Text(job.salary, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          const Spacer(),
          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Row(children: [const Icon(Icons.auto_awesome_rounded, size: 11, color: HireIQTheme.primaryTeal), const SizedBox(width: 4), Text('${job.matchiq}%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))])),
        ]),
        const SizedBox(height: 14),
        Row(children: [
          Expanded(child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.borderMedium), padding: const EdgeInsets.symmetric(vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('View Details', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)))),
          const SizedBox(width: 10),
          Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Quick Apply', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)))),
        ]),
      ]),
    );
  }
}

class _SJob { const _SJob(this.title, this.company, this.location, this.salary, this.matchiq, this.saved); final String title, company, location, salary, saved; final int matchiq; }
