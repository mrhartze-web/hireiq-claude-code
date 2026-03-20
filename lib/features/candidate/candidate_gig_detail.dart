import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateGigDetail extends ConsumerWidget {
  const CandidateGigDetail({super.key});

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
              'Gig Detail',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined,
                    size: 20, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Hero ─────────────────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  color: HireIQTheme.primaryNavy,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius:
                                  BorderRadius.circular(HireIQTheme.radiusMd),
                            ),
                            child: Center(
                              child: Text(
                                'TF',
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'React Native Developer',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: -0.3),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'TechFlow Solutions',
                                  style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color:
                                          Colors.white.withValues(alpha: 0.7)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _InfoChip('R65k – R85k', Icons.payments_outlined),
                          const SizedBox(width: 10),
                          _InfoChip('3 months', Icons.access_time_rounded),
                          const SizedBox(width: 10),
                          _InfoChip('Remote', Icons.location_on_outlined),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: HireIQTheme.primaryTeal
                              .withValues(alpha: 0.2),
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusFull),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.auto_awesome_rounded,
                                size: 12, color: HireIQTheme.primaryTeal),
                            const SizedBox(width: 5),
                            Text(
                              '92% MatchIQ Score',
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: HireIQTheme.primaryTeal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Body ─────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Description
                      _Section(
                        title: 'About the Gig',
                        child: Text(
                          'TechFlow Solutions is looking for an experienced React Native developer to help build and scale their flagship mobile product. You\'ll be working closely with the product and design team to deliver a polished, performant iOS and Android experience.\n\nThe ideal candidate brings strong TypeScript skills, Firebase experience, and a passion for mobile performance optimisation.',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              color: HireIQTheme.textMuted,
                              height: 1.65),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Skills required
                      _Section(
                        title: 'Required Skills',
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            'React Native',
                            'TypeScript',
                            'Firebase',
                            'REST APIs',
                            'Git',
                            'CI/CD',
                          ].map((s) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: HireIQTheme.primaryTeal
                                    .withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(
                                    HireIQTheme.radiusFull),
                                border: Border.all(
                                    color: HireIQTheme.primaryTeal
                                        .withValues(alpha: 0.3)),
                              ),
                              child: Text(
                                s,
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: HireIQTheme.primaryTeal),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Milestones
                      _Section(
                        title: 'Deliverable Milestones',
                        child: Column(
                          children: [
                            _MilestoneRow('1', 'Project setup & architecture',
                                'R20,000', '2 weeks'),
                            _MilestoneRow('2', 'Core features development',
                                'R35,000', '6 weeks'),
                            _MilestoneRow('3', 'Testing, launch & handover',
                                'R30,000', '4 weeks'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // About client
                      _Section(
                        title: 'About the Client',
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: HireIQTheme.background,
                            borderRadius:
                                BorderRadius.circular(HireIQTheme.radiusMd),
                            border: Border.all(color: HireIQTheme.borderLight),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: HireIQTheme.primaryNavy
                                      .withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(
                                      HireIQTheme.radiusMd),
                                ),
                                child: Center(
                                  child: Text(
                                    'TF',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w800,
                                        color: HireIQTheme.primaryNavy),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'TechFlow Solutions',
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: HireIQTheme.primaryNavy),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '12 gigs posted • 98% on-time payment',
                                      style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: HireIQTheme.textMuted),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Icon(Icons.star_rounded,
                                            size: 13,
                                            color: HireIQTheme.amber),
                                        const SizedBox(width: 3),
                                        Text(
                                          '4.9 (34 reviews)',
                                          style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: HireIQTheme.textPrimary),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // ── Sticky Bottom Actions ─────────────────────────────────────────────
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: BoxDecoration(
          color: HireIQTheme.surfaceWhite,
          border: const Border(
              top: BorderSide(color: HireIQTheme.borderLight)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: HireIQTheme.primaryNavy,
                  side: const BorderSide(color: HireIQTheme.primaryNavy),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg)),
                ),
                child: Text(
                  'Save Gig',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.amber,
                  foregroundColor: HireIQTheme.primaryNavy,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg)),
                ),
                child: Text(
                  'Submit Proposal',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip(this.label, this.icon);
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white.withValues(alpha: 0.7)),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.primaryNavy),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _MilestoneRow extends StatelessWidget {
  const _MilestoneRow(
      this.number, this.description, this.amount, this.duration);
  final String number;
  final String description;
  final String amount;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: HireIQTheme.background,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.primaryTeal),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              description,
              style: GoogleFonts.inter(
                  fontSize: 13, color: HireIQTheme.textPrimary),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: HireIQTheme.primaryNavy),
              ),
              Text(
                duration,
                style: GoogleFonts.inter(
                    fontSize: 11, color: HireIQTheme.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
