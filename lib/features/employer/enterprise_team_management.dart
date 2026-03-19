import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EnterpriseTeamManagementScreen extends ConsumerWidget {
  const EnterpriseTeamManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Team Management',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          const _ComingSoonBanner(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manage your hiring team',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Invite, manage permissions, and track your team\'s hiring activity across the organisation.',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: HireIQTheme.textMuted,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildFeatureCard(
                    icon: Icons.person_add_outlined,
                    title: 'Invite team members',
                    subtitle: 'Add hiring managers, coordinators, and viewers',
                  ),
                  _buildFeatureCard(
                    icon: Icons.admin_panel_settings_outlined,
                    title: 'Role-based permissions',
                    subtitle: 'Control what each team member can see and do',
                  ),
                  _buildFeatureCard(
                    icon: Icons.analytics_outlined,
                    title: 'Team performance',
                    subtitle: 'Track hires, interviews, and time-to-fill by recruiter',
                  ),
                  _buildFeatureCard(
                    icon: Icons.group_outlined,
                    title: 'Department seats',
                    subtitle: 'Allocate seats per department with spend caps',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: HireIQTheme.primaryNavy),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: HireIQTheme.textMuted,
                  ),
                ),
              ],
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
