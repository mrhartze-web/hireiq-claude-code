import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CVPreviewScreen extends StatelessWidget {
  const CVPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.backgroundLight,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'CV Preview',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.download_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              // White CV document on grey background
              child: Container(
                decoration: BoxDecoration(
                  color: HireIQTheme.surfaceWhite,
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusMd),
                  boxShadow: [
                    BoxShadow(
                      color: HireIQTheme.primaryNavy
                          .withValues(alpha: 0.12),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Header ─────────────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'THABO NKOSI',
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: HireIQTheme.primaryNavy,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Senior Flutter Developer',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: HireIQTheme.primaryTeal,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: HireIQTheme.backgroundLight,
                            borderRadius: BorderRadius.circular(
                                HireIQTheme.radiusSm),
                          ),
                          child: const Icon(
                            Icons.contact_mail_outlined,
                            size: 22,
                            color: HireIQTheme.textMuted,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    const Divider(color: HireIQTheme.borderLight),
                    const SizedBox(height: 20),

                    // ── Experience ─────────────────────────────────────
                    const _CvSectionTitle(title: 'EXPERIENCE'),
                    const SizedBox(height: 12),
                    const _CvExperienceItem(
                      company: 'FinServ SA',
                      role: 'Senior Flutter Developer',
                      period: '2021 – Present',
                      description:
                          'Led cross-platform mobile development for flagship banking apps with 1M+ active users.',
                    ),
                    const _CvExperienceItem(
                      company: 'TechFlow',
                      role: 'Mobile Developer',
                      period: '2019 – 2021',
                      description:
                          'Developed and maintained the core mobile application using Flutter and Dart.',
                    ),

                    const SizedBox(height: 8),
                    const Divider(color: HireIQTheme.borderLight),
                    const SizedBox(height: 20),

                    // ── Expertise ──────────────────────────────────────
                    const _CvSectionTitle(title: 'EXPERTISE'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        'Flutter',
                        'Dart',
                        'Riverpod',
                        'Firebase',
                        'Clean Architecture',
                      ]
                          .map(
                            (label) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: HireIQTheme.backgroundLight,
                                borderRadius: BorderRadius.circular(
                                    HireIQTheme.radiusSm),
                                border: Border.all(
                                    color: HireIQTheme.borderLight),
                              ),
                              child: Text(
                                label,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: HireIQTheme.textSecondary,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),

                    const SizedBox(height: 24),
                    const Divider(color: HireIQTheme.borderLight),
                    const SizedBox(height: 20),

                    // ── Education ──────────────────────────────────────
                    const _CvSectionTitle(title: 'EDUCATION'),
                    const SizedBox(height: 12),
                    Text(
                      'BSc Computer Science',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'University of Cape Town',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: HireIQTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── CV section title ───────────────────────────────────────────────────────────

class _CvSectionTitle extends StatelessWidget {
  const _CvSectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: HireIQTheme.textLight,
        letterSpacing: 1.5,
      ),
    );
  }
}

// ── CV experience item ─────────────────────────────────────────────────────────

class _CvExperienceItem extends StatelessWidget {
  const _CvExperienceItem({
    required this.company,
    required this.role,
    required this.period,
    required this.description,
  });

  final String company;
  final String role;
  final String period;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                company,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.primaryNavy,
                ),
              ),
              Text(
                period,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: HireIQTheme.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            role,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: HireIQTheme.primaryTeal,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: HireIQTheme.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
