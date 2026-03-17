import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class RecruiterPerformanceDashboard extends StatelessWidget {
  const RecruiterPerformanceDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Performance'),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryNavy,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.stars, color: HireIQTheme.amber, size: 64),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Top Tier Recruiter',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Text('You are in the top 5% of earners this quarter.',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                height: 1.4)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                    child: _buildMetricCard(
                        'Submissions', '45', Icons.send_outlined)),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildMetricCard(
                        'Interviews', '12', Icons.videocam_outlined)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _buildMetricCard(
                        'Offers', '4', Icons.local_activity_outlined)),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildMetricCard('Placements', '3', Icons.done_all,
                        color: HireIQTheme.primaryTeal)),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Conversion Rates',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 24),
                  _buildProgressRow('Submission -> Interview', 0.26, '26%'),
                  const SizedBox(height: 16),
                  _buildProgressRow('Interview -> Offer', 0.33, '33%'),
                  const SizedBox(height: 16),
                  _buildProgressRow('Offer -> Placement', 0.75, '75%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon,
      {Color color = HireIQTheme.primaryNavy}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 16),
          Text(value,
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(title,
              style: const TextStyle(
                  color: HireIQTheme.textMuted, fontSize: 13, height: 1.3)),
        ],
      ),
    );
  }

  Widget _buildProgressRow(
      String label, double progress, String percentageText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    color: HireIQTheme.primaryNavy,
                    fontWeight: FontWeight.w500)),
            Text(percentageText,
                style: const TextStyle(
                    color: HireIQTheme.primaryTeal,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: HireIQTheme.borderLight,
          valueColor:
              const AlwaysStoppedAnimation<Color>(HireIQTheme.primaryNavy),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
