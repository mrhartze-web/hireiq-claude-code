import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateInterviewPrep extends StatelessWidget {
  const CandidateInterviewPrep({super.key});

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
              'Interview Prep',
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
                    'Acing Your Interview',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: HireIQTheme.primaryNavy,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Resources and tips to help you land the role.',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: HireIQTheme.textMuted,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const _TipCard(
                    title: 'Mastering the STAR Method',
                    description:
                        'Situation, Task, Action, Result. Crucial for behavioral questions.',
                    icon: Icons.star_border_rounded,
                  ),
                  const _TipCard(
                    title: 'Technical Whiteboarding',
                    description:
                        'Practice talking through your code out loud while writing it on a whiteboard.',
                    icon: Icons.edit_note_rounded,
                  ),
                  const _TipCard(
                    title: 'Questions to Ask the Employer',
                    description:
                        'Show engagement by asking about company culture, team structure, and growth opportunities.',
                    icon: Icons.question_answer_outlined,
                    isLast: true,
                  ),

                  const SizedBox(height: 28),

                  // Video pitch callout
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: HireIQTheme.primaryTeal.withValues(alpha: 0.06),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusXl),
                      border: Border.all(
                        color: HireIQTheme.primaryTeal
                            .withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: HireIQTheme.primaryTeal
                                .withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.videocam_outlined,
                            color: HireIQTheme.primaryTeal,
                            size: 26,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Video Pitch Practice',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryNavy,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ensure your background is clean, lighting is good, and you speak clearly and confidently.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: HireIQTheme.textMuted,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  GestureDetector(
                    onTap: () => context.push('/candidate/video-pitch'),
                    child: Container(
                      height: 54,
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
                            BorderRadius.circular(HireIQTheme.radiusMd),
                        boxShadow: [
                          BoxShadow(
                            color: HireIQTheme.primaryNavy
                                .withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Practice Video Pitch',
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

// ── Tip card ───────────────────────────────────────────────────────────────────

class _TipCard extends StatelessWidget {
  const _TipCard({
    required this.title,
    required this.description,
    required this.icon,
    this.isLast = false,
  });

  final String title;
  final String description;
  final IconData icon;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: isLast ? 0 : 14),
        padding: const EdgeInsets.all(16),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: HireIQTheme.primaryNavy.withValues(alpha: 0.06),
                borderRadius:
                    BorderRadius.circular(HireIQTheme.radiusMd),
              ),
              child: Icon(icon, color: HireIQTheme.primaryNavy, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: HireIQTheme.textMuted,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: HireIQTheme.textLight,
            ),
          ],
        ),
      ),
    );
  }
}
