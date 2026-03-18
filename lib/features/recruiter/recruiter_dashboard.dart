import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class RecruiterDashboard extends StatelessWidget {
  const RecruiterDashboard({super.key});

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
              'HireIQ',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.white),
                onPressed: () {},
              ),
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage:
                      NetworkImage('https://i.pravatar.cc/150?u=riya'),
                ),
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
                    'Welcome back, Riya',
                    style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Here\'s your performance overview for today.',
                    style: GoogleFonts.inter(
                        fontSize: 14, color: HireIQTheme.textMuted),
                  ),
                  const SizedBox(height: 24),
                  _buildPerformanceGrid(),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Quick Actions'),
                  const SizedBox(height: 16),
                  _buildQuickActions(context),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Recent Candidates'),
                  const SizedBox(height: 16),
                  _buildCandidateCard(
                    'Thabo Mokoena',
                    'Fullstack Developer • Sandton',
                    'Waiting for MatchIQ Signal...',
                    Icons.hourglass_empty,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard('Pipeline Value', 'R4.5m', Icons.account_tree_outlined),
        _buildStatCard('Active Briefs', '12', Icons.assignment_outlined),
        _buildStatCard('Latest Placement', 'R180k', Icons.check_circle_outline),
        _buildStatCard('Fee %', '15%', Icons.percent),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: HireIQTheme.primaryTeal, size: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy)),
              Text(label,
                  style: GoogleFonts.inter(
                      fontSize: 12, color: HireIQTheme.textMuted)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy)),
        GestureDetector(
          onTap: () {},
          child: Text(
            'View All',
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: HireIQTheme.primaryTeal),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(
            context, 'New Brief', Icons.add_box, HireIQTheme.primaryTeal),
        _buildActionButton(
            context, 'Search', Icons.search, const Color(0xFFF59E0B)),
        _buildActionButton(context, 'Signals', Icons.bolt,
            HireIQTheme.primaryNavy),
        _buildActionButton(context, 'Report', Icons.bar_chart,
            HireIQTheme.primaryTeal),
      ],
    );
  }

  Widget _buildActionButton(
      BuildContext context, String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 12, fontWeight: FontWeight.w500,
                color: HireIQTheme.textPrimary)),
      ],
    );
  }

  Widget _buildCandidateCard(
      String name, String subtitle, String status, IconData statusIcon) {
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
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
            child: Text(name[0],
                style: GoogleFonts.inter(
                    color: HireIQTheme.primaryTeal,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: HireIQTheme.textPrimary)),
                Text(subtitle,
                    style: GoogleFonts.inter(
                        color: HireIQTheme.textMuted, fontSize: 13)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(statusIcon,
                        size: 14, color: const Color(0xFFF59E0B)),
                    const SizedBox(width: 4),
                    Text(status,
                        style: GoogleFonts.inter(
                            color: const Color(0xFFF59E0B),
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: HireIQTheme.textMuted),
        ],
      ),
    );
  }
}
