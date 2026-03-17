import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class EmployerDashboardScreen extends StatefulWidget {
  const EmployerDashboardScreen({super.key});

  @override
  State<EmployerDashboardScreen> createState() =>
      _EmployerDashboardScreenState();
}

class _EmployerDashboardScreenState extends State<EmployerDashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildStatsRow(),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Shortlist',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: HireIQColors.navy),
                  ),
                  TextButton(
                    onPressed: () => context.push('/shortlist-view'),
                    child: const Text('View All',
                        style: TextStyle(color: HireIQColors.teal)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildCandidateCard('Alex Rivera', 'Senior Product Designer',
                  '92%', 'https://i.pravatar.cc/150?u=alex'),
              _buildCandidateCard('Elena Soph', 'Lead UX Researcher', '88%',
                  'https://i.pravatar.cc/150?u=elena'),
              _buildCandidateCard('Marcus Chen', 'Fullstack Engineer', '85%',
                  'https://i.pravatar.cc/150?u=marcus'),
              const SizedBox(height: 32),
              _buildActionCard(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          // Standard employer nav: Dashboard, Jobs, Candidates, Settings
          if (index == 1) context.push('/post-job');
          if (index == 2) context.push('/cv-vault');
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: HireIQColors.teal,
        unselectedItemColor: HireIQColors.textMuted,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.work_rounded), label: 'Jobs'),
          BottomNavigationBarItem(
              icon: Icon(Icons.group_rounded), label: 'Candidates'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: TextStyle(color: HireIQColors.textMuted, fontSize: 14),
                ),
                Text(
                  'Sarah Jenkins',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: HireIQColors.navy),
                ),
              ],
            ),
            CircleAvatar(
              radius: 24,
              backgroundImage:
                  NetworkImage('https://i.pravatar.cc/100?u=sarah_recruiter'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
            child: _buildStatCard('12', 'Active Jobs',
                Icons.work_outline_rounded, HireIQColors.teal)),
        const SizedBox(width: 16),
        Expanded(
            child: _buildStatCard('48', 'Shortlisted',
                Icons.people_outline_rounded, Colors.orange)),
        const SizedBox(width: 16),
        Expanded(
            child: _buildStatCard('5', 'Placements',
                Icons.verified_user_outlined, Colors.blueAccent)),
      ],
    );
  }

  Widget _buildStatCard(
      String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: HireIQColors.silver),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: HireIQColors.navy),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: HireIQColors.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildCandidateCard(
      String name, String role, String score, String avatarUrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: HireIQColors.silver),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(avatarUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: HireIQColors.navy),
                ),
                Text(
                  role,
                  style: const TextStyle(
                      color: HireIQColors.textMuted, fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: HireIQColors.teal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              score,
              style: const TextStyle(
                  color: HireIQColors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQColors.navy,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Need to hire fast?',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Use our AI Brief Upload to shortlist top candidates in seconds.',
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7), fontSize: 14),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.push('/brief-upload'),
            style: ElevatedButton.styleFrom(
              backgroundColor: HireIQColors.teal,
              foregroundColor: Colors.white,
            ),
            child: const Text('New AI Placement'),
          ),
        ],
      ),
    );
  }
}
