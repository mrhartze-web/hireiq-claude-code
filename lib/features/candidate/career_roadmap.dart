import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CareerRoadmap extends StatelessWidget {
  const CareerRoadmap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Career Roadmap',
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
                  // ── Roadmap header card ───────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusXl),
                      border: Border.all(color: HireIQTheme.borderLight),
                      boxShadow: [
                        BoxShadow(
                          color: HireIQTheme.primaryNavy
                              .withValues(alpha: 0.05),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: HireIQTheme.primaryNavy
                                    .withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(
                                    HireIQTheme.radiusSm),
                              ),
                              child: const Icon(
                                Icons.map_outlined,
                                color: HireIQTheme.primaryNavy,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Career Roadmap',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: HireIQTheme.primaryNavy,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                Text(
                                  'Based on Johannesburg market data',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: HireIQTheme.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Path steps
                        const _PathStep(
                          label: 'CURRENT',
                          title: 'Mid Flutter Dev',
                          dotColor: HireIQTheme.primaryNavy,
                        ),
                        const _PathConnector(),
                        const _PathStep(
                          label: 'TARGET',
                          title: 'Lead Mobile Engineer',
                          dotColor: HireIQTheme.primaryTeal,
                          titleColor: HireIQTheme.primaryTeal,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Skills to develop ─────────────────────────────────
                  Text(
                    'Skills to develop',
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 14),

                  const _SkillItem(label: 'Clean Architecture'),
                  const _SkillItem(label: 'System Design'),
                  const _SkillItem(label: 'CI/CD Pipelines'),
                  const _SkillItem(label: 'Team Leadership', isLast: true),

                  const SizedBox(height: 28),

                  // ── Recommendation card ───────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          HireIQTheme.primaryNavy,
                          Color(0xFF243659),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusXl),
                      boxShadow: [
                        BoxShadow(
                          color: HireIQTheme.primaryNavy
                              .withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recommended this week',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.65),
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Complete the Flutter Architecture course to boost your skill score by +15 points.',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 11),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  HireIQTheme.radiusMd),
                            ),
                            child: Text(
                              'Start Now →',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: HireIQTheme.primaryNavy,
                              ),
                            ),
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

// ── Path step ──────────────────────────────────────────────────────────────────

class _PathStep extends StatelessWidget {
  const _PathStep({
    required this.label,
    required this.title,
    required this.dotColor,
    this.titleColor = HireIQTheme.primaryNavy,
  });

  final String label;
  final String title;
  final Color dotColor;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: HireIQTheme.textLight,
                letterSpacing: 0.8,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: titleColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Path connector ─────────────────────────────────────────────────────────────

class _PathConnector extends StatelessWidget {
  const _PathConnector();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 3, bottom: 3),
      width: 2,
      height: 28,
      decoration: BoxDecoration(
        color: HireIQTheme.borderLight,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}

// ── Skill item ─────────────────────────────────────────────────────────────────

class _SkillItem extends StatelessWidget {
  const _SkillItem({required this.label, this.isLast = false});

  final String label;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: isLast ? 0 : 10),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: HireIQTheme.textPrimary,
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: HireIQTheme.textLight,
            ),
          ],
        ),
      ),
    );
  }
}
