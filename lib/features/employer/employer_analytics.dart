import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerAnalytics extends StatelessWidget {
  const EmployerAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Insights & Analytics',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Performance Overview',
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.textPrimary),
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
                          child: _buildSimpleStat('Interviewed', '28',
                              Icons.calendar_today_outlined)),
                      const SizedBox(width: 16),
                      Expanded(
                          child: _buildSimpleStat('Accept Rate', '84%',
                              Icons.check_circle_outline)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Application Trends',
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.textPrimary),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg),
                      border: Border.all(color: HireIQTheme.borderLight),
                      boxShadow: [
                        BoxShadow(
                          color:
                              HireIQTheme.primaryNavy.withValues(alpha: 0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bar_chart,
                              size: 40,
                              color: HireIQTheme.primaryTeal
                                  .withValues(alpha: 0.5)),
                          const SizedBox(height: 8),
                          Text(
                            'Chart Placeholder',
                            style: GoogleFonts.inter(
                                color: HireIQTheme.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Top Hiring Sources',
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.textPrimary),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg),
                      border: Border.all(color: HireIQTheme.borderLight),
                      boxShadow: [
                        BoxShadow(
                          color:
                              HireIQTheme.primaryNavy.withValues(alpha: 0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildSourceItem(
                            'Direct Application', 65, HireIQTheme.primaryTeal),
                        _buildSourceItem('Referral', 20, HireIQTheme.amber),
                        _buildSourceItem(
                            'LinkedIQ Sync', 15, HireIQTheme.primaryNavy),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleStat(String label, String value, IconData icon) {
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusSm),
            ),
            child: Icon(icon, size: 20, color: HireIQTheme.primaryTeal),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.textPrimary),
          ),
          Text(
            label,
            style: GoogleFonts.inter(
                fontSize: 12, color: HireIQTheme.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceItem(String label, int percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                    fontSize: 14, color: HireIQTheme.textPrimary),
              ),
              Text(
                '$percentage%',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: HireIQTheme.textPrimary),
              ),
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
