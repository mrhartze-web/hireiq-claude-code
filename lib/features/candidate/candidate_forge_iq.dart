import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateForgeIq extends StatelessWidget {
  const CandidateForgeIq({super.key});

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
              'ForgeIQ CV Builder',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.2),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: Text(
                    'Save & Export',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── AI Banner ─────────────────────────────────────────
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
                              .withValues(alpha: 0.25),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: HireIQTheme.primaryTeal
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(
                                HireIQTheme.radiusMd),
                          ),
                          child: const Icon(
                            Icons.build_circle_rounded,
                            color: HireIQTheme.primaryTeal,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AI CV Optimizer',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'ForgeIQ formats and optimizes your experience for ATS systems.',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.white
                                      .withValues(alpha: 0.65),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── Experience ─────────────────────────────────────────
                  const _SectionHeader(title: 'Experience'),
                  const SizedBox(height: 14),
                  const _CvListItem(
                    title: 'Senior Backend Engineer',
                    subtitle: 'Apex Digital  ·  2021 – Present',
                  ),
                  const _CvListItem(
                    title: 'Software Developer',
                    subtitle: 'FinTech Startup  ·  2018 – 2021',
                  ),
                  _AddButton(label: 'Add Experience', onTap: () {}),

                  const SizedBox(height: 28),

                  // ── Education ──────────────────────────────────────────
                  const _SectionHeader(title: 'Education'),
                  const SizedBox(height: 14),
                  const _CvListItem(
                    title: 'BSc Computer Science',
                    subtitle: 'University of Cape Town  ·  2014 – 2017',
                  ),
                  _AddButton(label: 'Add Education', onTap: () {}),

                  const SizedBox(height: 28),

                  // ── Skills ─────────────────────────────────────────────
                  const _SectionHeader(title: 'Skills'),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['Flutter', 'Dart', 'Firebase', 'Go', 'AWS']
                        .map(
                          (skill) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 7),
                            decoration: BoxDecoration(
                              color: HireIQTheme.surfaceWhite,
                              borderRadius: BorderRadius.circular(
                                  HireIQTheme.radiusFull),
                              border: Border.all(
                                  color: HireIQTheme.borderLight),
                              boxShadow: [
                                BoxShadow(
                                  color: HireIQTheme.primaryNavy
                                      .withValues(alpha: 0.04),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  skill,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: HireIQTheme.textPrimary,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.close_rounded,
                                    size: 14,
                                    color: HireIQTheme.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  _AddButton(label: 'Add Skill', onTap: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Section header ─────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: HireIQTheme.primaryNavy,
        letterSpacing: -0.3,
      ),
    );
  }
}

// ── CV list item ───────────────────────────────────────────────────────────────

class _CvListItem extends StatelessWidget {
  const _CvListItem({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: HireIQTheme.primaryNavy,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: HireIQTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: HireIQTheme.backgroundLight,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusSm),
              ),
              child: const Icon(
                Icons.edit_outlined,
                size: 16,
                color: HireIQTheme.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Add button ─────────────────────────────────────────────────────────────────

class _AddButton extends StatelessWidget {
  const _AddButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: HireIQTheme.primaryTeal.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
          border: Border.all(
            color: HireIQTheme.primaryTeal.withValues(alpha: 0.25),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_rounded,
              size: 18,
              color: HireIQTheme.primaryTeal,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: HireIQTheme.primaryTeal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
