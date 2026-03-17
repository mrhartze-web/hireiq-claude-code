import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateGigFeed extends StatelessWidget {
  const CandidateGigFeed({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> gigs = [
      {
        'id': 'g1',
        'title': 'Flutter App — Fintech Dashboard',
        'company': 'Apex Digital',
        'budget': 'R15,000',
        'duration': '2 weeks',
        'tags': 'Flutter, Firebase',
      },
      {
        'id': 'g2',
        'title': 'Brand Identity & Design System',
        'company': 'Synergy Labs',
        'budget': 'R8,500',
        'duration': '1 week',
        'tags': 'UI/UX, Figma',
      },
      {
        'id': 'g3',
        'title': 'Data Pipeline — Firebase to BigQuery',
        'company': 'M-Pesa Africa',
        'budget': 'R25,000',
        'duration': '3 weeks',
        'tags': 'Cloud, SQL',
      },
    ];

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
              'Gig Marketplace',
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
                  Icons.filter_list_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final gig = gigs[index];
                  return _GigCard(gig: gig);
                },
                childCount: gigs.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Gig card ────────────────────────────────────────────────────────────────

class _GigCard extends StatelessWidget {
  const _GigCard({required this.gig});

  final Map<String, String> gig;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/candidate/gigs/${gig['id']}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
            // Top row: New Gig pill + budget
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color:
                        HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: Text(
                    'New Gig',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryTeal,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Text(
                  gig['budget']!,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: HireIQTheme.primaryNavy,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Title
            Text(
              gig['title']!,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: HireIQTheme.primaryNavy,
                letterSpacing: -0.2,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              gig['company']!,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: HireIQTheme.textMuted,
              ),
            ),

            const SizedBox(height: 14),

            // Meta row
            Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  size: 14,
                  color: HireIQTheme.textMuted,
                ),
                const SizedBox(width: 4),
                Text(
                  gig['duration']!,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: HireIQTheme.textMuted,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.label_outline_rounded,
                  size: 14,
                  color: HireIQTheme.textMuted,
                ),
                const SizedBox(width: 4),
                Text(
                  gig['tags']!,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: HireIQTheme.textMuted,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(color: HireIQTheme.borderLight, height: 1),
            const SizedBox(height: 14),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () =>
                      context.push('/candidate/gigs/${gig['id']}'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    child: Text(
                      'View Details',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: HireIQTheme.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 9),
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
                          BorderRadius.circular(HireIQTheme.radiusFull),
                      boxShadow: [
                        BoxShadow(
                          color: HireIQTheme.primaryNavy
                              .withValues(alpha: 0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      'Apply Now',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
