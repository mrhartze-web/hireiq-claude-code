import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerOnboardingWeb extends ConsumerWidget {
  const EmployerOnboardingWeb({super.key});

  static const _steps = [
    _OStep(Icons.business_rounded, 'Company Profile', 'Tell candidates who you are and what you stand for'),
    _OStep(Icons.work_rounded, 'Post Your First Job', 'Create a compelling job listing with AI assistance'),
    _OStep(Icons.auto_awesome_rounded, 'Enable WildcardIQ', 'Let AI proactively find candidates that match your culture'),
    _OStep(Icons.people_rounded, 'Invite Your Team', 'Add hiring managers and interviewers to collaborate'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
        child: Center(child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [HireIQTheme.primaryNavy, Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(HireIQTheme.radiusXl)),
              child: Column(children: [
                Container(width: 70, height: 70, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle), child: const Center(child: Text('🏢', style: TextStyle(fontSize: 32)))),
                const SizedBox(height: 20),
                Text('Welcome to HireIQ for Employers', style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text("South Africa's most intelligent hiring platform. Let's get your company set up in a few minutes.", style: GoogleFonts.inter(fontSize: 15, color: Colors.white70, height: 1.6), textAlign: TextAlign.center),
              ]),
            ),
            const SizedBox(height: 36),
            Text('Your Setup Checklist', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 20),
            ..._steps.asMap().entries.map((e) {
              final isDone = e.key < 2;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: isDone ? HireIQTheme.success.withValues(alpha: 0.3) : HireIQTheme.borderLight)),
                child: Row(children: [
                  Container(width: 40, height: 40, decoration: BoxDecoration(color: isDone ? HireIQTheme.success.withValues(alpha: 0.1) : HireIQTheme.primaryTeal.withValues(alpha: 0.1), shape: BoxShape.circle), child: Center(child: isDone ? const Icon(Icons.check_rounded, color: HireIQTheme.success, size: 18) : Icon(e.value.icon, color: HireIQTheme.primaryTeal, size: 18))),
                  const SizedBox(width: 16),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(e.value.title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: isDone ? HireIQTheme.textMuted : HireIQTheme.textPrimary, decoration: isDone ? TextDecoration.lineThrough : null)),
                    Text(e.value.desc, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                  ])),
                  if (!isDone) ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.primaryNavy, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Start', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700))),
                ]),
              );
            }),
            const SizedBox(height: 20),
            ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: LinearProgressIndicator(value: 0.5, minHeight: 10, backgroundColor: HireIQTheme.borderLight, valueColor: const AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal))),
            const SizedBox(height: 8),
            Text('2 of 4 steps completed', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)),
          ]),
        )),
      ),
    );
  }
}

class _OStep { const _OStep(this.icon, this.title, this.desc); final IconData icon; final String title, desc; }
