import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class RecruiterDashboardScreen extends StatefulWidget {
  const RecruiterDashboardScreen({super.key});

  @override
  State<RecruiterDashboardScreen> createState() =>
      _RecruiterDashboardScreenState();
}

class _RecruiterDashboardScreenState extends State<RecruiterDashboardScreen> {
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
              _buildStatsGrid(),
              const SizedBox(height: 32),
              const Text(
                'Active Pipeline',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HireIQColors.navy),
              ),
              const SizedBox(height: 16),
              _buildProjectItem(
                  'Frontend Lead', 'Google', '12 Matches', '78% Avg'),
              _buildProjectItem(
                  'Product Designer', 'Stripe', '5 Matches', '91% Avg'),
              _buildProjectItem('Lead HR', 'Airbnb', '8 Matches', '65% Avg'),
              const SizedBox(height: 32),
              _buildQuickActions(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 1) context.push('/crm-pipeline');
          if (index == 2) context.push('/cv-vault');
          if (index == 3) context.go('/notifications');
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: HireIQColors.teal,
        unselectedItemColor: HireIQColors.textMuted,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_customize_rounded),
              label: 'Dashboard'),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_kanban_rounded), label: 'Pipeline'),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder_shared_rounded), label: 'Vault'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_rounded), label: 'Messages'),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recruiter Pro',
                style: TextStyle(
                    color: HireIQColors.teal,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
            Text('SARAH JENKINS',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: HireIQColors.navy)),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded,
              color: HireIQColors.navy),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _statBox('24', 'Active Searches', Icons.search_rounded),
        _statBox('12', 'Shortlisted', Icons.star_border_rounded),
        _statBox('8', 'Interviewing', Icons.record_voice_over_rounded),
        _statBox('96%', 'Match Accuracy', Icons.auto_awesome_rounded),
      ],
    );
  }

  Widget _statBox(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: HireIQColors.teal, size: 20),
          const Spacer(),
          Text(value,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: HireIQColors.navy)),
          Text(label,
              style:
                  const TextStyle(fontSize: 11, color: HireIQColors.textMuted)),
        ],
      ),
    );
  }

  Widget _buildProjectItem(
      String role, String company, String candidates, String score) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: HireIQColors.silver),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(role,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: HireIQColors.navy)),
                Text('$company • $candidates',
                    style: const TextStyle(
                        color: HireIQColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
          Text(score,
              style: const TextStyle(
                  fontWeight: FontWeight.w900, color: HireIQColors.teal)),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => context.push('/brief-upload'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                  color: HireIQColors.navy,
                  borderRadius: BorderRadius.circular(20)),
              child: const Column(
                children: [
                  Icon(Icons.upload_file_rounded, color: Colors.white),
                  SizedBox(height: 8),
                  Text('Upload Brief',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: InkWell(
            onTap: () => context.push('/cv-vault'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                  color: HireIQColors.teal,
                  borderRadius: BorderRadius.circular(20)),
              child: const Column(
                children: [
                  Icon(Icons.people_alt_rounded, color: Colors.white),
                  SizedBox(height: 8),
                  Text('Source Talent',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
