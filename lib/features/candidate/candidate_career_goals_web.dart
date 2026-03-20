import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateCareerGoalsWeb extends ConsumerWidget {
  const CandidateCareerGoalsWeb({super.key});

  static const _goals = [
    _Goal('Become a Principal Engineer', 'Senior role', 0.7, 'On track'),
    _Goal('Earn 6-figure salary', 'Compensation', 0.5, 'Building'),
    _Goal('Lead a product team', 'Leadership', 0.3, 'Early'),
  ];

  static const _recs = [
    'Complete System Design course on Coursera',
    'Add 3 technical certifications to profile',
    'Contribute to 2 open source projects',
    'Apply for Senior Engineer roles (match: 88%+)',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Career Goals', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Track your career progression with UpliftIQ insights', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 32),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: Goals list
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text('My Goals', style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const Spacer(),
                ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, size: 14), label: Text('Add Goal', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
              ]),
              const SizedBox(height: 14),
              ..._goals.map((g) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Text(g.title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary))),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(g.status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))),
                  ]),
                  Text(g.category, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: LinearProgressIndicator(value: g.progress, minHeight: 8, backgroundColor: HireIQTheme.borderLight, valueColor: const AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal)))),
                    const SizedBox(width: 12),
                    Text('${(g.progress * 100).round()}%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  ]),
                ]),
              )),
            ])),
            const SizedBox(width: 24),
            // Centre: Progress overview
            Expanded(child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Overall Progress', style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 20),
                Center(child: Stack(alignment: Alignment.center, children: [
                  SizedBox(width: 140, height: 140, child: CircularProgressIndicator(value: 0.5, strokeWidth: 12, backgroundColor: HireIQTheme.borderLight, color: HireIQTheme.primaryTeal)),
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    Text('50%', style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
                    Text('to goals', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                  ]),
                ])),
                const SizedBox(height: 20),
                ...['3 active goals', '2 milestones this month', '87% profile strength'].map((t) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(children: [const Icon(Icons.check_circle_rounded, color: HireIQTheme.success, size: 16), const SizedBox(width: 8), Text(t, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))]),
                )),
              ]),
            )),
            const SizedBox(width: 24),
            // Right: UpliftIQ recommendations
            Expanded(child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  const Icon(Icons.rocket_launch_rounded, color: HireIQTheme.primaryTeal, size: 18),
                  const SizedBox(width: 8),
                  Text('UpliftIQ Suggestions', style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                ]),
                const SizedBox(height: 16),
                ..._recs.asMap().entries.map((e) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: HireIQTheme.background, borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.borderLight)),
                  child: Row(children: [
                    CircleAvatar(radius: 12, backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.1), child: Text('${e.key + 1}', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal))),
                    const SizedBox(width: 10),
                    Expanded(child: Text(e.value, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textPrimary))),
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

class _Goal { const _Goal(this.title, this.category, this.progress, this.status); final String title, category, status; final double progress; }
