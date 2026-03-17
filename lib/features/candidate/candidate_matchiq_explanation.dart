import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateMatchIqExplanation extends StatelessWidget {
  const CandidateMatchIqExplanation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Pinned app bar ───────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            title: Text(
              'MatchIQ Score',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Score hero card ──────────────────────────────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 36, horizontal: 24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          HireIQTheme.primaryNavy,
                          Color(0xFF243659),
                        ],
                      ),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusXl),
                      boxShadow: [
                        BoxShadow(
                          color:
                              HireIQTheme.primaryNavy.withValues(alpha: 0.3),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Dual-ring
                        SizedBox(
                          width: 130,
                          height: 130,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const SizedBox.expand(
                                child: CircularProgressIndicator(
                                  value: 1.0,
                                  strokeWidth: 10,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0x33FFFFFF),
                                  ),
                                  strokeCap: StrokeCap.round,
                                ),
                              ),
                              const SizedBox.expand(
                                child: CircularProgressIndicator(
                                  value: 0.92,
                                  strokeWidth: 10,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    HireIQTheme.primaryTeal,
                                  ),
                                  strokeCap: StrokeCap.round,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '92',
                                    style: GoogleFonts.inter(
                                      fontSize: 38,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: -1.5,
                                      height: 1,
                                    ),
                                  ),
                                  Text(
                                    '/ 100',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.white
                                          .withValues(alpha: 0.55),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        Text(
                          'Excellent Match',
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.4,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          'Your profile is highly aligned with this role\nbased on our AI analysis.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.65),
                            height: 1.55,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Pill badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 7),
                          decoration: BoxDecoration(
                            color: HireIQTheme.primaryTeal
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(
                                HireIQTheme.radiusFull),
                            border: Border.all(
                              color: HireIQTheme.primaryTeal
                                  .withValues(alpha: 0.4),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.auto_awesome,
                                size: 13,
                                color: HireIQTheme.primaryTeal,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'MatchIQ Powered',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: HireIQTheme.primaryTeal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── Score breakdown ────────────────────────────────────
                  Text(
                    'Score Breakdown',
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy,
                      letterSpacing: -0.3,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const _BreakdownCard(
                    title: 'Skills Match',
                    percentage: 0.95,
                    detail:
                        '95% match on required and preferred skills.',
                  ),
                  const _BreakdownCard(
                    title: 'Experience Level',
                    percentage: 0.88,
                    detail:
                        '88% match based on your years in the industry.',
                  ),
                  const _BreakdownCard(
                    title: 'Culture Fit',
                    percentage: 0.90,
                    detail:
                        '90% alignment with company values from your video pitch.',
                    isLast: true,
                  ),

                  const SizedBox(height: 28),

                  // ── Tip card ───────────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: HireIQTheme.primaryTeal.withValues(alpha: 0.06),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg),
                      border: Border.all(
                        color: HireIQTheme.primaryTeal.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: HireIQTheme.primaryTeal
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(
                                HireIQTheme.radiusSm),
                          ),
                          child: const Icon(
                            Icons.lightbulb_outline_rounded,
                            color: HireIQTheme.primaryTeal,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Boost your score',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: HireIQTheme.primaryNavy,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Complete your PassportIQ verification to boost your overall MatchIQ trust score by 5%.',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: HireIQTheme.textSecondary,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Breakdown card ─────────────────────────────────────────────────────────────

class _BreakdownCard extends StatelessWidget {
  const _BreakdownCard({
    required this.title,
    required this.percentage,
    required this.detail,
    this.isLast = false,
  });

  final String title;
  final double percentage;
  final String detail;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: HireIQTheme.primaryNavy,
                  letterSpacing: -0.1,
                ),
              ),
              Text(
                '${(percentage * 100).toInt()}%',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.primaryTeal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 6,
              backgroundColor: HireIQTheme.borderLight,
              valueColor: const AlwaysStoppedAnimation<Color>(
                HireIQTheme.primaryTeal,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            detail,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: HireIQTheme.textMuted,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
