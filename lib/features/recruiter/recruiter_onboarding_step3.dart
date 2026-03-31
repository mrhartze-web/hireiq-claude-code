import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class RecruiterOnboardingStep3 extends ConsumerStatefulWidget {
  const RecruiterOnboardingStep3({super.key});

  @override
  ConsumerState<RecruiterOnboardingStep3> createState() =>
      _RecruiterOnboardingStep3State();
}

class _RecruiterOnboardingStep3State
    extends ConsumerState<RecruiterOnboardingStep3>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.surfaceWhite,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        title: Text(
          'All Done',
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
              value: 1.0,
              backgroundColor: HireIQTheme.borderLight,
              valueColor: const AlwaysStoppedAnimation<Color>(
                  HireIQTheme.primaryTeal),
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Step 4 of 4',
                style: GoogleFonts.inter(
                  color: HireIQTheme.textMuted,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Animated checkmark
            Center(
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color:
                        HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    size: 48,
                    color: HireIQTheme.primaryTeal,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
            Center(
              child: Text(
                "You're ready to place!",
                style: GoogleFonts.inter(
                  color: HireIQTheme.primaryNavy,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                "Your recruiter profile is set up. Here's what to do next:",
                style: GoogleFonts.inter(
                  color: HireIQTheme.textMuted,
                  fontSize: 14,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 32),

            // Next steps
            _NextStepCard(
              iconBgColor:
                  HireIQTheme.primaryTeal.withValues(alpha: 0.08),
              icon: Icons.upload_file_outlined,
              iconColor: HireIQTheme.primaryTeal,
              title: 'Upload your first brief',
              subtitle:
                  'Add a client brief to start matching candidates',
              onTap: () => context.push('/recruiter/brief-builder'),
            ),
            _NextStepCard(
              iconBgColor:
                  HireIQTheme.recruiterAccent.withValues(alpha: 0.08),
              icon: Icons.search_rounded,
              iconColor: HireIQTheme.recruiterAccent,
              title: 'Search candidate pool',
              subtitle:
                  'Browse verified candidates in our database',
              onTap: () =>
                  context.push('/recruiter/candidate-search'),
            ),
            _NextStepCard(
              iconBgColor:
                  HireIQTheme.primaryNavy.withValues(alpha: 0.08),
              icon: Icons.bar_chart_outlined,
              iconColor: HireIQTheme.primaryNavy,
              title: 'Set up SignalIQ preferences',
              subtitle:
                  'Configure your market intelligence alerts',
              onTap: () => context.push('/recruiter/signal-iq'),
            ),

            const SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.amber,
                  foregroundColor: HireIQTheme.primaryNavy,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                ),
                onPressed: () => context.go('/recruiter'),
                child: Text(
                  'Go to Dashboard',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextStepCard extends StatelessWidget {
  final Color iconBgColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _NextStepCard({
    required this.iconBgColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: HireIQTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
          border: Border.all(color: HireIQTheme.borderLight),
          boxShadow: [
            BoxShadow(
              color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius:
                    BorderRadius.circular(HireIQTheme.radiusMd),
              ),
              child: Icon(icon, size: 22, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: HireIQTheme.primaryNavy,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: HireIQTheme.textMuted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: HireIQTheme.textLight,
            ),
          ],
        ),
      ),
    );
  }
}
