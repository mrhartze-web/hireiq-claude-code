import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';
import '../mobile_screens.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/job_provider.dart';

class CandidateJobFeed extends ConsumerWidget {
  const CandidateJobFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title:
            const Text('HireIQ', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => context.push('/notifications'),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMatchIQCard(context),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recommended for You',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ref.watch(activeJobsProvider).when(
                  data: (jobs) {
                    if (jobs.isEmpty) {
                      return const Center(child: Text('No jobs available.'));
                    }
                    return Column(
                      children: jobs
                          .map((job) => _buildJobCard(
                                context,
                                title: job.title,
                                company: job.company,
                                location: job.location,
                                logo: Icons.work,
                                tags: job.skills.take(3).toList(),
                              ))
                          .toList(),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchIQCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [HireIQTheme.primaryTeal, Color(0xFF00796B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryTeal.withAlpha(76),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your MatchIQ is ready',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Icon(Icons.auto_awesome, color: Colors.white),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Updated 5 mins ago based on your profile',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.push(MobileRoutes.candidateWildcard),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: HireIQTheme.primaryTeal,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('View Match Report'),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(
    BuildContext context, {
    required String title,
    required String company,
    required String location,
    required IconData logo,
    required List<String> tags,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: InkWell(
        onTap: () => context
            .push(MobileRoutes.candidateJobDetail.replaceFirst(':id', '123')),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: HireIQTheme.background,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(logo, color: HireIQTheme.primaryTeal, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          '$company • $location',
                          style: const TextStyle(
                              color: HireIQTheme.textMuted, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.bookmark_border,
                      color: HireIQTheme.textMuted),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: tags.map((tag) => _buildTag(tag)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    final isMatch = label == 'High Match';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isMatch
            ? HireIQTheme.primaryTeal.withAlpha(25)
            : HireIQTheme.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isMatch ? HireIQTheme.primaryTeal : HireIQTheme.textMuted,
          fontWeight: isMatch ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
