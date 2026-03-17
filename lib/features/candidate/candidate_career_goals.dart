import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateCareerGoals extends StatelessWidget {
  const CandidateCareerGoals({super.key});

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
              'Career Goals',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Set your goals',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: HireIQTheme.primaryNavy,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'MatchIQ uses this to find the perfect roles for you.',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: HireIQTheme.textMuted,
                    ),
                  ),

                  const SizedBox(height: 32),

                  const _GoalField(
                    label: 'Desired Role',
                    hint: 'e.g. Senior Flutter Developer',
                  ),
                  const SizedBox(height: 20),
                  const _GoalField(
                    label: 'Industry',
                    hint: 'e.g. FinTech, Healthcare',
                  ),
                  const SizedBox(height: 20),
                  const _GoalField(
                    label: 'Salary Target (ZAR / year)',
                    hint: 'e.g. 800 000',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  const _GoalField(
                    label: 'Preferred Location',
                    hint: 'e.g. Cape Town, Remote',
                  ),

                  const SizedBox(height: 40),

                  // CTA
                  GestureDetector(
                    onTap: () {
                      context.pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Career goals updated successfully!'),
                        ),
                      );
                    },
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            HireIQTheme.primaryTeal,
                            Color(0xFF0A7A70),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd),
                        boxShadow: [
                          BoxShadow(
                            color: HireIQTheme.primaryTeal
                                .withValues(alpha: 0.35),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Save Goals',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
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

// ── Goal field ─────────────────────────────────────────────────────────────────

class _GoalField extends StatelessWidget {
  const _GoalField({
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final String hint;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: HireIQTheme.primaryNavy,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: keyboardType,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: HireIQTheme.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              fontSize: 14,
              color: HireIQTheme.textLight,
            ),
            filled: true,
            fillColor: HireIQTheme.surfaceWhite,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(HireIQTheme.radiusMd),
              borderSide:
                  const BorderSide(color: HireIQTheme.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(HireIQTheme.radiusMd),
              borderSide:
                  const BorderSide(color: HireIQTheme.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(HireIQTheme.radiusMd),
              borderSide: const BorderSide(
                  color: HireIQTheme.primaryTeal, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
