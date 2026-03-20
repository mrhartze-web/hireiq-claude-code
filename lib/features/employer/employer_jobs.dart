import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/empty_state.dart';

class EmployerJobs extends ConsumerStatefulWidget {
  const EmployerJobs({super.key});

  @override
  ConsumerState<EmployerJobs> createState() => _EmployerJobsState();
}

class _EmployerJobsState extends ConsumerState<EmployerJobs>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  static const _active = [
    _Job(
      title: 'Senior Flutter Developer',
      location: 'Cape Town (Remote-friendly)',
      salary: 'R60k – R80k',
      applicants: 47,
      posted: '5 days ago',
      isPaused: false,
      matchIqEnabled: true,
    ),
    _Job(
      title: 'Data Scientist',
      location: 'Johannesburg',
      salary: 'R55k – R70k',
      applicants: 23,
      posted: '12 days ago',
      isPaused: false,
      matchIqEnabled: true,
    ),
  ];

  static const _paused = [
    _Job(
      title: 'Product Manager',
      location: 'Cape Town',
      salary: 'R75k – R95k',
      applicants: 34,
      posted: '1 month ago',
      isPaused: true,
      matchIqEnabled: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'My Jobs',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            bottom: TabBar(
              controller: _tabs,
              labelStyle: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.w700),
              unselectedLabelStyle: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.w500),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withValues(alpha: 0.5),
              indicatorColor: HireIQTheme.amber,
              indicatorWeight: 3,
              tabs: [
                Tab(text: 'Active (${_active.length})'),
                Tab(text: 'Paused (${_paused.length})'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabs,
          children: [
            _buildList(_active),
            _buildList(_paused, isPaused: true),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: HireIQTheme.amber,
        foregroundColor: HireIQTheme.primaryNavy,
        icon: const Icon(Icons.add),
        label: Text(
          'Post Job',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildList(List<_Job> jobs, {bool isPaused = false}) {
    if (jobs.isEmpty) {
      return EmptyState(
        icon: Icons.work_outline_rounded,
        heading: isPaused ? 'No paused jobs' : 'No active jobs',
        body: 'Tap "Post Job" to create your first listing.',
        ctaLabel: 'Post a Job',
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: jobs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) => _JobCard(job: jobs[i]),
    );
  }
}

class _Job {
  const _Job({
    required this.title,
    required this.location,
    required this.salary,
    required this.applicants,
    required this.posted,
    required this.isPaused,
    required this.matchIqEnabled,
  });

  final String title;
  final String location;
  final String salary;
  final int applicants;
  final String posted;
  final bool isPaused;
  final bool matchIqEnabled;
}

class _JobCard extends StatelessWidget {
  const _JobCard({required this.job});
  final _Job job;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
          color: job.isPaused
              ? HireIQTheme.borderLight
              : HireIQTheme.primaryNavy.withValues(alpha: 0.15),
        ),
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: job.isPaused
                              ? HireIQTheme.textMuted
                              : HireIQTheme.primaryNavy),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 12, color: HireIQTheme.textMuted),
                        const SizedBox(width: 3),
                        Text(
                          job.location,
                          style: GoogleFonts.inter(
                              fontSize: 12, color: HireIQTheme.textMuted),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert_rounded,
                    color: HireIQTheme.textMuted),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryNavy.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  job.salary,
                  style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy),
                ),
              ),
              const Spacer(),
              if (job.matchIqEnabled)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.auto_awesome_rounded,
                          size: 11, color: HireIQTheme.primaryTeal),
                      const SizedBox(width: 4),
                      Text(
                        'MatchIQ On',
                        style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryTeal),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.people_outline_rounded,
                  size: 14, color: HireIQTheme.textMuted),
              const SizedBox(width: 5),
              Text(
                '${job.applicants} applicants',
                style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: HireIQTheme.textPrimary),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.access_time_rounded,
                  size: 14, color: HireIQTheme.textMuted),
              const SizedBox(width: 4),
              Text(
                job.posted,
                style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: HireIQTheme.borderLight),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: HireIQTheme.primaryNavy,
                    side: const BorderSide(color: HireIQTheme.borderMedium),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd)),
                  ),
                  child: Text(
                    'Edit',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: job.isPaused
                        ? HireIQTheme.success
                        : HireIQTheme.primaryNavy,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd)),
                  ),
                  child: Text(
                    job.isPaused ? 'Reactivate' : 'View Candidates',
                    style:
                        GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
