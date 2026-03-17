import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateSmartApply extends StatelessWidget {
  const CandidateSmartApply({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ───────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Smart Apply',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: HireIQTheme.backgroundLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        size: 18,
                        color: HireIQTheme.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Scrollable body ───────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
                child: Column(
                  children: [
                    // Score ring
                    const _ScoreRing(score: 92),

                    const SizedBox(height: 20),

                    // Job label
                    Text(
                      'Senior Flutter Developer',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Apex Digital · Remote',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: HireIQTheme.textMuted,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Included card
                    const _IncludedCard(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // ── Fixed apply button ─────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                12,
                20,
                12 + MediaQuery.of(context).padding.bottom,
              ),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Application sent successfully!'),
                    ),
                  );
                },
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [HireIQTheme.primaryTeal, Color(0xFF0A7A70)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                    boxShadow: [
                      BoxShadow(
                        color: HireIQTheme.primaryTeal.withValues(alpha: 0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.bolt_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'One-Tap Apply',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
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

// ── Score ring ────────────────────────────────────────────────────────────────

class _ScoreRing extends StatelessWidget {
  const _ScoreRing({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 130,
          height: 130,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Track
              const SizedBox.expand(
                child: CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: 10,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    HireIQTheme.borderLight,
                  ),
                  strokeCap: StrokeCap.round,
                ),
              ),
              // Progress
              SizedBox.expand(
                child: CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 10,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    HireIQTheme.primaryTeal,
                  ),
                  strokeCap: StrokeCap.round,
                  backgroundColor: Colors.transparent,
                ),
              ),
              // Label
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$score',
                    style: GoogleFonts.inter(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: HireIQTheme.primaryNavy,
                      letterSpacing: -1.5,
                      height: 1,
                    ),
                  ),
                  Text(
                    '/ 100',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: HireIQTheme.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.auto_awesome,
                size: 13,
                color: HireIQTheme.primaryTeal,
              ),
              const SizedBox(width: 5),
              Text(
                'Excellent MatchIQ Fit',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.primaryTeal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Included card ─────────────────────────────────────────────────────────────

class _IncludedCard extends StatelessWidget {
  const _IncludedCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What's included in your application",
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.primaryNavy,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 16),
          const _IncludedRow(
            icon: Icons.verified_user_outlined,
            title: 'Verified PassportIQ Details',
            subtitle: 'Identity & credentials confirmed',
          ),
          const _IncludedDivider(),
          const _IncludedRow(
            icon: Icons.auto_awesome,
            title: 'WildcardIQ Assessment Score',
            subtitle: 'AI-scored capability report',
          ),
          const _IncludedDivider(),
          const _IncludedRow(
            icon: Icons.videocam_outlined,
            title: 'Video Pitch',
            subtitle: '60-second personal introduction',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _IncludedRow extends StatelessWidget {
  const _IncludedRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusSm),
            ),
            child: Icon(icon, size: 18, color: HireIQTheme.primaryTeal),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: HireIQTheme.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: HireIQTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle_rounded,
            color: HireIQTheme.primaryTeal,
            size: 18,
          ),
        ],
      ),
    );
  }
}

class _IncludedDivider extends StatelessWidget {
  const _IncludedDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(height: 1, color: HireIQTheme.borderLight),
    );
  }
}
