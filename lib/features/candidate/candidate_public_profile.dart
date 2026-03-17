import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidatePublicProfile extends StatelessWidget {
  const CandidatePublicProfile({super.key});

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
              'Public Profile',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
              child: Column(
                children: [
                  // ── Profile card ──────────────────────────────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusXl),
                      border: Border.all(color: HireIQTheme.borderLight),
                      boxShadow: [
                        BoxShadow(
                          color: HireIQTheme.primaryNavy
                              .withValues(alpha: 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Avatar with verified badge
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: HireIQTheme.primaryTeal,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: HireIQTheme.primaryTeal
                                        .withValues(alpha: 0.25),
                                    blurRadius: 16,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 44,
                                backgroundColor: HireIQTheme.primaryNavy,
                                child: Text(
                                  'D',
                                  style: GoogleFonts.inter(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  color: HireIQTheme.surfaceWhite,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.verified_rounded,
                                  color: HireIQTheme.primaryTeal,
                                  size: 22,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Text(
                          'Dwayne Johnson',
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: HireIQTheme.primaryNavy,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Senior Backend Engineer',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: HireIQTheme.textMuted,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Location + badge row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: HireIQTheme.primaryTeal,
                              size: 15,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Johannesburg · Remote OK',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: HireIQTheme.textSecondary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: HireIQTheme.primaryTeal
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                    HireIQTheme.radiusFull),
                              ),
                              child: Text(
                                'Top 5% MatchIQ',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: HireIQTheme.primaryTeal,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),
                        const Divider(color: HireIQTheme.borderLight),
                        const SizedBox(height: 20),

                        // About
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'About',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: HireIQTheme.primaryNavy,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Experienced software engineer specializing in scalable backend systems, microservices architecture, and cloud infrastructure.',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: HireIQTheme.textSecondary,
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Top skills
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Top Skills',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: HireIQTheme.primaryNavy,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            'Go',
                            'PostgreSQL',
                            'Docker',
                            'Kubernetes',
                            'AWS',
                            'Python',
                          ]
                              .map(
                                (skill) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: HireIQTheme.primaryTeal
                                        .withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(
                                        HireIQTheme.radiusFull),
                                    border: Border.all(
                                      color: HireIQTheme.primaryTeal
                                          .withValues(alpha: 0.2),
                                    ),
                                  ),
                                  child: Text(
                                    skill,
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: HireIQTheme.primaryTeal,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
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
