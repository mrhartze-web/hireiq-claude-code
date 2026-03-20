import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateMatchiqExplanationWeb extends ConsumerWidget {
  const CandidateMatchiqExplanationWeb({super.key});

  static const _factors = [
    _Factor('Skills Match', 0.92, HireIQTheme.primaryTeal, 'Your technical skills align closely with the role requirements'),
    _Factor('Experience Level', 0.78, HireIQTheme.info, 'Your years of experience meet the role criteria'),
    _Factor('Location Fit', 1.0, HireIQTheme.success, 'You are based in the preferred location or remote-capable'),
    _Factor('Salary Range', 0.65, HireIQTheme.warning, 'Your expectations slightly exceed the posted range'),
    _Factor('Culture Fit', 0.85, HireIQTheme.primaryNavy, 'Your profile signals align with the company culture'),
  ];

  static const _improvements = [
    'Add AWS certification to raise Skills Match by +4%',
    'Update your availability to start "immediately"',
    'Add more detailed work experience descriptions',
    'Link your GitHub profile to verify technical skills',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left: score breakdown with rings
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('MatchIQ Score Explained', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
            Text('How your 94% MatchIQ score is calculated', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            const SizedBox(height: 32),
            Center(child: Stack(alignment: Alignment.center, children: [
              SizedBox(width: 180, height: 180, child: CircularProgressIndicator(value: 0.94, strokeWidth: 16, backgroundColor: HireIQTheme.borderLight, color: HireIQTheme.primaryTeal)),
              Column(mainAxisSize: MainAxisSize.min, children: [
                Text('94%', style: GoogleFonts.inter(fontSize: 42, fontWeight: FontWeight.w900, color: HireIQTheme.primaryNavy)),
                Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.auto_awesome_rounded, size: 14, color: HireIQTheme.primaryTeal), const SizedBox(width: 4), Text('MatchIQ', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))]),
              ]),
            ])),
            const SizedBox(height: 32),
            Text('Score Components', style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 16),
            ..._factors.map((f) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Text(f.label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary))),
                  Text('${(f.score * 100).round()}%', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: f.color)),
                ]),
                const SizedBox(height: 6),
                ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: LinearProgressIndicator(value: f.score, minHeight: 10, backgroundColor: HireIQTheme.borderLight, valueColor: AlwaysStoppedAnimation<Color>(f.color))),
              ]),
            )),
          ])),
          const SizedBox(width: 40),
          // Right: improvement tips
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 66),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [const Icon(Icons.lightbulb_rounded, color: HireIQTheme.amber, size: 20), const SizedBox(width: 8), Text('How to Improve Your Score', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))]),
                const SizedBox(height: 16),
                ..._improvements.asMap().entries.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: HireIQTheme.background, borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.borderLight)), child: Row(children: [
                    CircleAvatar(radius: 12, backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.1), child: Text('${e.key + 1}', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal))),
                    const SizedBox(width: 12),
                    Expanded(child: Text(e.value, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                  ])),
                )),
              ]),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.primaryNavy, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('What is MatchIQ?', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 10),
                Text('MatchIQ is HireIQ\'s proprietary AI matching engine. It analyses 40+ data points to calculate how well your profile aligns with a specific role — giving you a transparent score you can actively improve.', style: GoogleFonts.inter(fontSize: 13, color: Colors.white70, height: 1.6)),
              ]),
            ),
          ])),
        ]),
      ),
    );
  }
}

class _Factor { const _Factor(this.label, this.score, this.color, this.desc); final String label, desc; final double score; final Color color; }
