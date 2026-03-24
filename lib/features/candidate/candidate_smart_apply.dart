import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/application_model.dart';
import '../../models/job_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/candidate_provider.dart';
import '../../providers/job_provider.dart';
import '../../shared/theme.dart';
import '../mobile_screens.dart';

class CandidateSmartApply extends ConsumerStatefulWidget {
  const CandidateSmartApply({super.key});

  @override
  ConsumerState<CandidateSmartApply> createState() =>
      _CandidateSmartApplyState();
}

class _CandidateSmartApplyState extends ConsumerState<CandidateSmartApply> {
  bool _isLoading = false;

  Future<void> _apply(
    BuildContext context,
    String jobId,
    JobModel job,
    String uid,
    double matchIQScore,
  ) async {
    setState(() => _isLoading = true);
    try {
      final fs = ref.read(firestoreServiceProvider);

      final alreadyApplied = await fs.checkAlreadyApplied(uid, jobId);
      if (alreadyApplied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You have already applied for this job'),
            ),
          );
        }
        return;
      }

      final now = DateTime.now();
      final application = ApplicationModel(
        applicationId: '',
        jobId: jobId,
        candidateUid: uid,
        employerUid: job.employerUid,
        status: 'applied',
        appliedAt: now,
        updatedAt: now,
        matchIQScore: matchIQScore,
      );

      await fs.submitApplication(application);
      await fs.incrementApplicationsCount(jobId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Application submitted successfully'),
            backgroundColor: HireIQTheme.primaryTeal,
          ),
        );
        context.go(MobileRoutes.candidateApplications);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit application: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobId = GoRouterState.of(context).extra as String? ?? '';
    final uid = ref.watch(authStateProvider).value?.uid ?? '';
    final jobAsync = ref.watch(jobDetailProvider(jobId));
    final candidateAsync = ref.watch(candidateProfileProvider(uid));

    final matchIQScore =
        candidateAsync.value?.matchIQScore.toDouble() ?? 75.0;
    final scoreInt = matchIQScore.round();

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ───────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Smart Apply',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: HireIQTheme.backgroundLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close_rounded,
                          size: 18, color: HireIQTheme.textMuted),
                    ),
                  ),
                ],
              ),
            ),

            // ── Scrollable body ───────────────────────────────────────────
            Expanded(
              child: jobAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(
                      color: HireIQTheme.primaryTeal),
                ),
                error: (e, _) => Center(
                  child: Text('Error loading job: $e',
                      style: GoogleFonts.inter(
                          color: HireIQTheme.textMuted)),
                ),
                data: (job) {
                  if (job == null) {
                    return Center(
                      child: Text('Job not found.',
                          style: GoogleFonts.inter(
                              color: HireIQTheme.textMuted)),
                    );
                  }
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
                    child: Column(
                      children: [
                        _ScoreRing(score: scoreInt),
                        const SizedBox(height: 20),
                        Text(
                          job.title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryNavy,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _jobSubtitle(job),
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: HireIQTheme.textMuted,
                          ),
                        ),
                        if (job.salaryMin > 0 || job.salaryMax > 0) ...[
                          const SizedBox(height: 8),
                          Text(
                            'R${_fmt(job.salaryMin)} – R${_fmt(job.salaryMax)}',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: HireIQTheme.primaryTeal,
                            ),
                          ),
                        ],
                        const SizedBox(height: 32),
                        const _IncludedCard(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ── Fixed apply button ─────────────────────────────────────────
            jobAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (job) {
                if (job == null) return const SizedBox.shrink();
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    12,
                    20,
                    12 + MediaQuery.of(context).padding.bottom,
                  ),
                  child: GestureDetector(
                    onTap: _isLoading
                        ? null
                        : () => _apply(
                              context,
                              job.jobId,
                              job,
                              uid,
                              matchIQScore,
                            ),
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: _isLoading
                              ? [HireIQTheme.textMuted, HireIQTheme.textMuted]
                              : const [
                                  HireIQTheme.primaryTeal,
                                  Color(0xFF0A7A70)
                                ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd),
                        boxShadow: _isLoading
                            ? []
                            : [
                                BoxShadow(
                                  color: HireIQTheme.primaryTeal
                                      .withValues(alpha: 0.35),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                      ),
                      child: Center(
                        child: _isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white),
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.bolt_rounded,
                                      color: Colors.white, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    'One-Tap Apply',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _jobSubtitle(JobModel job) {
    final parts = <String>[];
    if (job.company.isNotEmpty) parts.add(job.company);
    if (job.location.isNotEmpty) parts.add(job.location);
    return parts.join(' · ');
  }

  String _fmt(int amount) {
    if (amount >= 1000) return '${amount ~/ 1000}k';
    return amount.toString();
  }
}

// ── Score ring ────────────────────────────────────────────────────────────────

class _ScoreRing extends StatelessWidget {
  const _ScoreRing({required this.score});

  final int score;

  String get _label {
    if (score >= 85) return 'Excellent MatchIQ Fit';
    if (score >= 70) return 'Strong MatchIQ Fit';
    if (score >= 50) return 'Good MatchIQ Fit';
    return 'Low MatchIQ Fit';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 130,
          height: 130,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox.expand(
                child: CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: 10,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      HireIQTheme.borderLight),
                  strokeCap: StrokeCap.round,
                ),
              ),
              SizedBox.expand(
                child: CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 10,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      HireIQTheme.primaryTeal),
                  strokeCap: StrokeCap.round,
                  backgroundColor: Colors.transparent,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$score',
                    style: GoogleFonts.inter(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: HireIQTheme.primaryNavy,
                      letterSpacing: -1.5,
                      height: 1,
                    ),
                  ),
                  Text(
                    '/ 100',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: HireIQTheme.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.auto_awesome,
                  size: 13, color: HireIQTheme.primaryTeal),
              const SizedBox(width: 5),
              Text(
                _label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.primaryTeal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Included card ─────────────────────────────────────────────────────────────

class _IncludedCard extends StatelessWidget {
  const _IncludedCard();

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
          Text(
            "What's included in your application",
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.primaryNavy,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 16),
          const _IncludedRow(
            icon: Icons.verified_user_outlined,
            title: 'Verified PassportIQ Details',
            subtitle: 'Identity & credentials confirmed',
          ),
          const _IncludedDivider(),
          const _IncludedRow(
            icon: Icons.auto_awesome,
            title: 'WildcardIQ Assessment Score',
            subtitle: 'AI-scored capability report',
          ),
          const _IncludedDivider(),
          const _IncludedRow(
            icon: Icons.videocam_outlined,
            title: 'Video Pitch',
            subtitle: '60-second personal introduction',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _IncludedRow extends StatelessWidget {
  const _IncludedRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusSm),
            ),
            child: Icon(icon, size: 18, color: HireIQTheme.primaryTeal),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: HireIQTheme.textPrimary)),
                Text(subtitle,
                    style: GoogleFonts.inter(
                        fontSize: 11, color: HireIQTheme.textMuted)),
              ],
            ),
          ),
          const Icon(Icons.check_circle_rounded,
              color: HireIQTheme.primaryTeal, size: 18),
        ],
      ),
    );
  }
}

class _IncludedDivider extends StatelessWidget {
  const _IncludedDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(height: 1, color: HireIQTheme.borderLight),
    );
  }
}
