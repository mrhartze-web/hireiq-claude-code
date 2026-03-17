import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../mobile_screens.dart';
import '../../providers/job_provider.dart';

class CandidateJobFeed extends ConsumerWidget {
  const CandidateJobFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Job Feed',
                            style: GoogleFonts.inter(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: HireIQTheme.primaryNavy,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            'Tailored to your profile',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: HireIQTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _FeedIconButton(
                      icon: Icons.notifications_outlined,
                      onTap: () => context.push('/notifications'),
                    ),
                    const SizedBox(width: 10),
                    _FeedIconButton(
                      icon: Icons.tune_rounded,
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              // ── MatchIQ banner ───────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: _MatchIQBanner(
                  onTap: () => context.push(MobileRoutes.candidateWildcard),
                ),
              ),

              // ── Section heading ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Recommended for You',
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: HireIQTheme.primaryNavy,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'View all',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: HireIQTheme.primaryTeal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Job list ─────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
                child: ref.watch(activeJobsProvider).when(
                  data: (jobs) {
                    if (jobs.isEmpty) {
                      return const _EmptyJobsState();
                    }
                    return Column(
                      children: jobs
                          .map(
                            (job) => _JobFeedCard(
                              title: job.title,
                              company: job.company,
                              location: job.location,
                              tags: job.skills.take(3).toList(),
                              onTap: () => context.push(
                                MobileRoutes.candidateJobDetail
                                    .replaceFirst(':id', '123'),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                  loading: () => const Center(
                    heightFactor: 5,
                    child: CircularProgressIndicator(
                      color: HireIQTheme.primaryTeal,
                      strokeWidth: 2.5,
                    ),
                  ),
                  error: (err, _) => _FeedErrorState(message: err.toString()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── MatchIQ banner ────────────────────────────────────────────────────────────

class _MatchIQBanner extends StatelessWidget {
  const _MatchIQBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [HireIQTheme.primaryNavy, Color(0xFF243659)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.28),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.2),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        color: HireIQTheme.primaryTeal,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'MatchIQ',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: HireIQTheme.primaryTeal,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Your match report\nis ready',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.3,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Updated 5 mins ago based on your profile',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                boxShadow: [
                  BoxShadow(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                'View report',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Job feed card ─────────────────────────────────────────────────────────────

class _JobFeedCard extends StatelessWidget {
  const _JobFeedCard({
    required this.title,
    required this.company,
    required this.location,
    required this.tags,
    required this.onTap,
  });

  final String title;
  final String company;
  final String location;
  final List<String> tags;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusMd),
                    ),
                    child: const Icon(
                      Icons.work_outline_rounded,
                      color: HireIQTheme.primaryTeal,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryNavy,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$company · $location',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: HireIQTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.bookmark_border_rounded,
                    color: HireIQTheme.textLight,
                    size: 20,
                  ),
                ],
              ),
              if (tags.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: tags
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: HireIQTheme.backgroundLight,
                            borderRadius: BorderRadius.circular(
                              HireIQTheme.radiusFull,
                            ),
                          ),
                          child: Text(
                            tag,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: HireIQTheme.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyJobsState extends StatelessWidget {
  const _EmptyJobsState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.work_off_outlined,
              size: 34,
              color: HireIQTheme.primaryTeal,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No jobs available yet',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: HireIQTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Check back soon — new roles are added daily',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: HireIQTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Error state ───────────────────────────────────────────────────────────────

class _FeedErrorState extends StatelessWidget {
  const _FeedErrorState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: HireIQTheme.errorLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.wifi_off_rounded,
              size: 32,
              color: HireIQTheme.error,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Could not load jobs',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: HireIQTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: HireIQTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Feed icon button ──────────────────────────────────────────────────────────

class _FeedIconButton extends StatelessWidget {
  const _FeedIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: HireIQTheme.surfaceWhite,
          shape: BoxShape.circle,
          border: Border.all(color: HireIQTheme.borderLight),
        ),
        child: Icon(icon, size: 20, color: HireIQTheme.primaryNavy),
      ),
    );
  }
}
