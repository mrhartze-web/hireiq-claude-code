import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class RecruiterPlacementTracker extends StatelessWidget {
  const RecruiterPlacementTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Placement Pipeline'),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Active Submissions',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 16),
                  _buildTrackerCard('Alice Johnson', 'Senior Developer',
                      'Apex Digital', 'Interviewing', HireIQTheme.primaryTeal),
                  _buildTrackerCard(
                      'Bob Smith',
                      'Backend Engineer',
                      'FinTech Startup',
                      'Submitted (Awaiting Review)',
                      HireIQTheme.textMuted),
                  _buildTrackerCard('Charlie Davis', 'UI/UX Designer',
                      'Global Tech', 'Offer Extended', HireIQTheme.amber),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackerCard(String candidate, String role, String client,
      String status, Color statusColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(candidate,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('$role at $client',
                style: const TextStyle(color: HireIQTheme.textMuted)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                  color: statusColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(status,
                  style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 16, color: HireIQTheme.textMuted),
        onTap: () {},
      ),
    );
  }
}
