import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateOnboardingWelcomeWeb extends ConsumerWidget {
  const CandidateOnboardingWelcomeWeb({super.key});

  static const _steps = [
    _OStep('Create your account', true),
    _OStep('Complete your profile', true),
    _OStep('Upload your CV with ForgeIQ', false),
    _OStep('Verify identity with PassportIQ', false),
    _OStep('Apply to your first job', false),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final done = _steps.where((s) => s.done).length;
    final total = _steps.length;

    return WebLayout(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Progress bar
              Text('Getting started — $done of $total complete', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: LinearProgressIndicator(value: done / total, minHeight: 8, backgroundColor: HireIQTheme.borderLight, valueColor: const AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal))),
              const SizedBox(height: 48),
              // Hero
              Row(children: [
                Container(width: 56, height: 56, decoration: BoxDecoration(color: HireIQTheme.primaryNavy, borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), child: Center(child: Text('IQ', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w900, color: HireIQTheme.amber)))),
                const SizedBox(width: 14),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('HireIQ', style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w900, color: HireIQTheme.primaryNavy)),
                  Text('South Africa\'s AI Recruitment Platform', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)),
                ]),
              ]),
              const SizedBox(height: 32),
              Text('Welcome to HireIQ, Thabo!', style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy, height: 1.2)),
              const SizedBox(height: 12),
              Text('Let\'s get your profile set up and start connecting you to South Africa\'s best opportunities. Complete the steps below to unlock your full MatchIQ score.', style: GoogleFonts.inter(fontSize: 16, color: HireIQTheme.textMuted, height: 1.65)),
              const SizedBox(height: 36),
              // Checklist
              Container(
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(children: _steps.asMap().entries.map((e) {
                  final step = e.value;
                  final isLast = e.key == _steps.length - 1;
                  return Column(children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16), child: Row(children: [
                      Container(width: 32, height: 32, decoration: BoxDecoration(color: step.done ? HireIQTheme.success : HireIQTheme.background, shape: BoxShape.circle, border: Border.all(color: step.done ? HireIQTheme.success : HireIQTheme.borderMedium)), child: Icon(step.done ? Icons.check_rounded : Icons.circle_outlined, color: step.done ? Colors.white : HireIQTheme.borderMedium, size: 16)),
                      const SizedBox(width: 14),
                      Expanded(child: Text(step.title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: step.done ? HireIQTheme.textMuted : HireIQTheme.textPrimary, decoration: step.done ? TextDecoration.lineThrough : null))),
                      if (!step.done) Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7), decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.07), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), child: Text('Start', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
                      if (step.done) Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: HireIQTheme.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('Done', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.success))),
                    ])),
                    if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                  ]);
                }).toList()),
              ),
              const SizedBox(height: 28),
              Row(children: [
                Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Continue to Dashboard', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800)))),
                const SizedBox(width: 16),
                TextButton(onPressed: () {}, style: TextButton.styleFrom(foregroundColor: HireIQTheme.textMuted), child: Text('Skip for now', style: GoogleFonts.inter(fontSize: 13))),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}

class _OStep {
  const _OStep(this.title, this.done);
  final String title;
  final bool done;
}
