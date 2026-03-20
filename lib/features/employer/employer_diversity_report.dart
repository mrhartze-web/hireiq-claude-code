import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerDiversityReport extends ConsumerWidget {
  const EmployerDiversityReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              'Diversity Report',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.ios_share_outlined,
                    size: 20, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── B-BBEE Score ──────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [HireIQTheme.primaryNavy, Color(0xFF243659)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'B-BBEE Scorecard',
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Based on your hiring data',
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color:
                                      Colors.white.withValues(alpha: 0.6)),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Text(
                                  'Level 2',
                                  style: GoogleFonts.inter(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w900,
                                      color: HireIQTheme.amber),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '≥ 95 points',
                                      style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: Colors.white
                                              .withValues(alpha: 0.7)),
                                    ),
                                    Text(
                                      'Verified by ShieldIQ',
                                      style: GoogleFonts.inter(
                                          fontSize: 11,
                                          color: HireIQTheme.success),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.verified_rounded,
                            color: HireIQTheme.amber, size: 36),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Gender Split ──────────────────────────────────────────
                Text(
                  'Gender Distribution',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
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
                    children: [
                      _DiversityBar('Female', 0.42, HireIQTheme.primaryTeal,
                          '42%'),
                      const SizedBox(height: 12),
                      _DiversityBar('Male', 0.55, HireIQTheme.primaryNavy, '55%'),
                      const SizedBox(height: 12),
                      _DiversityBar(
                          'Non-binary / Other', 0.03, const Color(0xFF7C3AED), '3%'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Race Split ────────────────────────────────────────────
                Text(
                  'Racial Demographics',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
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
                    children: [
                      _DiversityBar('Black African', 0.58, HireIQTheme.success, '58%'),
                      const SizedBox(height: 12),
                      _DiversityBar('Coloured', 0.16, HireIQTheme.amber, '16%'),
                      const SizedBox(height: 12),
                      _DiversityBar('Indian/Asian', 0.12, HireIQTheme.primaryTeal, '12%'),
                      const SizedBox(height: 12),
                      _DiversityBar('White', 0.14, HireIQTheme.primaryNavy, '14%'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Recommendations ───────────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: HireIQTheme.amber.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                    border: Border.all(
                        color: HireIQTheme.amber.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.auto_awesome_rounded,
                              size: 18, color: HireIQTheme.amber),
                          const SizedBox(width: 8),
                          Text(
                            'MatchIQ Diversity Tip',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: HireIQTheme.primaryNavy),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Increasing female representation in technical roles by 8% would move your B-BBEE score to Level 1. MatchIQ recommends activating "diversity-boosted" search filters on your next job post.',
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            color: HireIQTheme.textMuted,
                            height: 1.5),
                      ),
                      const SizedBox(height: 14),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: HireIQTheme.amber,
                            borderRadius:
                                BorderRadius.circular(HireIQTheme.radiusMd),
                          ),
                          child: Text(
                            'Enable Diversity Search',
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: HireIQTheme.primaryNavy),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _DiversityBar(
    String label, double value, Color color, String percentage) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: HireIQTheme.textPrimary),
          ),
          Text(
            percentage,
            style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: color),
          ),
        ],
      ),
      const SizedBox(height: 6),
      LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: HireIQTheme.borderLight,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              height: 8,
              width: constraints.maxWidth * value,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
