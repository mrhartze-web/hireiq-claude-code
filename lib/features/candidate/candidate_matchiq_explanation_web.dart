import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateMatchIqExplanationWeb extends ConsumerWidget {
  const CandidateMatchIqExplanationWeb({super.key});

  static const _categories = [
    _Cat('Skills Match', 0.78, 'Your listed skills cover 78% of required skills for this role.', HireIQTheme.primaryTeal),
    _Cat('Experience Level', 0.90, '5 years vs 4 years required. Strong seniority match.', HireIQTheme.success),
    _Cat('Location Fit', 0.95, 'Based in Cape Town, same as employer. Ideal fit.', HireIQTheme.info),
    _Cat('Salary Alignment', 0.70, 'Your target is R10k above the midpoint. Some risk.', HireIQTheme.warning),
    _Cat('Culture Fit', 0.85, 'Work style and values align with TechFlow culture data.', HireIQTheme.primaryNavy),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('MatchIQ Explained', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Understand how your MatchIQ score is calculated', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: score ring + breakdown
            Expanded(child: Column(children: [
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(children: [
                  SizedBox(width: 160, height: 160, child: Stack(alignment: Alignment.center, children: [
                    CircularProgressIndicator(value: 0.87, strokeWidth: 16, backgroundColor: HireIQTheme.borderLight, valueColor: const AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal)),
                    Column(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.auto_awesome_rounded, color: HireIQTheme.primaryTeal, size: 20),
                      Text('87%', style: GoogleFonts.inter(fontSize: 40, fontWeight: FontWeight.w900, color: HireIQTheme.primaryNavy)),
                      Text('MatchIQ', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)),
                    ]),
                  ])),
                  const SizedBox(height: 24),
                  Text('For: Senior Flutter Developer — TechFlow Solutions', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                ]),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Score Breakdown', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 16),
                  ..._categories.map((c) => Padding(padding: const EdgeInsets.only(bottom: 14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Expanded(child: Text(c.label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary))),
                      Text('${(c.score * 100).round()}%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: c.color)),
                    ]),
                    const SizedBox(height: 6),
                    ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: LinearProgressIndicator(value: c.score, minHeight: 10, backgroundColor: HireIQTheme.borderLight, valueColor: AlwaysStoppedAnimation<Color>(c.color))),
                  ]))),
                ]),
              ),
            ])),
            const SizedBox(width: 24),
            // Right: explanation + improvement
            Expanded(child: Column(children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Factor Explanations', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 14),
                  ..._categories.map((c) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: c.color.withValues(alpha: 0.04), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: c.color.withValues(alpha: 0.15))),
                    child: Row(children: [
                      Container(width: 36, height: 36, decoration: BoxDecoration(color: c.color.withValues(alpha: 0.1), shape: BoxShape.circle), child: Center(child: Text('${(c.score * 100).round()}', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: c.color)))),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(c.label, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                        Text(c.explanation, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted, height: 1.4)),
                      ])),
                    ]),
                  )),
                ]),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.2))),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [const Icon(Icons.auto_awesome_rounded, color: HireIQTheme.primaryTeal, size: 16), const SizedBox(width: 6), Text('How to Improve', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))]),
                  const SizedBox(height: 12),
                  ...[
                    'Add Riverpod and BLoC to your skills list',
                    'Adjust your salary expectation to R85k–R100k',
                    'Add a portfolio project with Firebase integration',
                    'Complete PassportIQ for +5 bonus points',
                  ].map((a) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.arrow_forward_rounded, size: 14, color: HireIQTheme.primaryTeal), const SizedBox(width: 8), Expanded(child: Text(a, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textPrimary, height: 1.4)))]))),
                ]),
              ),
            ])),
          ]),
        ]),
      ),
    );
  }
}

class _Cat {
  const _Cat(this.label, this.score, this.explanation, this.color);
  final String label, explanation;
  final double score;
  final Color color;
}
