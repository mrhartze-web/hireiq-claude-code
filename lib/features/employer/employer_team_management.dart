import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerTeamManagement extends StatelessWidget {
  const EmployerTeamManagement({super.key});

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
              'Team Management',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person_add_outlined,
                    color: Colors.white),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSeatUsageCard(),
                  const SizedBox(height: 28),
                  _buildTabs(),
                  const SizedBox(height: 20),
                  _buildMemberList(),
                  const SizedBox(height: 32),
                  _buildRoleInformation(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatUsageCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [HireIQTheme.primaryNavy, Color(0xFF243659)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seat Usage',
            style: GoogleFonts.inter(
                color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '47 of 50 seats used',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '94% capacity',
                style: GoogleFonts.inter(
                    color: HireIQTheme.primaryTeal,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: 47 / 50,
            backgroundColor: Colors.white.withValues(alpha: 0.1),
            valueColor: const AlwaysStoppedAnimation(
                HireIQTheme.primaryTeal),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 12),
          Text(
            '3 seats remaining for this billing cycle',
            style: GoogleFonts.inter(
                color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        _buildTabItem('All', isSelected: true),
        _buildTabItem('Admins'),
        _buildTabItem('Recruiters'),
      ],
    );
  }

  Widget _buildTabItem(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? HireIQTheme.primaryTeal
            : Colors.transparent,
        borderRadius:
            BorderRadius.circular(HireIQTheme.radiusFull),
        border: isSelected
            ? null
            : Border.all(color: HireIQTheme.borderLight),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color:
              isSelected ? Colors.white : HireIQTheme.textMuted,
          fontWeight: isSelected
              ? FontWeight.w600
              : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildMemberList() {
    final members = [
      {
        'name': 'Nomsa Dlamini',
        'email': 'nomsa.d@enterprise.com',
        'role': 'Admin'
      },
      {
        'name': 'James Wilson',
        'email': 'j.wilson@enterprise.com',
        'role': 'Recruiter'
      },
      {
        'name': 'Sipho Mokoena',
        'email': 'sipho.m@enterprise.com',
        'role': 'Recruiter'
      },
    ];

    return Column(
      children: members.map((m) => _buildMemberTile(m)).toList(),
    );
  }

  Widget _buildMemberTile(Map<String, String> member) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
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
            backgroundColor:
                HireIQTheme.primaryNavy.withValues(alpha: 0.1),
            child: Text(
              member['name']![0],
              style: GoogleFonts.inter(
                  color: HireIQTheme.primaryNavy,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member['name']!,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.textPrimary),
                ),
                Text(
                  member['email']!,
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: HireIQTheme.textMuted),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: HireIQTheme.primaryNavy.withValues(alpha: 0.08),
              borderRadius:
                  BorderRadius.circular(HireIQTheme.radiusFull),
            ),
            child: Text(
              member['role']!,
              style: GoogleFonts.inter(
                  fontSize: 12,
                  color: HireIQTheme.primaryNavy,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_outlined,
                size: 20, color: HireIQTheme.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Roles',
          style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.primaryNavy),
        ),
        const SizedBox(height: 16),
        _buildRoleInfoItem(
          'Admin',
          'Full access to manage billing, team seats, and global settings.',
        ),
        _buildRoleInfoItem(
          'Recruiter',
          'Can post jobs, review candidates, and manage interview schedules.',
        ),
      ],
    );
  }

  Widget _buildRoleInfoItem(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: HireIQTheme.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: GoogleFonts.inter(
                fontSize: 13, color: HireIQTheme.textMuted),
          ),
        ],
      ),
    );
  }
}
