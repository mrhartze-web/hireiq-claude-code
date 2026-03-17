import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';

class EmployerMyJobs extends ConsumerWidget {
  const EmployerMyJobs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: DefaultTabController(
        length: 3,
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
                  Tab(text: 'Paused'),
                  Tab(text: 'Closed'),
                ],
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
                indicatorColor: HireIQTheme.primaryTeal,
                labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
                unselectedLabelStyle:
                    GoogleFonts.inter(fontWeight: FontWeight.normal),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  _buildJobList(context, const [
                    _JobListing('Senior Flutter Developer', '42 Applicants',
                        'Posted 5 days ago'),
                    _JobListing(
                        'UX Designer', '12 Applicants', 'Posted 2 days ago'),
                  ]),
                  _buildJobList(context, const [
                    _JobListing('Backend Engineer', '8 Applicants',
                        'Paused 1 day ago'),
                  ]),
                  _buildJobList(context, const [
                    _JobListing('Product Manager', '56 Applicants',
                        'Closed 1 month ago'),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobList(BuildContext context, List<_JobListing> jobs) {
    if (jobs.isEmpty) {
      return Center(
        child: Text(
          'No jobs in this category',
          style: GoogleFonts.inter(color: HireIQTheme.textMuted),
        ),
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
                        job.date,
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
                      job.applicants,
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

class _JobListing {
  final String title;
  final String applicants;
  final String date;
  const _JobListing(this.title, this.applicants, this.date);
}
