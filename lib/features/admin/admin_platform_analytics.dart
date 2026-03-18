import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';

class AdminPlatformAnalytics extends StatelessWidget {
  const AdminPlatformAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Platform Analytics',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child:
                        _buildStatCard('Active Users', '14.2k', '+12%', true)),
                const SizedBox(width: 16),
                Expanded(
                    child:
                        _buildStatCard('Placements', '342', '+5%', true)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _buildStatCard(
                        'Avg TTF (Days)', '18', '-2%', false)),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildStatCard(
                        'Platform Rev', 'R2.4m', '+18%', true)),
              ],
            ),
            const SizedBox(height: 28),
            _buildSectionHeader('User Growth (Monthly)'),
            const SizedBox(height: 16),
            Container(
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
              child: SizedBox(
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
            ),
            const SizedBox(height: 28),
            _buildSectionHeader('AI Performance'),
            const SizedBox(height: 16),
            Container(
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
              child: Column(
                children: [
                  _buildProgressRow('MatchIQ Accuracy Rate', 0.92, '92%'),
                  const SizedBox(height: 16),
                  _buildProgressRow(
                      'Automated Brief Generations', 0.85, '85%'),
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: HireIQTheme.primaryNavy),
    );
  }

  Widget _buildStatCard(
      String title, String value, String trend, bool isPositive) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                      color: HireIQTheme.textMuted, fontSize: 12),
                ),
              ),
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive
                    ? HireIQTheme.primaryTeal
                    : HireIQTheme.error,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy),
          ),
          const SizedBox(height: 4),
          Text(
            trend,
            style: GoogleFonts.inter(
                color: isPositive
                    ? HireIQTheme.primaryTeal
                    : HireIQTheme.error,
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(double heightPercentage, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 28,
          height: 110 * heightPercentage,
          decoration: BoxDecoration(
            color: heightPercentage == 1.0
                ? HireIQTheme.primaryTeal
                : HireIQTheme.primaryNavy,
            borderRadius: BorderRadius.circular(HireIQTheme.radiusSm),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(
              color: HireIQTheme.textMuted, fontSize: 11),
        ),
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
            Text(
              label,
              style: GoogleFonts.inter(
                  color: HireIQTheme.primaryNavy,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            Text(
              percentageText,
              style: GoogleFonts.inter(
                  color: HireIQTheme.primaryTeal,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: HireIQTheme.borderLight,
          valueColor: const AlwaysStoppedAnimation<Color>(
              HireIQTheme.primaryTeal),
          minHeight: 8,
          borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
        ),
      ],
    );
  }
}
