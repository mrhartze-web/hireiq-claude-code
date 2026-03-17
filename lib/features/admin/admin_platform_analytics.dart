import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class AdminPlatformAnalytics extends StatelessWidget {
  const AdminPlatformAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Platform Analytics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child:
                        _buildStatCard('Active Users', '14.2k', '+12%', true)),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildStatCard('Placements', '342', '+5%', true)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child:
                        _buildStatCard('Avg TTF (Days)', '18', '-2%', false)),
                const SizedBox(width: 16),
                Expanded(
                    child:
                        _buildStatCard('Platform Rev', 'R2.4m', '+18%', true)),
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
                  const Text('User Growth (Monthly)',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildBar(0.4, 'Jan'),
                        _buildBar(0.5, 'Feb'),
                        _buildBar(0.45, 'Mar'),
                        _buildBar(0.7, 'Apr'),
                        _buildBar(0.85, 'May'),
                        _buildBar(1.0, 'Jun'),
                      ],
                    ),
                  ),
                ],
              ),
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
                  const Text('AI Performance',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 24),
                  _buildProgressRow('MatchIQ Accuracy Rate', 0.92, '92%'),
                  const SizedBox(height: 16),
                  _buildProgressRow('Automated Brief Generations', 0.85, '85%'),
                  const SizedBox(height: 16),
                  _buildProgressRow(
                      'PassportIQ Auto-Verification', 0.95, '95%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, String trend, bool isPositive) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: HireIQTheme.textMuted, fontSize: 13)),
              Icon(isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  color:
                      isPositive ? HireIQTheme.primaryTeal : HireIQTheme.error,
                  size: 16),
            ],
          ),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 4),
          Text(trend,
              style: TextStyle(
                  color:
                      isPositive ? HireIQTheme.primaryTeal : HireIQTheme.error,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildBar(double heightPercentage, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 30,
          height: 120 * heightPercentage,
          decoration: BoxDecoration(
            color: HireIQTheme.primaryNavy,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(color: HireIQTheme.textMuted, fontSize: 12)),
      ],
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
              const AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
