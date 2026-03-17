import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';

class EmployerDashboard extends ConsumerWidget {
  const EmployerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employer Hub'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/employer/post-job'),
        backgroundColor: HireIQTheme.primaryNavy,
        label: const Text('Post a Job', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dashboard Overview',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(context, 'Total Applications', '142',
                      Icons.people_outline),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                      context, 'Active Jobs', '12', Icons.work_outline),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Text('Recent Activity',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),

            _buildActivityItem(
                context, 'Senior Dev', '3 new applicants', '2 hrs ago'),
            _buildActivityItem(
                context, 'UI Designer', 'Interview scheduled', '5 hrs ago'),
            _buildActivityItem(
                context, 'DevOps Eng', 'Listing expired', '1 day ago'),

            const SizedBox(height: 32),
            Text('Active Listings',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),

            // Job list summary
            ...List.generate(
                3,
                (index) => Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text('Software Engineer $index'),
                        subtitle: Text('Posted on Mar ${10 - index}, 2024'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/employer/my-jobs'),
                      ),
                    )),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      BuildContext context, String label, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: HireIQTheme.primaryTeal, size: 20),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.displaySmall),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
      BuildContext context, String title, String subtitle, String time) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: HireIQTheme.borderLight)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          Text(time, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
