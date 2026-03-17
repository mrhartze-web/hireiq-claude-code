import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class HiringAnalyticsScreen extends StatelessWidget {
  const HiringAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        title: const Text(
          'Hiring Analytics',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewCards(),
            const SizedBox(height: 32),
            const Text(
              'Pipeline Health',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQColors.navy),
            ),
            const SizedBox(height: 16),
            _buildPipelineChart(),
            const SizedBox(height: 32),
            const Text(
              'Insights',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQColors.navy),
            ),
            const SizedBox(height: 16),
            _buildInsightItem(
                'Time to Hire', '14 Days', Icons.timer_outlined, Colors.purple),
            _buildInsightItem('Offer Acceptance', '94%',
                Icons.check_circle_outline, HireIQColors.teal),
            _buildInsightItem('Cost per Hire', '\$1,200',
                Icons.monetization_on_outlined, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCards() {
    return Row(
      children: [
        Expanded(
            child: _buildSimpleStat(
                '840', 'Total Views', Icons.remove_red_eye_outlined)),
        const SizedBox(width: 16),
        Expanded(
            child: _buildSimpleStat(
                '124', 'Applications', Icons.description_outlined)),
      ],
    );
  }

  Widget _buildSimpleStat(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: HireIQColors.navy, size: 24),
          const SizedBox(height: 12),
          Text(value,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HireIQColors.navy)),
          Text(label,
              style:
                  const TextStyle(fontSize: 12, color: HireIQColors.textMuted)),
        ],
      ),
    );
  }

  Widget _buildPipelineChart() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQColors.navy,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _buildBar('Applied', 0.9, Colors.white),
          const SizedBox(height: 16),
          _buildBar('Shortlisted', 0.6, HireIQColors.teal),
          const SizedBox(height: 16),
          _buildBar(
              'Interviewed', 0.3, HireIQColors.teal.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          _buildBar('Offered', 0.1, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildBar(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 12)),
            Text('${(value * 100).toInt()}',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.white12,
          color: color,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildInsightItem(
      String title, String value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQColors.silver),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 16),
          Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: HireIQColors.navy))),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: HireIQColors.navy)),
        ],
      ),
    );
  }
}
