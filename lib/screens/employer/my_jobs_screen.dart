import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class MyJobsScreen extends StatelessWidget {
  const MyJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        title: const Text(
          'My Job Postings',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildJobCard(context, 'Senior Product Architect', 'Full-time • Tech',
              '12 matches', 0.98),
          _buildJobCard(context, 'UX Research Lead', 'Contract • Design',
              '8 matches', 0.75),
          _buildJobCard(context, 'Growth Engineer', 'Full-time • Growth',
              '15 matches', 0.50),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/post-job'),
        label: const Text('Post New Job'),
        icon: const Icon(Icons.add_rounded),
      ),
    );
  }

  Widget _buildJobCard(BuildContext context, String title, String info,
      String matchCount, double fill) {
    return GestureDetector(
      onTap: () => context.push('/shortlist-view'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: HireIQColors.silver),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HireIQColors.navy)),
            Text(info,
                style: const TextStyle(
                    color: HireIQColors.textMuted, fontSize: 14)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(matchCount,
                    style: const TextStyle(
                        color: HireIQColors.teal, fontWeight: FontWeight.bold)),
                const Icon(Icons.arrow_forward_rounded,
                    color: HireIQColors.silver, size: 20),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                  value: fill,
                  backgroundColor: HireIQColors.surface,
                  color: HireIQColors.teal,
                  minHeight: 6),
            ),
          ],
        ),
      ),
    );
  }
}
