import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class AdminSystemHealth extends StatelessWidget {
  const AdminSystemHealth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('System Health'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusHeader(),
            const SizedBox(height: 32),
            _buildIncidentsSection(),
            const SizedBox(height: 40),
            _buildUptimeSection(),
            const SizedBox(height: 40),
            _buildMetricsGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.success.withAlpha(25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.success.withAlpha(76)),
      ),
      child: const Row(
        children: [
          Icon(Icons.check_circle, color: HireIQTheme.success, size: 32),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('All systems operational',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.success)),
              Text('Last updated: 1 min ago',
                  style: TextStyle(fontSize: 12, color: HireIQTheme.textMuted)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Active Alerts',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: HireIQTheme.warning.withAlpha(25),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: HireIQTheme.warning.withAlpha(76)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: HireIQTheme.warning, size: 20),
                  SizedBox(width: 8),
                  Text('DHA API degraded',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: HireIQTheme.warning)),
                ],
              ),
              SizedBox(height: 8),
              Text(
                '7 verifications delayed. Investigating latency issues with department upstream provider.',
                style: TextStyle(fontSize: 14, color: HireIQTheme.textPrimary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUptimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Service Uptime (24h)',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy)),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: Row(
            children: List.generate(48, (index) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    color:
                        index == 30 ? HireIQTheme.warning : HireIQTheme.success,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('24h ago',
                style: TextStyle(fontSize: 10, color: HireIQTheme.textMuted)),
            Text('99.98% Uptime',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.success)),
            Text('Now',
                style: TextStyle(fontSize: 10, color: HireIQTheme.textMuted)),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Key Metrics',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy)),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildMetricCard('API Requests', '847K', '+12%'),
            _buildMetricCard('MatchIQ Scores', '124K', '+5%'),
            _buildMetricCard('Active Users', '14.2K', '+8%'),
            _buildMetricCard('Error Rate', '0.04%', '-1%'),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(String label, String value, String trend) {
    bool isPositive = trend.startsWith('+');
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
          Text(label,
              style:
                  const TextStyle(fontSize: 12, color: HireIQTheme.textMuted)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy)),
              Text(trend,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isPositive
                          ? HireIQTheme.success
                          : HireIQTheme.error)),
            ],
          ),
        ],
      ),
    );
  }
}
