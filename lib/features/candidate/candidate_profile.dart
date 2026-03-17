import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../providers/auth_provider.dart';
import '../../providers/candidate_provider.dart';
import '../../shared/components/skeleton_loader.dart';
import '../../shared/components/error_state.dart';

class CandidateProfile extends ConsumerWidget {
  const CandidateProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () => const Scaffold(
        backgroundColor: HireIQTheme.background,
        body: Center(child: SkeletonLoader()),
      ),
      error: (e, _) => const Scaffold(
        backgroundColor: HireIQTheme.background,
        body: ErrorState(message: 'Could not load profile'),
      ),
      data: (user) {
        if (user == null) {
          return Scaffold(
            backgroundColor: HireIQTheme.background,
            body: Center(
              child: Text(
                'Not signed in',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: HireIQTheme.textMuted,
                ),
              ),
            ),
          );
        }

        final initials = (user.displayName?.isNotEmpty ?? false)
            ? user.displayName![0].toUpperCase()
            : 'C';
        final displayName = user.displayName ?? 'Candidate';

        final profileAsync = ref.watch(candidateProfileProvider(user.uid));
        return profileAsync.when(
          loading: () => const Scaffold(
            backgroundColor: HireIQTheme.background,
            body: Center(child: SkeletonLoader()),
          ),
          error: (e, _) => const Scaffold(
            backgroundColor: HireIQTheme.background,
            body: ErrorState(message: 'Could not load profile'),
          ),
          data: (profile) => Scaffold(
            backgroundColor: HireIQTheme.background,
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // ── Gradient hero header ─────────────────────────────────
                SliverAppBar(
                  expandedHeight: 230,
                  pinned: true,
                  backgroundColor: HireIQTheme.primaryNavy,
                  automaticallyImplyLeading: false,
                  title: Text(
                    'My Profile',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  centerTitle: true,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            HireIQTheme.primaryNavy,
                            Color(0xFF243659),
                          ],
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 24),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: HireIQTheme.primaryTeal,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: HireIQTheme.primaryTeal
                                        .withValues(alpha: 0.35),
                                    blurRadius: 16,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 42,
                                backgroundColor: HireIQTheme.primaryNavy,
                                child: Text(
                                  initials,
                                  style: GoogleFonts.inter(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              displayName,
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            if (profile != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                profile.headline,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: Colors.white.withValues(alpha: 0.65),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // ── Body ────────────────────────────────────────────────
                if (profile != null)
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // MatchIQ score badge
                        _MatchIQBadge(
                          score: profile.matchIQScore.toStringAsFixed(0),
                        ),
                        const SizedBox(height: 20),

                        // Info card
                        _InfoCard(children: [
                          _InfoRow(
                            icon: Icons.location_on_outlined,
                            label: 'Location',
                            value: profile.location,
                          ),
                          _InfoRow(
                            icon: Icons.work_history_outlined,
                            label: 'Experience',
                            value: '${profile.yearsExperience} years',
                          ),
                          _InfoRow(
                            icon: Icons.schedule_outlined,
                            label: 'Availability',
                            value: profile.availabilityStatus,
                            isLast: true,
                          ),
                        ]),

                        const SizedBox(height: 24),

                        // Skills heading
                        Text(
                          'Skills',
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryNavy,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Skill chips
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: profile.skills
                              .map<Widget>(
                                (skill) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: HireIQTheme.primaryTeal
                                        .withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(
                                      HireIQTheme.radiusFull,
                                    ),
                                    border: Border.all(
                                      color: HireIQTheme.primaryTeal
                                          .withValues(alpha: 0.2),
                                    ),
                                  ),
                                  child: Text(
                                    skill.toString(),
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: HireIQTheme.primaryTeal,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ]),
                    ),
                  )
                else
                  const SliverFillRemaining(
                    child: Center(
                      child: ErrorState(message: 'No profile data yet'),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── MatchIQ badge ─────────────────────────────────────────────────────────────

class _MatchIQBadge extends StatelessWidget {
  const _MatchIQBadge({required this.score});

  final String score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            HireIQTheme.primaryTeal.withValues(alpha: 0.08),
            HireIQTheme.primaryTeal.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
          color: HireIQTheme.primaryTeal.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: HireIQTheme.primaryTeal,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MatchIQ Score',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: HireIQTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$score% match',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.primaryTeal,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Good Match',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: HireIQTheme.primaryTeal,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Info card ─────────────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(children: children),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            children: [
              Icon(icon, size: 16, color: HireIQTheme.primaryTeal),
              const SizedBox(width: 12),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: HireIQTheme.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: HireIQTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(
            height: 1,
            indent: 18,
            endIndent: 18,
            color: HireIQTheme.borderLight,
          ),
      ],
    );
  }
}
