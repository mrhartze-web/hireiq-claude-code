import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../providers/job_provider.dart';
import '../../models/job_model.dart';
import '../../shared/components/skeleton_loader.dart';
import '../../shared/components/error_state.dart';
import '../../shared/components/empty_state.dart';

class EmployerMyJobs extends ConsumerWidget {
  const EmployerMyJobs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final uid = authState.value?.uid ?? '';
    final jobsAsync = ref.watch(employerJobsProvider(uid));

    return jobsAsync.when(
      loading: () => Scaffold(
        backgroundColor: HireIQTheme.background,
        appBar: AppBar(
          backgroundColor: HireIQTheme.primaryNavy,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'My Job Listings',
            style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: SkeletonLoader(itemCount: 4),
        ),
      ),
      error: (err, _) => Scaffold(
        backgroundColor: HireIQTheme.background,
        appBar: AppBar(
          backgroundColor: HireIQTheme.primaryNavy,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'My Job Listings',
            style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
        body: ErrorState(
          message: 'Could not load jobs',
          onRetry: () => ref.invalidate(employerJobsProvider(uid)),
        ),
      ),
      data: (jobs) {
        final active = jobs.where((j) => j.isActive).toList();
        final closed = jobs.where((j) => !j.isActive).toList();

        return Scaffold(
          backgroundColor: HireIQTheme.background,
          body: DefaultTabController(
            length: 2,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: HireIQTheme.primaryNavy,
                  foregroundColor: Colors.white,
                  centerTitle: true,
                  title: Text(
                    'My Job Listings',
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  bottom: TabBar(
                    tabs: const [
                      Tab(text: 'Active'),
                      Tab(text: 'Closed'),
                    ],
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white60,
                    indicatorColor: HireIQTheme.primaryTeal,
                    labelStyle:
                        GoogleFonts.inter(fontWeight: FontWeight.w600),
                    unselectedLabelStyle:
                        GoogleFonts.inter(fontWeight: FontWeight.normal),
                  ),
                ),
                SliverFillRemaining(
                  child: TabBarView(
                    children: [
                      _buildJobList(context, active),
                      _buildJobList(context, closed),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildJobList(BuildContext context, List<JobModel> jobs) {
    if (jobs.isEmpty) {
      return const EmptyState(
        icon: Icons.work_off_outlined,
        heading: 'No listings here',
        body: 'Jobs in this category will appear here',
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return GestureDetector(
          onTap: () => context.push('/employer/candidates'),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
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
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: HireIQTheme.textPrimary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        job.location,
                        style: GoogleFonts.inter(
                            fontSize: 13, color: HireIQTheme.textMuted),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${job.applicationsCount} applicants',
                      style: GoogleFonts.inter(
                          color: HireIQTheme.primaryTeal,
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    const Icon(Icons.chevron_right,
                        size: 16, color: HireIQTheme.textMuted),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
