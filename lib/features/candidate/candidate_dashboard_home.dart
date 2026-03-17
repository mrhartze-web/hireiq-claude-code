import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/job_card.dart';
import '../../shared/navigation/role_navigation_bar.dart';
import '../../providers/auth_provider.dart';

class CandidateDashboardHome extends ConsumerStatefulWidget {
  const CandidateDashboardHome({super.key});

  @override
  ConsumerState<CandidateDashboardHome> createState() =>
      _CandidateDashboardHomeState();
}

class _CandidateDashboardHomeState
    extends ConsumerState<CandidateDashboardHome>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scoreController;
  late final Animation<double> _scoreAnim;

  static const int _matchScore = 78;

  @override
  void initState() {
    super.initState();
    _scoreController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _scoreAnim = CurvedAnimation(
      parent: _scoreController,
      curve: Curves.easeOutCubic,
    );
    _scoreController.forward();
  }

  @override
  void dispose() {
    _scoreController.dispose();
    super.dispose();
  }

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  Future<void> _onRefresh() async {
    _scoreController.reset();
    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) _scoreController.forward();
  }

  List<Widget> _buildJobCards(BuildContext context) {
    const jobs = [
      (
        title: 'Senior Flutter Developer',
        company: 'Apex Digital',
        location: 'Remote',
        salary: 'R45k – R60k / month',
        match: '94',
      ),
      (
        title: 'Mobile Engineer (iOS/Android)',
        company: 'TechWave Solutions',
        location: 'Cape Town',
        salary: 'R35k – R50k / month',
        match: '87',
      ),
      (
        title: 'React Native Developer',
        company: 'BuildFast Inc.',
        location: 'Johannesburg · Hybrid',
        salary: 'R30k – R45k / month',
        match: '81',
      ),
    ];

    return jobs
        .map(
          (j) => JobCard(
            title: j.title,
            company: j.company,
            location: j.location,
            salary: j.salary,
            matchScore: j.match,
            onTap: () => context.push('/candidate/jobs'),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final firstName =
        authState.value?.displayName?.split(' ').first ?? 'there';

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      bottomNavigationBar: const RoleNavigationBar(role: UserRole.candidate),
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: HireIQTheme.primaryTeal,
          backgroundColor: HireIQTheme.surfaceWhite,
          onRefresh: _onRefresh,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              // ── Top bar ──────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            HireIQTheme.primaryNavy.withValues(alpha: 0.08),
                        child: Text(
                          firstName.isNotEmpty
                              ? firstName[0].toUpperCase()
                              : 'H',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryNavy,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$_greeting, $firstName',
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: HireIQTheme.primaryNavy,
                                letterSpacing: -0.3,
                              ),
                            ),
                            Text(
                              'Here is your job match summary',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: HireIQTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _IconBadgeButton(
                        icon: Icons.notifications_outlined,
                        badgeCount: 3,
                        onTap: () =>
                            context.push('/candidate/notifications'),
                      ),
                    ],
                  ),
                ),
              ),

              // ── MatchIQ score ring ───────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                  child: _MatchIQCard(
                    scoreAnim: _scoreAnim,
                    score: _matchScore,
                    onExplain: () =>
                        context.push('/candidate/matchiq-explanation'),
                  ),
                ),
              ),

              // ── Quick stats ──────────────────────────────────────────────
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: _StatCardsRow(),
                ),
              ),

              // ── Recommended for you ──────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                  child: _SectionHeader(
                    title: 'Recommended for you',
                    actionLabel: 'See all',
                    onAction: () => context.go('/candidate/jobs'),
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    _buildJobCards(context),
                  ),
                ),
              ),

              // ── Complete your profile ────────────────────────────────────
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: _SectionHeader(
                    title: 'Complete your profile',
                    actionLabel: null,
                    onAction: null,
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
                  child: _ProfileCompletionCard(
                    onComplete: () => context.go('/candidate/profile'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── MatchIQ score card ────────────────────────────────────────────────────────

class _MatchIQCard extends StatelessWidget {
  const _MatchIQCard({
    required this.scoreAnim,
    required this.score,
    required this.onExplain,
  });

  final Animation<double> scoreAnim;
  final int score;
  final VoidCallback onExplain;

  Color get _ringColor {
    if (score >= 80) return HireIQTheme.success;
    if (score >= 60) return HireIQTheme.primaryTeal;
    return HireIQTheme.warning;
  }

  String get _fitLabel {
    if (score >= 80) return 'Excellent Fit';
    if (score >= 60) return 'Good Match';
    return 'Developing';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: scoreAnim,
            builder: (_, __) {
              final displayScore = (score * scoreAnim.value).round();
              return SizedBox(
                width: 140,
                height: 140,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Track ring
                    const SizedBox.expand(
                      child: CircularProgressIndicator(
                        value: 1.0,
                        strokeWidth: 10,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          HireIQTheme.borderLight,
                        ),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    // Progress ring
                    SizedBox.expand(
                      child: CircularProgressIndicator(
                        value: (score / 100) * scoreAnim.value,
                        strokeWidth: 10,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(_ringColor),
                        strokeCap: StrokeCap.round,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    // Score text
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$displayScore',
                          style: GoogleFonts.inter(
                            fontSize: 38,
                            fontWeight: FontWeight.w800,
                            color: HireIQTheme.primaryNavy,
                            letterSpacing: -1.5,
                            height: 1,
                          ),
                        ),
                        Text(
                          '/ 100',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: HireIQTheme.textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            'MatchIQ Score',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: HireIQTheme.textMuted,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _fitLabel,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _ringColor,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onExplain,
            child: Text(
              'What is this?',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: HireIQTheme.primaryTeal,
                decoration: TextDecoration.underline,
                decorationColor: HireIQTheme.primaryTeal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stat cards row ────────────────────────────────────────────────────────────

class _StatCardsRow extends StatelessWidget {
  const _StatCardsRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.send_outlined,
            value: '12',
            label: 'Applications\nSent',
            iconColor: HireIQTheme.primaryNavy,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.event_outlined,
            value: '3',
            label: 'Interviews\nScheduled',
            iconColor: HireIQTheme.primaryTeal,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.visibility_outlined,
            value: '47',
            label: 'Profile\nViews',
            iconColor: HireIQTheme.amber,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusSm),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: HireIQTheme.primaryNavy,
              letterSpacing: -0.5,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: HireIQTheme.textMuted,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Section header ────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.primaryNavy,
              letterSpacing: -0.3,
            ),
          ),
        ),
        if (actionLabel != null && onAction != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionLabel!,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: HireIQTheme.primaryTeal,
              ),
            ),
          ),
      ],
    );
  }
}

// ── Profile completion card ───────────────────────────────────────────────────

class _ProfileCompletionCard extends StatelessWidget {
  const _ProfileCompletionCard({required this.onComplete});

  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '60% complete',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Add more details to attract employers',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: HireIQTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: onComplete,
                style: TextButton.styleFrom(
                  backgroundColor: HireIQTheme.primaryTeal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Complete now',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius:
                BorderRadius.circular(HireIQTheme.radiusFull),
            child: const LinearProgressIndicator(
              value: 0.60,
              minHeight: 8,
              backgroundColor: HireIQTheme.borderLight,
              valueColor: AlwaysStoppedAnimation<Color>(
                HireIQTheme.primaryTeal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Notification icon with badge ──────────────────────────────────────────────

class _IconBadgeButton extends StatelessWidget {
  const _IconBadgeButton({
    required this.icon,
    required this.badgeCount,
    required this.onTap,
  });

  final IconData icon;
  final int badgeCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: HireIQTheme.surfaceWhite,
              shape: BoxShape.circle,
              border: Border.all(color: HireIQTheme.borderLight),
            ),
            child: Icon(icon, size: 20, color: HireIQTheme.primaryNavy),
          ),
          if (badgeCount > 0)
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: HireIQTheme.error,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    badgeCount > 9 ? '9+' : '$badgeCount',
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
