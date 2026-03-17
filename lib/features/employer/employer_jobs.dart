import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';

class EmployerMyJobs extends ConsumerWidget {
  const EmployerMyJobs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Job Listings'),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Active'),
                Tab(text: 'Paused'),
                Tab(text: 'Closed'),
              ],
              labelColor: HireIQTheme.primaryTeal,
              unselectedLabelColor: HireIQTheme.textMuted,
              indicatorColor: HireIQTheme.primaryTeal,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildJobList(context, [
                    _JobListing('Senior Flutter Developer', '42 Applicants',
                        'Posted 5 days ago'),
                    _JobListing(
                        'UX Designer', '12 Applicants', 'Posted 2 days ago'),
                  ]),
                  _buildJobList(context, [
                    _JobListing(
                        'Backend Engineer', '8 Applicants', 'Paused 1 day ago'),
                  ]),
                  _buildJobList(context, [
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
      return const Center(child: Text('No jobs in this category'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text(job.title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(job.date),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(job.applicants,
                    style: const TextStyle(
                        color: HireIQTheme.primaryTeal,
                        fontWeight: FontWeight.bold)),
                const Icon(Icons.chevron_right, size: 16),
              ],
            ),
            onTap: () => context.push('/employer/candidates'),
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
  _JobListing(this.title, this.applicants, this.date);
}
