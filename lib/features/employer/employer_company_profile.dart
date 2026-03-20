import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerCompanyProfile extends ConsumerStatefulWidget {
  const EmployerCompanyProfile({super.key});

  @override
  ConsumerState<EmployerCompanyProfile> createState() =>
      _EmployerCompanyProfileState();
}

class _EmployerCompanyProfileState
    extends ConsumerState<EmployerCompanyProfile> {
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
              'Company Profile',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Edit',
                  style: GoogleFonts.inter(
                      color: HireIQTheme.amber, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // ── Header ────────────────────────────────────────────────
                Container(
                  width: double.infinity,
                  color: HireIQTheme.primaryNavy,
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: HireIQTheme.amber,
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusMd),
                        ),
                        child: Center(
                          child: Text(
                            'TF',
                            style: GoogleFonts.inter(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: HireIQTheme.primaryNavy),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'TechFlow Solutions',
                        style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Technology • Cape Town, South Africa',
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.65)),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _HeaderStat('12', 'Active\nJobs'),
                          Container(
                              width: 1,
                              height: 32,
                              color: Colors.white.withValues(alpha: 0.2),
                              margin: const EdgeInsets.symmetric(horizontal: 20)),
                          _HeaderStat('347', 'Total\nApplicants'),
                          Container(
                              width: 1,
                              height: 32,
                              color: Colors.white.withValues(alpha: 0.2),
                              margin: const EdgeInsets.symmetric(horizontal: 20)),
                          _HeaderStat('4.8', 'Employer\nRating'),
                        ],
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
                      // About
                      _SectionTitle('About Us'),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: HireIQTheme.surfaceWhite,
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusLg),
                          border: Border.all(color: HireIQTheme.borderLight),
                          boxShadow: [
                            BoxShadow(
                              color: HireIQTheme.primaryNavy
                                  .withValues(alpha: 0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          'TechFlow Solutions is a Cape Town-based software engineering company building enterprise-grade digital products for some of Africa\'s largest brands. With a team of 120+ engineers, designers, and data scientists, we partner with leading companies across fintech, logistics, and healthcare to drive digital transformation.',
                          style: GoogleFonts.inter(
                              fontSize: 13,
                              color: HireIQTheme.textMuted,
                              height: 1.65),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Culture
                      _SectionTitle('Culture & Benefits'),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          'Flexible Hours',
                          'Remote-Friendly',
                          'Learning Budget',
                          'Medical Aid',
                          'Equity Options',
                          'Team Retreats',
                        ].map((b) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: HireIQTheme.primaryTeal
                                  .withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(
                                  HireIQTheme.radiusFull),
                              border: Border.all(
                                  color: HireIQTheme.primaryTeal
                                      .withValues(alpha: 0.25)),
                            ),
                            child: Text(
                              b,
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: HireIQTheme.primaryTeal),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),

                      // Company Details
                      _SectionTitle('Company Details'),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: HireIQTheme.surfaceWhite,
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusLg),
                          border: Border.all(color: HireIQTheme.borderLight),
                          boxShadow: [
                            BoxShadow(
                              color: HireIQTheme.primaryNavy
                                  .withValues(alpha: 0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _DetailRow(
                                icon: Icons.business_outlined,
                                label: 'Industry',
                                value: 'Technology & Software'),
                            const Divider(
                                height: 20, color: HireIQTheme.borderLight),
                            _DetailRow(
                                icon: Icons.people_outline_rounded,
                                label: 'Company Size',
                                value: '100 – 200 employees'),
                            const Divider(
                                height: 20, color: HireIQTheme.borderLight),
                            _DetailRow(
                                icon: Icons.calendar_today_outlined,
                                label: 'Founded',
                                value: '2012'),
                            const Divider(
                                height: 20, color: HireIQTheme.borderLight),
                            _DetailRow(
                                icon: Icons.location_on_outlined,
                                label: 'Headquarters',
                                value: 'Cape Town, South Africa'),
                            const Divider(
                                height: 20, color: HireIQTheme.borderLight),
                            _DetailRow(
                                icon: Icons.language_outlined,
                                label: 'Website',
                                value: 'techflowsolutions.co.za'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // BEE Level
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: HireIQTheme.amber.withValues(alpha: 0.08),
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusLg),
                          border: Border.all(
                              color: HireIQTheme.amber.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.verified_rounded,
                                color: HireIQTheme.amber, size: 22),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Level 2 B-BBEE Contributor',
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: HireIQTheme.primaryNavy),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'ShieldIQ verified on 01 Feb 2026',
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: HireIQTheme.textMuted),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderStat extends StatelessWidget {
  const _HeaderStat(this.value, this.label);
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.5),
              height: 1.3),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: HireIQTheme.primaryNavy),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: HireIQTheme.textMuted),
        const SizedBox(width: 10),
        Text(
          label,
          style: GoogleFonts.inter(
              fontSize: 13, color: HireIQTheme.textMuted),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: HireIQTheme.primaryNavy),
        ),
      ],
    );
  }
}
