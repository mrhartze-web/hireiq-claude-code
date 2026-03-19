import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../providers/job_provider.dart';
import '../../shared/components/skeleton_loader.dart';
import '../../shared/components/error_state.dart';
import '../../shared/components/empty_state.dart';

class EmployerDashboard extends ConsumerWidget {
  const EmployerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final uid = authState.value?.uid ?? '';
    final jobsAsync = ref.watch(employerJobsProvider(uid));

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/employer/post-job'),
        backgroundColor: HireIQTheme.primaryNavy,
        label: Text(
          'Post a Job',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600, color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Employer Hub',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon:
                    const Icon(Icons.settings_outlined, color: Colors.white),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: jobsAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(20),
                child: SkeletonLoader(itemCount: 3),
              ),
              error: (err, _) => Padding(
                padding: const EdgeInsets.all(20),
                child: ErrorState(
                  message: 'Could not load dashboard',
                  onRetry: () => ref.invalidate(employerJobsProvider(uid)),
                ),
              ),
              data: (jobs) {
                final activeJobs = jobs.where((j) => j.isActive).toList();
                final totalApplications =
                    jobs.fold(0, (sum, j) => sum + j.applicationsCount);

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dashboard Overview',
                        style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: HireIQTheme.textPrimary),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              'Total Applications',
                              '$totalApplications',
                              Icons.people_outline,
                              HireIQTheme.primaryTeal,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              'Active Jobs',
                              '${activeJobs.length}',
                              Icons.work_outline,
                              HireIQTheme.primaryNavy,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Active Listings',
                        style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: HireIQTheme.textPrimary),
                      ),
                      const SizedBox(height: 12),
                      if (activeJobs.isEmpty)
                        EmptyState(
                          icon: Icons.work_off_outlined,
                          heading: 'No active listings',
                          body:
                              'Post your first job to start receiving applications',
                          ctaLabel: 'Post a job',
                          onCtaPressed: () =>
                              context.push('/employer/post-job'),
                        )
                      else
                        ...activeJobs.take(5).map(
                              (job) => GestureDetector(
                                onTap: () =>
                                    context.push('/employer/my-jobs'),
                                child: _buildJobCard(
                                  job.title,
                                  job.location,
                                  job.applicationsCount,
                                ),
                              ),
                            ),
                      const SizedBox(height: 80),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color iconColor) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusSm),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.textPrimary),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.inter(
                fontSize: 12, color: HireIQTheme.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(
      String title, String location, int applicationsCount) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
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
                '$applicationsCount applicants',
                style: GoogleFonts.inter(
                    color: HireIQTheme.primaryTeal,
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
              ),
              const Icon(Icons.chevron_right, color: HireIQTheme.textMuted),
            ],
          ),
        ],
      ),
    );
  }
}
