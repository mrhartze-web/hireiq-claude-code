import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidatePublicProfile extends ConsumerWidget {
  const CandidatePublicProfile({super.key});

  static const _skills = [
    'Flutter', 'Dart', 'Firebase', 'React Native', 'Node.js',
    'TypeScript', 'PostgreSQL', 'AWS', 'CI/CD', 'Agile'
  ];

  static const _experience = [
    _Exp(
      role: 'Senior Flutter Developer',
      company: 'TechFlow Solutions',
      duration: 'Jan 2024 – Present',
      isCurrent: true,
    ),
    _Exp(
      role: 'Mobile Engineer',
      company: 'Apex Digital',
      duration: 'Mar 2021 – Dec 2023',
      isCurrent: false,
    ),
    _Exp(
      role: 'Junior Developer',
      company: 'FinCorp SA',
      duration: 'Jun 2019 – Feb 2021',
      isCurrent: false,
    ),
  ];

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
              'Public Profile',
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
                      color: HireIQTheme.primaryTeal,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // ── Preview Banner ────────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.visibility_outlined,
                          size: 14, color: HireIQTheme.primaryTeal),
                      const SizedBox(width: 6),
                      Text(
                        'This is how employers see your profile',
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: HireIQTheme.primaryTeal),
                      ),
                    ],
                  ),
                ),

                // ── Profile Hero ──────────────────────────────────────────
                Container(
                  width: double.infinity,
                  color: HireIQTheme.primaryNavy,
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                  child: Column(
                    children: [
                      // Avatar + Score
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: CustomPaint(
                              painter: _RingPainter(
                                  score: 87, color: HireIQTheme.amber),
                            ),
                          ),
                          Container(
                            width: 76,
                            height: 76,
                            decoration: const BoxDecoration(
                              color: HireIQTheme.primaryTeal,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                'TN',
                                style: GoogleFonts.inter(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Thabo Nkosi',
                            style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: HireIQTheme.primaryTeal
                                  .withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(
                                  HireIQTheme.radiusFull),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.verified_rounded,
                                    size: 12, color: HireIQTheme.primaryTeal),
                                const SizedBox(width: 3),
                                Text(
                                  'PassportIQ',
                                  style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: HireIQTheme.primaryTeal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Senior Flutter Developer',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.75)),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on_outlined,
                              size: 13,
                              color: Color.fromRGBO(255, 255, 255, 0.5)),
                          const SizedBox(width: 3),
                          Text(
                            'Johannesburg, South Africa',
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                color:
                                    Colors.white.withValues(alpha: 0.55)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // MatchIQ score pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: HireIQTheme.amber.withValues(alpha: 0.2),
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusFull),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.auto_awesome_rounded,
                                size: 14, color: HireIQTheme.amber),
                            const SizedBox(width: 6),
                            Text(
                              'MatchIQ Score: 87',
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: HireIQTheme.amber),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Body ──────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Skills
                      _SectionHeader('Skills'),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _skills.map((s) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 7),
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
                              s,
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: HireIQTheme.primaryTeal),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),

                      // Experience
                      _SectionHeader('Work Experience'),
                      const SizedBox(height: 12),
                      ..._experience.map((e) => _ExperienceItem(exp: e)),
                      const SizedBox(height: 24),

                      // References
                      _SectionHeader('References'),
                      const SizedBox(height: 12),
                      _ReferenceRow(
                          name: 'Nomsa Dlamini',
                          role: 'HR Director, FinCorp SA',
                          isVerified: true),
                      const SizedBox(height: 8),
                      _ReferenceRow(
                          name: 'Craig Botha',
                          role: 'Engineering Lead, Apex Digital',
                          isVerified: true),
                      const SizedBox(height: 24),

                      // Edit CTA
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.edit_outlined, size: 18),
                          label: Text(
                            'Edit Profile',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: HireIQTheme.primaryTeal,
                            side: const BorderSide(
                                color: HireIQTheme.primaryTeal, width: 1.5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    HireIQTheme.radiusLg)),
                          ),
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

class _Exp {
  const _Exp({
    required this.role,
    required this.company,
    required this.duration,
    required this.isCurrent,
  });

  final String role;
  final String company;
  final String duration;
  final bool isCurrent;
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.primaryNavy),
        ),
        const SizedBox(width: 8),
        Expanded(child: Container(height: 1, color: HireIQTheme.borderLight)),
      ],
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  const _ExperienceItem({required this.exp});
  final _Exp exp;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: exp.isCurrent
                    ? HireIQTheme.primaryTeal
                    : HireIQTheme.borderMedium,
                shape: BoxShape.circle,
              ),
            ),
            Container(
                width: 2, height: 44, color: HireIQTheme.borderLight),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exp.role,
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 2),
                Text(
                  '${exp.company} • ${exp.duration}',
                  style: GoogleFonts.inter(
                      fontSize: 12, color: HireIQTheme.textMuted),
                ),
              ],
            ),
          ),
        ),
        if (exp.isCurrent)
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: HireIQTheme.success.withValues(alpha: 0.1),
              borderRadius:
                  BorderRadius.circular(HireIQTheme.radiusFull),
            ),
            child: Text(
              'Current',
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.success),
            ),
          ),
      ],
    );
  }
}

class _ReferenceRow extends StatelessWidget {
  const _ReferenceRow(
      {required this.name, required this.role, required this.isVerified});
  final String name;
  final String role;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
            child: Text(
              name[0],
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.primaryTeal),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.primaryNavy),
                ),
                Text(
                  role,
                  style: GoogleFonts.inter(
                      fontSize: 12, color: HireIQTheme.textMuted),
                ),
              ],
            ),
          ),
          if (isVerified)
            const Icon(Icons.verified_rounded,
                size: 18, color: HireIQTheme.primaryTeal),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.score, required this.color});
  final int score;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 8) / 2;

    canvas.drawCircle(
        center,
        radius,
        Paint()
          ..color = HireIQTheme.borderLight
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * (score / 100),
        false,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
