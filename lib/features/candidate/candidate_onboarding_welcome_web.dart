import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateOnboardingWelcomeWeb extends ConsumerWidget {
  const CandidateOnboardingWelcomeWeb({super.key});

  static const _steps = [
    _Step(Icons.person_outlined, 'Complete Your Profile', 'Add your experience, education and skills', false),
    _Step(Icons.upload_file_outlined, 'Upload Your CV', 'Let ForgeIQ enhance your CV with AI', false),
    _Step(Icons.auto_awesome_rounded, 'Get Your MatchIQ Score', 'See how you rank against available roles', false),
    _Step(Icons.verified_user_outlined, 'PassportIQ Verification', 'Boost credibility with verified credentials', false),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
        child: Center(child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 780),
          child: Column(children: [
            // Hero
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [HireIQTheme.primaryNavy, Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(HireIQTheme.radiusXl)),
              child: Column(children: [
                Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle), child: Center(child: Text('⚡', style: GoogleFonts.inter(fontSize: 36)))),
                const SizedBox(height: 20),
                Text('Welcome to HireIQ!', style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white)),
                const SizedBox(height: 8),
                Text("South Africa's AI-powered recruitment platform. Let's get your profile set up in just a few minutes.", style: GoogleFonts.inter(fontSize: 15, color: Colors.white70, height: 1.6), textAlign: TextAlign.center),
              ]),
            ),
            const SizedBox(height: 36),
            // Steps
            Text('Getting Started', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 20),
            ..._steps.asMap().entries.map((e) {
              final step = e.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Row(children: [
                  Container(width: 36, height: 36, decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), shape: BoxShape.circle), child: Center(child: Text('${e.key + 1}', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal)))),
                  const SizedBox(width: 16),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(step.title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                    Text(step.desc, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                  ])),
                  Icon(step.icon, color: HireIQTheme.primaryTeal, size: 22),
                ]),
              );
            }),
            const SizedBox(height: 28),
            SizedBox(width: double.infinity, child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))),
              child: Text('Get Started →', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800)),
            )),
          ]),
        )),
      ),
    );
  }
}

class _Step { const _Step(this.icon, this.title, this.desc, this.done); final IconData icon; final String title, desc; final bool done; }
