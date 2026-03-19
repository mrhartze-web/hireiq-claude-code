import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/theme.dart';
import '../../providers/auth_provider.dart';
import '../../providers/job_provider.dart';
import '../../providers/application_provider.dart';
import '../../models/application_model.dart';
import '../../shared/components/skeleton_loader.dart';

class EmployerCandidatePipeline extends ConsumerWidget {
  const EmployerCandidatePipeline({super.key});

  static const _columns = [
    'applied',
    'reviewing',
    'shortlisted',
    'interview',
    'offer',
  ];

  static const _columnLabels = {
    'applied': 'Applied',
    'reviewing': 'Reviewing',
    'shortlisted': 'Shortlisted',
    'interview': 'Interviewing',
    'offer': 'Offered',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(authStateProvider).value?.uid ?? '';
    final jobsAsync = ref.watch(employerJobsProvider(uid));

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Candidate Pipeline',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: jobsAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(20),
                child: SkeletonLoader(itemCount: 3),
              ),
              error: (_, __) => const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Text('Could not load pipeline'),
                ),
              ),
              data: (jobs) {
                // Collect all applications across all jobs
                final Map<String, List<ApplicationModel>> columnMap = {
                  for (final col in _columns) col: [],
                };

                for (final job in jobs) {
                  final appsAsync =
                      ref.watch(jobApplicationsProvider(job.jobId));
                  final apps = appsAsync.valueOrNull ?? [];
                  for (final app in apps) {
                    final col = app.status.toLowerCase();
                    if (columnMap.containsKey(col)) {
                      columnMap[col]!.add(app);
                    } else {
                      columnMap['applied']!.add(app);
                    }
                  }
                }

                return SizedBox(
                  height: MediaQuery.of(context).size.height - 120,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _columns.map((col) {
                        final apps = columnMap[col]!;
                        return _PipelineColumn(
                          title: _columnLabels[col]!,
                          applications: apps,
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PipelineColumn extends StatelessWidget {
  const _PipelineColumn({
    required this.title,
    required this.applications,
  });

  final String title;
  final List<ApplicationModel> applications;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: HireIQTheme.borderLight)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: HireIQTheme.primaryNavy),
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryNavy.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${applications.length}',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: HireIQTheme.primaryNavy),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: applications.isEmpty
                  ? [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            'No candidates\nin this stage',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                                color: HireIQTheme.textMuted,
                                height: 1.5),
                          ),
                        ),
                      )
                    ]
                  : applications
                      .map((app) => _KanbanCard(application: app))
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _KanbanCard extends StatelessWidget {
  const _KanbanCard({required this.application});

  final ApplicationModel application;

  @override
  Widget build(BuildContext context) {
    final shortId = application.candidateUid.length > 6
        ? application.candidateUid.substring(0, 6)
        : application.candidateUid;
    final initial = shortId.isNotEmpty ? shortId[0].toUpperCase() : 'C';
    final score = application.matchIQScore ?? 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HireIQTheme.background,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor:
                    HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                child: Text(
                  initial,
                  style: GoogleFonts.inter(
                      color: HireIQTheme.primaryTeal,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Candidate #$shortId',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.primaryNavy),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Applied ${_relativeDate(application.appliedAt)}',
            style: GoogleFonts.inter(
                color: HireIQTheme.textMuted, fontSize: 12),
          ),
          if (score > 0) ...[
            const SizedBox(height: 10),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                borderRadius:
                    BorderRadius.circular(HireIQTheme.radiusSm),
              ),
              child: Text(
                '${score.toInt()}% Match',
                style: GoogleFonts.inter(
                    color: HireIQTheme.primaryTeal,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static String _relativeDate(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays == 0) return 'today';
    if (diff.inDays == 1) return 'yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${(diff.inDays / 7).floor()}w ago';
  }
}
