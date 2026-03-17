import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class EmployerTeamManagement extends StatelessWidget {
  const EmployerTeamManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Team Management'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.person_add_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSeatUsageCard(),
            const SizedBox(height: 32),
            _buildTabs(),
            const SizedBox(height: 24),
            _buildMemberList(),
            const SizedBox(height: 40),
            _buildRoleInformation(),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatUsageCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.primaryNavy,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Seat Usage',
              style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('47 of 50 seats used',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text('94% capacity',
                  style: TextStyle(
                      color: HireIQTheme.primaryTeal,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: 47 / 50,
            backgroundColor: Colors.white10,
            valueColor: const AlwaysStoppedAnimation(HireIQTheme.primaryTeal),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 12),
          const Text('3 seats remaining for this billing cycle',
              style: TextStyle(color: Colors.white70, fontSize: 12)),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? HireIQTheme.primaryTeal : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? null : Border.all(color: HireIQTheme.borderLight),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : HireIQTheme.textMuted,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: HireIQTheme.primaryNavy.withAlpha(25),
            child: Text(member['name']![0],
                style: const TextStyle(
                    color: HireIQTheme.primaryNavy,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(member['name']!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy)),
                Text(member['email']!,
                    style: const TextStyle(
                        fontSize: 12, color: HireIQTheme.textMuted)),
              ],
            ),
          ),
          Text(member['role']!,
              style:
                  const TextStyle(fontSize: 12, color: HireIQTheme.textMuted)),
          const SizedBox(width: 8),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert_outlined, size: 20)),
        ],
      ),
    );
  }

  Widget _buildRoleInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('About Roles',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy)),
        const SizedBox(height: 16),
        _buildRoleInfoItem('Admin',
            'Full access to manage billing, team seats, and global settings.'),
        _buildRoleInfoItem('Recruiter',
            'Can post jobs, review candidates, and manage interview schedules.'),
      ],
    );
  }

  Widget _buildRoleInfoItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(description,
              style:
                  const TextStyle(fontSize: 12, color: HireIQTheme.textMuted)),
        ],
      ),
    );
  }
}
