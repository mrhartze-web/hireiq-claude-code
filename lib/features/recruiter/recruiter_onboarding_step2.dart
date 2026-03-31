import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class RecruiterOnboardingStep2 extends ConsumerWidget {
  const RecruiterOnboardingStep2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.surfaceWhite,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        title: Text(
          'Choose Your Plan',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress
            LinearProgressIndicator(
              value: 0.75,
              backgroundColor: HireIQTheme.borderLight,
              valueColor: const AlwaysStoppedAnimation<Color>(
                  HireIQTheme.primaryTeal),
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Step 3 of 4',
                style: GoogleFonts.inter(
                  color: HireIQTheme.textMuted,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Text(
              'Choose your plan',
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 24),

            // Solo plan card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Solo',
                        style: GoogleFonts.inter(
                          color: HireIQTheme.primaryNavy,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'R2,999',
                            style: GoogleFonts.inter(
                              color: HireIQTheme.primaryNavy,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            '/month',
                            style: GoogleFonts.inter(
                              color: HireIQTheme.textMuted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...[
                    'CRM pipeline',
                    'CV vault',
                    'Brief upload & management',
                    'ShieldIQ fraud detection',
                    'SignalIQ market intelligence',
                  ].map(
                    (feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 16,
                            color: HireIQTheme.primaryTeal,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            feature,
                            style: GoogleFonts.inter(
                              color: HireIQTheme.textPrimary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: HireIQTheme.primaryNavy),
                        foregroundColor: HireIQTheme.primaryNavy,
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusMd),
                        ),
                      ),
                      onPressed: () =>
                          context.go('/recruiter/onboarding/step-3'),
                      child: Text(
                        'Start Free Trial — 14 days',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Agency plan card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryNavy,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                boxShadow: [
                  BoxShadow(
                    color: HireIQTheme.primaryNavy.withValues(alpha: 0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Agency',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: HireIQTheme.amber,
                          borderRadius: BorderRadius.circular(
                              HireIQTheme.radiusFull),
                        ),
                        child: Text(
                          'Best Value',
                          style: GoogleFonts.inter(
                            color: HireIQTheme.primaryNavy,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'R19,999',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            '/month',
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...[
                    'All Solo features',
                    'Multi-seat team management',
                    'Bulk brief processing',
                    'Agency analytics',
                    'White-label reports',
                  ].map(
                    (feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 16,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            feature,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HireIQTheme.amber,
                        foregroundColor: HireIQTheme.primaryNavy,
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusMd),
                        ),
                      ),
                      onPressed: () =>
                          context.go('/recruiter/onboarding/step-3'),
                      child: Text(
                        'Start Free Trial — 14 days',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Center(
              child: Text(
                'Credit packs: R25 per credit for ad-hoc unlocks',
                style: GoogleFonts.inter(
                  color: HireIQTheme.textMuted,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: HireIQTheme.primaryTeal,
                ),
                onPressed: () =>
                    context.go('/recruiter/onboarding/step-3'),
                child: Text(
                  'Skip for now →',
                  style: GoogleFonts.inter(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
