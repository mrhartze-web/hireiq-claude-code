import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateUpliftIqWeb extends ConsumerWidget {
  const CandidateUpliftIqWeb({super.key});

  static const _courses = [
    _Course('System Design Fundamentals', 'Coursera', '12h', 'Architecture', 0.42),
    _Course('Flutter Advanced Patterns', 'Udemy', '8h', 'Mobile', 0.80),
    _Course('AWS Cloud Practitioner', 'AWS Training', '20h', 'Cloud', 0.0),
    _Course('Product Management Basics', 'Product School', '15h', 'Leadership', 0.0),
  ];

  static const _achievements = [
    _Ach('🏆', 'Flutter Expert', 'Completed 5 Flutter courses', true),
    _Ach('🚀', 'Fast Learner', 'Finished a course in under 3 days', true),
    _Ach('⭐', 'All-Rounder', 'Skills in 5+ different areas', false),
    _Ach('🔥', 'On a Streak', '7-day learning streak', false),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('UpliftIQ', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('AI-powered skill upskilling — grow your MatchIQ score', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.borderLight)), child: Row(children: [const Icon(Icons.auto_awesome_rounded, size: 14, color: HireIQTheme.primaryTeal), const SizedBox(width: 6), Text('MatchIQ: 94% → could reach 98%', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))])),
          ]),
          const SizedBox(height: 32),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: courses
            Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Recommended Courses', style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 14),
              ..._courses.map((c) => Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(c.title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                      Text('${c.provider} · ${c.duration}', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                    ])),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(c.category, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
                  ]),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: LinearProgressIndicator(value: c.progress, minHeight: 8, backgroundColor: HireIQTheme.borderLight, valueColor: const AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal)))),
                    const SizedBox(width: 10),
                    Text(c.progress == 0.0 ? 'Start' : '${(c.progress * 100).round()}%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: c.progress == 0.0 ? HireIQTheme.textMuted : HireIQTheme.primaryTeal)),
                    const SizedBox(width: 14),
                    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: c.progress > 0 ? HireIQTheme.primaryNavy : HireIQTheme.amber, foregroundColor: c.progress > 0 ? Colors.white : HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text(c.progress > 0 ? 'Continue' : 'Start', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700))),
                  ]),
                ]),
              )),
            ])),
            const SizedBox(width: 28),
            // Right: achievements
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Achievements', style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 14),
              ..._achievements.map((a) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: a.earned ? HireIQTheme.surfaceWhite : HireIQTheme.background, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: a.earned ? HireIQTheme.amber.withValues(alpha: 0.3) : HireIQTheme.borderLight)),
                child: Row(children: [
                  Text(a.emoji, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(a.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: a.earned ? HireIQTheme.textPrimary : HireIQTheme.textMuted)),
                    Text(a.desc, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                  ])),
                  if (a.earned) const Icon(Icons.check_circle_rounded, color: HireIQTheme.success, size: 20),
                ]),
              )),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.primaryNavy, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Learning Streak', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 8),
                  Row(children: [
                    Text('4', style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w900, color: HireIQTheme.amber)),
                    const SizedBox(width: 8),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('days', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)), Text('in a row', style: GoogleFonts.inter(fontSize: 12, color: Colors.white60))]),
                  ]),
                ]),
              ),
            ])),
          ]),
        ]),
      ),
    );
  }
}

class _Course { const _Course(this.title, this.provider, this.duration, this.category, this.progress); final String title, provider, duration, category; final double progress; }
class _Ach { const _Ach(this.emoji, this.title, this.desc, this.earned); final String emoji, title, desc; final bool earned; }
