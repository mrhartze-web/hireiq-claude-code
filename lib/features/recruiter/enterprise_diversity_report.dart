import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class EnterpriseDiversityReport extends StatelessWidget {
  const EnterpriseDiversityReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Diversity Report'),
        backgroundColor: HireIQTheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildPeriodSelector(),
            const SizedBox(height: 25),
            _buildWildcardInsight(),
            const SizedBox(height: 25),
            _buildSectionHeader('Gender Breakdown'),
            _buildStatsCard(
              title: 'Female Representation',
              value: '+12%',
              subtitle: 'Increase from last quarter',
              icon: Icons.people_outline,
              color: Colors.pink,
            ),
            const SizedBox(height: 25),
            _buildSectionHeader('B-BBEE Pipeline'),
            _buildStatsCard(
              title: 'B-BBEE Level Compliance',
              value: 'Level 1',
              subtitle: 'Target reached ✓',
              icon: Icons.verified_user_outlined,
              color: Colors.green,
            ),
            const SizedBox(height: 25),
            _buildSectionHeader('Inclusion Metrics'),
            Row(
              children: [
                Expanded(child: _buildMetricMiniCard('4%', 'Disability')),
                const SizedBox(width: 10),
                Expanded(child: _buildMetricMiniCard('11%', 'Neurodiverse')),
                const SizedBox(width: 10),
                Expanded(child: _buildMetricMiniCard('34%', 'First-gen')),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text('Download Full B-BBEE Report'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Row(
      children: [
        _buildPeriodChip('Q1 2026', true),
        const SizedBox(width: 10),
        _buildPeriodChip('Q4 2025', false),
        const SizedBox(width: 10),
        _buildPeriodChip('Q3 2025', false),
      ],
    );
  }

  Widget _buildPeriodChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? HireIQTheme.primary : HireIQTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: isSelected ? HireIQTheme.primary : HireIQTheme.border),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : HireIQTheme.textSecondary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildWildcardInsight() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.accent.withAlpha(25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.accent.withAlpha(76)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome,
                  color: HireIQTheme.accent, size: 20),
              const SizedBox(width: 10),
              Text('WildcardIQ Insight',
                  style: HireIQTheme.subtitleStyle
                      .copyWith(color: HireIQTheme.accent, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Blind screening active — 247 candidates reviewed by skill score only.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text('100% bias-free ✓',
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(title, style: HireIQTheme.subtitleStyle),
    );
  }

  Widget _buildStatsCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: HireIQTheme.bodyStyle
                        .copyWith(color: HireIQTheme.textSecondary)),
                const SizedBox(height: 4),
                Text(value,
                    style: HireIQTheme.subtitleStyle.copyWith(fontSize: 24)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: HireIQTheme.bodyStyle
                        .copyWith(fontSize: 12, color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricMiniCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: HireIQTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.border),
      ),
      child: Column(
        children: [
          Text(value, style: HireIQTheme.subtitleStyle.copyWith(fontSize: 20)),
          const SizedBox(height: 5),
          Text(label,
              style: HireIQTheme.bodyStyle
                  .copyWith(fontSize: 12, color: HireIQTheme.textSecondary)),
        ],
      ),
    );
  }
}
