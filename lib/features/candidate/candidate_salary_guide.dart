import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateSalaryGuide extends StatelessWidget {
  const CandidateSalaryGuide({super.key});

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
              'Salary Guide',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.help_outline_rounded, size: 20),
                onPressed: () {},
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Market Insights',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: HireIQTheme.primaryNavy,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Average salaries based on role and experience in South Africa.',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: HireIQTheme.textMuted,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const _SalaryCard(
                    role: 'Junior Developer',
                    range: 'R250k – R400k',
                    exp: '1–3 years experience',
                  ),
                  const _SalaryCard(
                    role: 'Mid-level Developer',
                    range: 'R450k – R750k',
                    exp: '3–5 years experience',
                  ),
                  const _SalaryCard(
                    role: 'Senior Developer',
                    range: 'R800k – R1.2m',
                    exp: '5+ years experience',
                    isHighlighted: true,
                  ),
                  const _SalaryCard(
                    role: 'Tech Lead / Architect',
                    range: 'R1.1m – R1.8m',
                    exp: '8+ years experience',
                    isLast: true,
                  ),

                  const SizedBox(height: 28),

                  // Tip card
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.lightbulb_outline_rounded,
                              color: HireIQTheme.amber,
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Negotiation Tip',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Always wait for the employer to state their budget first. Use your MatchIQ score and Wildcard skills as leverage to negotiate to the higher end of the bracket.',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.65),
                            height: 1.55,
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

// ── Salary card ────────────────────────────────────────────────────────────────

class _SalaryCard extends StatelessWidget {
  const _SalaryCard({
    required this.role,
    required this.range,
    required this.exp,
    this.isHighlighted = false,
    this.isLast = false,
  });

  final String role;
  final String range;
  final String exp;
  final bool isHighlighted;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
          color: isHighlighted
              ? HireIQTheme.primaryTeal.withValues(alpha: 0.5)
              : HireIQTheme.borderLight,
          width: isHighlighted ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isHighlighted
                ? HireIQTheme.primaryTeal.withValues(alpha: 0.08)
                : HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: isHighlighted ? 16 : 10,
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
                  role,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: HireIQTheme.primaryNavy,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  exp,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: HireIQTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Text(
            range,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isHighlighted
                  ? HireIQTheme.primaryTeal
                  : HireIQTheme.primaryNavy,
            ),
          ),
        ],
      ),
    );
  }
}
