import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class EmployerDiversityReport extends StatelessWidget {
  const EmployerDiversityReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Diversity & Inclusion Impact'),
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
              child: const Column(
                children: [
                  Icon(Icons.diversity_3,
                      color: HireIQTheme.primaryTeal, size: 48),
                  SizedBox(height: 16),
                  Text('Level 1 B-BBEE Contributor',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(
                      'Your recent hires through HireIQ have significantly improved your BBBEE score compliance.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, height: 1.4)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                    child: _buildMetricCard(
                        'BEE Candidates Hired', '12', Icons.how_to_reg)),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildMetricCard(
                        'Female Representation', '+15%', Icons.trending_up,
                        isPercent: true)),
              ],
            ),
            const SizedBox(height: 24),
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
                  const Text('Quarterly Hiring Diversity',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 24),
                  _buildProgressRow('BEE Candidates (Total)', 0.65, '65%'),
                  const SizedBox(height: 16),
                  _buildProgressRow('Female Hires', 0.45, '45%'),
                  const SizedBox(height: 16),
                  _buildProgressRow('Youth (Under 35)', 0.80, '80%'),
                ],
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text('Download Full Report'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: HireIQTheme.primaryTeal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon,
      {bool isPercent = false}) {
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
          Icon(icon,
              color:
                  isPercent ? HireIQTheme.primaryTeal : HireIQTheme.primaryNavy,
              size: 28),
          const SizedBox(height: 16),
          Text(value,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isPercent
                      ? HireIQTheme.primaryTeal
                      : HireIQTheme.primaryNavy)),
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
