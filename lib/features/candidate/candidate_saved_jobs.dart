import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:hireiq/shared/theme.dart';
import '../../providers/auth_provider.dart';
import '../../providers/job_provider.dart';
import '../../services/firebase/firestore_service.dart';
import '../../shared/components/skeleton_loader.dart';
import '../../shared/components/empty_state.dart';
import '../mobile_screens.dart';

class CandidateSavedJobs extends ConsumerWidget {
  const CandidateSavedJobs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(authStateProvider).value?.uid ?? '';
    final savedIdsAsync = ref.watch(savedJobIdsProvider(uid));

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Saved Jobs',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: savedIdsAsync.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(20),
          child: SkeletonLoader(itemCount: 3),
        ),
        error: (_, __) =>
            const Center(child: Text('Could not load saved jobs')),
        data: (jobIds) {
          if (jobIds.isEmpty) {
            return EmptyState(
              icon: Icons.bookmark_border_rounded,
              heading: 'No saved jobs',
              body: 'Bookmark jobs from the feed to revisit them later',
              ctaLabel: 'Browse Jobs',
              onCtaPressed: () => context.go('/candidate/jobs'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: jobIds.length,
            itemBuilder: (context, index) {
              final jobId = jobIds[index];
              return _SavedJobItem(jobId: jobId, uid: uid);
            },
          );
        },
      ),
    );
  }
}

class _SavedJobItem extends ConsumerWidget {
  const _SavedJobItem({required this.jobId, required this.uid});

  final String jobId;
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(jobDetailProvider(jobId));

    return jobAsync.when(
      loading: () => Container(
        margin: const EdgeInsets.only(bottom: 12),
        height: 100,
        decoration: BoxDecoration(
          color: HireIQTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
          border: Border.all(color: HireIQTheme.borderLight),
        ),
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
      error: (_, __) => const SizedBox.shrink(),
      data: (job) {
        if (job == null) return const SizedBox.shrink();
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
            onTap: () => context.push(
              MobileRoutes.candidateJobDetail.replaceFirst(':id', job.jobId),
            ),
            borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          job.title,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryNavy,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${job.company} · ${job.location}',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: HireIQTheme.textMuted,
                          ),
                        ),
                        if (job.skills.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: job.skills.take(3).map((tag) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: HireIQTheme.backgroundLight,
                                  borderRadius: BorderRadius.circular(
                                      HireIQTheme.radiusFull),
                                ),
                                child: Text(
                                  tag,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: HireIQTheme.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.bookmark_remove_rounded,
                      color: HireIQTheme.error,
                      size: 22,
                    ),
                    onPressed: () async {
                      await FirestoreService().unsaveJob(uid, jobId);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
