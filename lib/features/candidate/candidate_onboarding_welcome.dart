import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:go_router/go_router.dart';

class CandidateOnboardingWelcome extends StatelessWidget {
  const CandidateOnboardingWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.primaryNavy,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.handshake_outlined,
                    color: HireIQTheme.primaryTeal, size: 80),
              ),
              const SizedBox(height: 48),
              const Text(
                'Welcome to HireIQ',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "You're signing up as a Candidate. Let's get your profile set up so employers can find you.",
                style:
                    TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: HireIQTheme.surfaceWhite,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    Text('Next steps:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: HireIQTheme.primaryNavy)),
                    SizedBox(height: 16),
                    _StepRow(
                        icon: Icons.person_outline,
                        text: 'Complete your profile details'),
                    SizedBox(height: 12),
                    _StepRow(
                        icon: Icons.verified_user_outlined,
                        text: 'Verify with PassportIQ'),
                    SizedBox(height: 12),
                    _StepRow(
                        icon: Icons.auto_awesome,
                        text: 'Get your initial MatchIQ score'),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => context.go('/candidate/home'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  backgroundColor: HireIQTheme.primaryTeal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Get Started',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _StepRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: HireIQTheme.primaryTeal, size: 20),
        const SizedBox(width: 12),
        Expanded(
            child: Text(text,
                style: const TextStyle(
                    color: HireIQTheme.primaryNavy,
                    fontWeight: FontWeight.w500))),
      ],
    );
  }
}
