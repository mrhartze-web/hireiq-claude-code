import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerDiversityReport extends StatelessWidget {
  const EmployerDiversityReport({super.key});

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
              'Diversity & Inclusion Impact',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          HireIQTheme.primaryNavy,
                          Color(0xFF243659),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusXl),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: HireIQTheme.primaryTeal
                                .withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.diversity_3,
                              color: HireIQTheme.primaryTeal, size: 36),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Level 1 B-BBEE Contributor',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your recent hires through HireIQ have significantly improved your BBBEE score compliance.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              color: Colors.white70, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                          child: _buildMetricCard(
                              'BEE Candidates Hired',
                              '12',
                              Icons.how_to_reg)),
                      const SizedBox(width: 16),
                      Expanded(
                          child: _buildMetricCard(
                              'Female Representation',
                              '+15%',
                              Icons.trending_up,
                              isPercent: true)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg),
                      border:
                          Border.all(color: HireIQTheme.borderLight),
                      boxShadow: [
                        BoxShadow(
                          color: HireIQTheme.primaryNavy
                              .withValues(alpha: 0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quarterly Hiring Diversity',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: HireIQTheme.primaryNavy),
                        ),
                        const SizedBox(height: 20),
                        _buildProgressRow(
                            'BEE Candidates (Total)', 0.65, '65%'),
                        const SizedBox(height: 16),
                        _buildProgressRow(
                            'Female Hires', 0.45, '45%'),
                        const SizedBox(height: 16),
                        _buildProgressRow(
                            'Youth (Under 35)', 0.80, '80%'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            HireIQTheme.primaryTeal,
                            Color(0xFF0A7A70),
                          ],
                        ),
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.download,
                              color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Download Full Report',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ],
                      ),
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

  Widget _buildMetricCard(String title, String value, IconData icon,
      {bool isPercent = false}) {
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
          Icon(
            icon,
            color: isPercent
                ? HireIQTheme.primaryTeal
                : HireIQTheme.primaryNavy,
            size: 28,
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: GoogleFonts.inter(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: isPercent
                    ? HireIQTheme.primaryTeal
                    : HireIQTheme.primaryNavy),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.inter(
                color: HireIQTheme.textMuted,
                fontSize: 13,
                height: 1.3),
          ),
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
            Text(
              label,
              style: GoogleFonts.inter(
                  color: HireIQTheme.primaryNavy,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              percentageText,
              style: GoogleFonts.inter(
                  color: HireIQTheme.primaryTeal,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: HireIQTheme.borderLight,
          valueColor: const AlwaysStoppedAnimation<Color>(
              HireIQTheme.primaryNavy),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
