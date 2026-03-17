import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateCompleteProfile extends StatelessWidget {
  const CandidateCompleteProfile({super.key});

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
              'Complete Profile',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Progress banner ───────────────────────────────────
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Profile Completion',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '75%',
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: HireIQTheme.primaryTeal,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              HireIQTheme.radiusFull),
                          child: const LinearProgressIndicator(
                            value: 0.75,
                            minHeight: 8,
                            backgroundColor: Color(0x33FFFFFF),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              HireIQTheme.primaryTeal,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Complete the remaining steps to access MatchIQ and start applying.',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.65),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Remaining tasks ───────────────────────────────────
                  Text(
                    'Remaining Tasks',
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 14),

                  _TaskTile(
                    context: context,
                    title: 'Verify PassportIQ',
                    subtitle: 'Upload your ID and get verified',
                    isCompleted: false,
                    route: '/passport-iq',
                  ),
                  _TaskTile(
                    context: context,
                    title: 'Add References',
                    subtitle: 'Build trust with employers',
                    isCompleted: false,
                    route: '/candidate/references',
                  ),
                  _TaskTile(
                    context: context,
                    title: 'Record Video Pitch',
                    subtitle: 'Stand out from the crowd',
                    isCompleted: false,
                    route: '/candidate/video-pitch',
                  ),

                  const SizedBox(height: 28),

                  // ── Completed ─────────────────────────────────────────
                  Text(
                    'Completed',
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.textMuted,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 14),

                  _TaskTile(
                    context: context,
                    title: 'Basic Details',
                    subtitle: 'Name, contact, location',
                    isCompleted: true,
                    route: '',
                  ),
                  _TaskTile(
                    context: context,
                    title: 'Experience & Skills',
                    subtitle: 'CV parsed successfully',
                    isCompleted: true,
                    route: '',
                  ),
                  _TaskTile(
                    context: context,
                    title: 'Career Goals',
                    subtitle: 'Salary and role expectations',
                    isCompleted: true,
                    route: '',
                    isLast: true,
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

// ── Task tile ──────────────────────────────────────────────────────────────────

class _TaskTile extends StatelessWidget {
  const _TaskTile({
    required this.context,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.route,
    this.isLast = false,
  });

  final BuildContext context;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final String route;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isCompleted || route.isEmpty
          ? null
          : () => context.push(route),
      child: Container(
        margin: EdgeInsets.only(bottom: isLast ? 0 : 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: HireIQTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
          border: Border.all(
            color: isCompleted
                ? HireIQTheme.success.withValues(alpha: 0.3)
                : HireIQTheme.borderLight,
          ),
          boxShadow: [
            BoxShadow(
              color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isCompleted
                    ? HireIQTheme.success.withValues(alpha: 0.1)
                    : HireIQTheme.backgroundLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCompleted
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: isCompleted
                    ? HireIQTheme.success
                    : HireIQTheme.textLight,
                size: 20,
              ),
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
                      fontWeight: FontWeight.w600,
                      color: isCompleted
                          ? HireIQTheme.textMuted
                          : HireIQTheme.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: HireIQTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (!isCompleted)
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
