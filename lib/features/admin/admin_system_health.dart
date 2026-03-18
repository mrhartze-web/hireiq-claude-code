import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class AdminSystemHealth extends StatelessWidget {
  const AdminSystemHealth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'System Health',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusHeader(),
            const SizedBox(height: 32),
            _buildIncidentsSection(),
            const SizedBox(height: 32),
            _buildUptimeSection(),
            const SizedBox(height: 32),
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
        color: HireIQTheme.success.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
            color: HireIQTheme.success.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: HireIQTheme.success, size: 32),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All systems operational',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.success),
              ),
              Text(
                'Last updated: 1 min ago',
                style: GoogleFonts.inter(
                    fontSize: 12, color: HireIQTheme.textMuted),
              ),
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
        Text(
          'Active Alerts',
          style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.primaryNavy),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: HireIQTheme.warning.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
            border: Border.all(
                color: HireIQTheme.warning.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: HireIQTheme.warning, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'DHA API degraded',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.warning,
                        fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '7 verifications delayed. Investigating latency issues with department upstream provider.',
                style: GoogleFonts.inter(
                    fontSize: 13,
                    color: HireIQTheme.textPrimary,
                    height: 1.4),
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
        Text(
          'Service Uptime (24h)',
          style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.primaryNavy),
        ),
        const SizedBox(height: 16),
        Container(
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
              SizedBox(
                height: 80,
                child: Row(
                  children: List.generate(48, (index) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: index == 30
                              ? HireIQTheme.warning
                              : HireIQTheme.success,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '24h ago',
                    style: GoogleFonts.inter(
                        fontSize: 10, color: HireIQTheme.textMuted),
                  ),
                  Text(
                    '99.98% Uptime',
                    style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.success),
                  ),
                  Text(
                    'Now',
                    style: GoogleFonts.inter(
                        fontSize: 10, color: HireIQTheme.textMuted),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Metrics',
          style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.primaryNavy),
        ),
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
    final bool isPositive = trend.startsWith('+');
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
                fontSize: 11, color: HireIQTheme.textMuted),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy),
              ),
              Text(
                trend,
                style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isPositive
                        ? HireIQTheme.success
                        : HireIQTheme.error),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
