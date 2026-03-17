import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class RecruiterDashboard extends StatelessWidget {
  const RecruiterDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('bolt HireIQ',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=riya'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back, Riya',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const Text(
              'Here\'s your performance overview for today.',
              style: TextStyle(color: HireIQTheme.textMuted),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.borderLight),
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
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy)),
              Text(label,
                  style: const TextStyle(
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
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy)),
        TextButton(onPressed: () {}, child: const Text('View All')),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(
            context, 'New Brief', Icons.add_box, HireIQTheme.primaryTeal),
        _buildActionButton(context, 'Search', Icons.search, Colors.orange),
        _buildActionButton(context, 'Signals', Icons.bolt, Colors.purple),
        _buildActionButton(context, 'Report', Icons.bar_chart, Colors.blue),
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
            color: color.withAlpha(25),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildCandidateCard(
      String name, String subtitle, String status, IconData statusIcon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: HireIQTheme.primaryTeal.withAlpha(25),
            child: Text(name[0],
                style: const TextStyle(
                    color: HireIQTheme.primaryTeal,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle,
                    style: const TextStyle(
                        color: HireIQTheme.textMuted, fontSize: 13)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(statusIcon, size: 14, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(status,
                        style: const TextStyle(
                            color: Colors.orange,
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
