import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerWildcardIq extends ConsumerStatefulWidget {
  const EmployerWildcardIq({super.key});

  @override
  ConsumerState<EmployerWildcardIq> createState() => _EmployerWildcardIqState();
}

class _EmployerWildcardIqState extends ConsumerState<EmployerWildcardIq> {
  bool _discovered = false;

  static const _wildcards = [
    _Wildcard(
      name: 'Lungelo Dube',
      currentRole: 'Marketing Manager',
      hiddenStrength: 'Built internal analytics tools for 3 years',
      matchScore: 88,
      reason:
          'Lungelo\'s unreported technical background makes them an exceptional Flutter dev candidate.',
    ),
    _Wildcard(
      name: 'Priya Naicker',
      currentRole: 'Civil Engineer',
      hiddenStrength: 'Self-taught iOS and Flutter developer, 2 published apps',
      matchScore: 84,
      reason:
          'Non-traditional background with proven mobile shipping experience — a rare WildcardIQ catch.',
    ),
  ];

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
              'WildcardIQ',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Hero Explainer ────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7C3AED), Color(0xFF9D5CF6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.casino_rounded,
                              color: Colors.white, size: 22),
                          const SizedBox(width: 10),
                          Text(
                            'WildcardIQ Candidates',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Candidates with non-traditional backgrounds hiding exceptional talent. Our AI identifies hidden strengths that standard CVs miss. Average hire success rate: 91%.',
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.8),
                            height: 1.55),
                      ),
                      const SizedBox(height: 16),
                      if (!_discovered)
                        ElevatedButton.icon(
                          onPressed: () => setState(() => _discovered = true),
                          icon: const Icon(Icons.waving_hand_rounded, size: 16),
                          label: Text(
                            'Discover Wildcards for My Role',
                            style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF7C3AED),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    HireIQTheme.radiusMd)),
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(
                                HireIQTheme.radiusFull),
                          ),
                          child: Text(
                            '✓ Showing wildcards for Senior Flutter Developer',
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                if (_discovered) ...[
                  Text(
                    'Your Wildcard Matches',
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 12),
                  ..._wildcards.map((w) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: _WildcardCard(wildcard: w),
                      )),
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Wildcard {
  const _Wildcard({
    required this.name,
    required this.currentRole,
    required this.hiddenStrength,
    required this.matchScore,
    required this.reason,
  });

  final String name;
  final String currentRole;
  final String hiddenStrength;
  final int matchScore;
  final String reason;
}

class _WildcardCard extends StatelessWidget {
  const _WildcardCard({required this.wildcard});
  final _Wildcard wildcard;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor:
                    const Color(0xFF7C3AED).withValues(alpha: 0.1),
                child: Text(
                  wildcard.name
                      .split(' ')
                      .map((w) => w[0])
                      .take(2)
                      .join(),
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF7C3AED)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wildcard.name,
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: HireIQTheme.primaryNavy),
                    ),
                    Text(
                      'Currently: ${wildcard.currentRole}',
                      style: GoogleFonts.inter(
                          fontSize: 12, color: HireIQTheme.textMuted),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C3AED).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  '${wildcard.matchScore}%',
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF7C3AED)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF7C3AED).withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.auto_awesome_rounded,
                        size: 13, color: Color(0xFF7C3AED)),
                    const SizedBox(width: 5),
                    Text(
                      'Hidden Strength',
                      style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF7C3AED)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  wildcard.hiddenStrength,
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.textPrimary),
                ),
                const SizedBox(height: 6),
                Text(
                  wildcard.reason,
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: HireIQTheme.textMuted,
                      height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF7C3AED),
                    side: const BorderSide(color: Color(0xFF7C3AED)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)),
                  ),
                  child: Text('View Profile',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 12)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C3AED),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)),
                  ),
                  child: Text('Contact',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
