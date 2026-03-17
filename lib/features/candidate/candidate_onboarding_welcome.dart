import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateOnboardingWelcome extends StatelessWidget {
  const CandidateOnboardingWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.primaryNavy,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),
          child: Column(
            children: [
              const Spacer(),

              // Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: HireIQTheme.primaryTeal.withValues(alpha: 0.25),
                      blurRadius: 32,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.handshake_outlined,
                  color: HireIQTheme.primaryTeal,
                  size: 46,
                ),
              ),

              const SizedBox(height: 40),

              Text(
                'Welcome to HireIQ',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.7,
                  height: 1.15,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                "You're signing up as a Candidate. Let's get your profile set up so employers can find you.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: Colors.white.withValues(alpha: 0.65),
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 40),

              // Steps card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: HireIQTheme.surfaceWhite,
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Next steps:',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy,
                        letterSpacing: -0.1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const _StepRow(
                      icon: Icons.person_outline_rounded,
                      text: 'Complete your profile details',
                    ),
                    const SizedBox(height: 12),
                    const _StepRow(
                      icon: Icons.verified_user_outlined,
                      text: 'Verify with PassportIQ',
                    ),
                    const SizedBox(height: 12),
                    const _StepRow(
                      icon: Icons.auto_awesome,
                      text: 'Get your initial MatchIQ score',
                    ),
                  ],
                ),
              ),

              const Spacer(),

              GestureDetector(
                onTap: () => context.go('/candidate/home'),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        HireIQTheme.primaryTeal,
                        Color(0xFF0A7A70),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                    boxShadow: [
                      BoxShadow(
                        color:
                            HireIQTheme.primaryTeal.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: HireIQTheme.primaryTeal, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: HireIQTheme.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
