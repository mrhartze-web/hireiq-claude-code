import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EnterpriseDashboard extends StatelessWidget {
  const EnterpriseDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: Column(
        children: [
          const _ComingSoonBanner(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: HireIQTheme.primaryNavy,
                  foregroundColor: Colors.white,
                  centerTitle: true,
                  title: Text(
                    'Enterprise Hub',
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
                        _buildWelcomeHeader(),
                        const SizedBox(height: 24),
                        _buildQuickInsights(),
                        const SizedBox(height: 28),
                        _buildActiveRoles(),
                        const SizedBox(height: 28),
                        _buildTeamActivity(),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FinCorp South Africa',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              color: HireIQTheme.textSecondary,
              fontSize: 13),
        ),
        const SizedBox(height: 4),
        Text(
          'Hiring Performance',
          style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.textPrimary),
        ),
      ],
    );
  }

  Widget _buildQuickInsights() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.primaryNavy.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: HireIQTheme.primaryNavy.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.analytics_outlined,
                color: HireIQTheme.primaryNavy, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SignalIQ Report Ready',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.textPrimary),
                ),
                const SizedBox(height: 2),
                Text(
                  'Q3 Enterprise Hiring Insights are ready for review.',
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: HireIQTheme.textSecondary),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right,
              color: HireIQTheme.primaryNavy),
        ],
      ),
    );
  }

  Widget _buildActiveRoles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Active Roles',
              style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.textPrimary),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'See all',
                style: GoogleFonts.inter(
                    color: HireIQTheme.primaryTeal,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildRoleCard(
            'Head of Engineering', 'Johannesburg • Remote', '42'),
        _buildRoleCard(
            'Senior Data Scientist', 'Cape Town • Hybrid', '18'),
        _buildRoleCard(
            'Flutter Developer', 'Durban • Full-time', '65'),
      ],
    );
  }

  Widget _buildRoleCard(
      String title, String location, String appCount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
                const SizedBox(height: 4),
                Text(
                  location,
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: HireIQTheme.textSecondary),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                appCount,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: HireIQTheme.primaryNavy),
              ),
              Text(
                'Apps',
                style: GoogleFonts.inter(
                    fontSize: 11,
                    color: HireIQTheme.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Team Activity',
          style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.textPrimary),
        ),
        const SizedBox(height: 14),
        _buildActivityItem(
            'Sarah M. shortlisted 3 candidates for Head of Eng.'),
        _buildActivityItem(
            'David K. moved an offer to Approved state.'),
      ],
    );
  }

  Widget _buildActivityItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: HireIQTheme.borderLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.history,
                size: 16,
                color: HireIQTheme.textSecondary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                  fontSize: 13, color: HireIQTheme.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComingSoonBanner extends StatelessWidget {
  const _ComingSoonBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: HireIQTheme.primaryNavy,
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Enterprise — Available Soon',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: HireIQTheme.amber,
              borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
            ),
            child: Text(
              'Soon',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: HireIQTheme.primaryNavy,
              ),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You will be notified when Enterprise launches.'),
              ),
            ),
            child: Text(
              'Join Waitlist',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: HireIQTheme.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
