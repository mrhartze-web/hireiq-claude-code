import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class EmployerAnalytics extends StatelessWidget {
  const EmployerAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights \u0026 Analytics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Performance Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: _buildSimpleStat(
                        'Active Jobs', '14', Icons.work_outline)),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildSimpleStat(
                        'New Apps', '+42', Icons.people_outline)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _buildSimpleStat(
                        'Interviewed', '28', Icons.calendar_today_outlined)),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildSimpleStat(
                        'Accept Rate', '84%', Icons.check_circle_outline)),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Application Trends',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: const Center(
                child: Text('Chart Placeholder',
                    style: TextStyle(color: HireIQTheme.textMuted)),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Top Hiring Sources',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSourceItem('Direct Application', 65, HireIQTheme.primaryTeal),
            _buildSourceItem('Referral', 20, HireIQTheme.amber),
            _buildSourceItem('LinkedIQ Sync', 15, HireIQTheme.primaryNavy),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleStat(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: HireIQTheme.primaryTeal),
          const SizedBox(height: 12),
          Text(value,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(label,
              style:
                  const TextStyle(fontSize: 12, color: HireIQTheme.textMuted)),
        ],
      ),
    );
  }

  Widget _buildSourceItem(String label, int percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 14)),
              Text('$percentage%',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: HireIQTheme.borderLight,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}
