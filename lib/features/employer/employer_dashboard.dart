import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';

class EmployerDashboard extends ConsumerWidget {
  const EmployerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/employer/post-job'),
        backgroundColor: HireIQTheme.primaryNavy,
        label: Text(
          'Post a Job',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600, color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Employer Hub',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon:
                    const Icon(Icons.settings_outlined, color: Colors.white),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dashboard Overview',
                    style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.textPrimary),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Total Applications',
                          '142',
                          Icons.people_outline,
                          HireIQTheme.primaryTeal,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          'Active Jobs',
                          '12',
                          Icons.work_outline,
                          HireIQTheme.primaryNavy,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Recent Activity',
                    style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: HireIQTheme.textPrimary),
                  ),
                  const SizedBox(height: 12),
                  _buildActivityItem('Senior Dev', '3 new applicants', '2 hrs ago'),
                  _buildActivityItem(
                      'UI Designer', 'Interview scheduled', '5 hrs ago'),
                  _buildActivityItem(
                      'DevOps Eng', 'Listing expired', '1 day ago'),
                  const SizedBox(height: 28),
                  Text(
                    'Active Listings',
                    style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: HireIQTheme.textPrimary),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(
                    3,
                    (index) => GestureDetector(
                      onTap: () => context.push('/employer/my-jobs'),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: HireIQTheme.surfaceWhite,
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusLg),
                          border: Border.all(color: HireIQTheme.borderLight),
                          boxShadow: [
                            BoxShadow(
                              color: HireIQTheme.primaryNavy
                                  .withValues(alpha: 0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Software Engineer $index',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        color: HireIQTheme.textPrimary),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Posted on Mar ${10 - index}, 2024',
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: HireIQTheme.textMuted),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right,
                                color: HireIQTheme.textMuted),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color iconColor) {
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
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusSm),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.textPrimary),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.inter(
                fontSize: 12, color: HireIQTheme.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
      String title, String subtitle, String time) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        border:
            Border(bottom: BorderSide(color: HireIQTheme.borderLight)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.textPrimary),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                      fontSize: 13, color: HireIQTheme.textMuted),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: GoogleFonts.inter(
                fontSize: 12, color: HireIQTheme.textLight),
          ),
        ],
      ),
    );
  }
}
