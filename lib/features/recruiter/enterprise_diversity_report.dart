import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EnterpriseDiversityReport extends StatelessWidget {
  const EnterpriseDiversityReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Diversity Report',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPeriodSelector(),
            const SizedBox(height: 24),
            _buildWildcardInsight(),
            const SizedBox(height: 24),
            _buildSectionHeader('Gender Breakdown'),
            _buildStatsCard(
              title: 'Female Representation',
              value: '+12%',
              subtitle: 'Increase from last quarter',
              icon: Icons.people_outline,
              color: const Color(0xFFEC4899),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('B-BBEE Pipeline'),
            _buildStatsCard(
              title: 'B-BBEE Level Compliance',
              value: 'Level 1',
              subtitle: 'Target reached ✓',
              icon: Icons.verified_user_outlined,
              color: HireIQTheme.success,
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Inclusion Metrics'),
            Row(
              children: [
                Expanded(child: _buildMetricMiniCard('4%', 'Disability')),
                const SizedBox(width: 12),
                Expanded(child: _buildMetricMiniCard('11%', 'Neurodiverse')),
                const SizedBox(width: 12),
                Expanded(child: _buildMetricMiniCard('34%', 'First-gen')),
              ],
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: Text(
                'Download Full B-BBEE Report',
                style:
                    GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                backgroundColor: HireIQTheme.primaryNavy,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd)),
              ),
            ),
            const SizedBox(height: 28),
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
        color: isSelected ? HireIQTheme.primaryNavy : HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
        border: Border.all(
            color: isSelected
                ? HireIQTheme.primaryNavy
                : HireIQTheme.borderLight),
        boxShadow: isSelected
            ? []
            : [
                BoxShadow(
                  color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: isSelected ? Colors.white : HireIQTheme.textMuted,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildWildcardInsight() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
            color: HireIQTheme.primaryTeal.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome,
                  color: HireIQTheme.primaryTeal, size: 18),
              const SizedBox(width: 10),
              Text(
                'WildcardIQ Insight',
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryTeal),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Blind screening active — 247 candidates reviewed by skill score only.',
            style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy,
                fontSize: 14),
          ),
          const SizedBox(height: 6),
          Text(
            '100% bias-free ✓',
            style: GoogleFonts.inter(
                color: HireIQTheme.success, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(
        title,
        style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: HireIQTheme.primaryNavy),
      ),
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
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                      fontSize: 13, color: HireIQTheme.textMuted),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: HireIQTheme.success,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricMiniCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
                fontSize: 12, color: HireIQTheme.textMuted),
          ),
        ],
      ),
    );
  }
}
