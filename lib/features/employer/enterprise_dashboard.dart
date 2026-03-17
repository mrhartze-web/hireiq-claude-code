import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class EnterpriseDashboard extends StatelessWidget {
  const EnterpriseDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Enterprise Hub'),
        backgroundColor: HireIQTheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeHeader(),
            const SizedBox(height: 25),
            _buildQuickInsights(),
            const SizedBox(height: 30),
            _buildActiveRoles(),
            const SizedBox(height: 30),
            _buildTeamActivity(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('FinCorp South Africa',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.textSecondary)),
        Text('Hiring Performance', style: HireIQTheme.titleStyle),
      ],
    );
  }

  Widget _buildQuickInsights() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.primary.withAlpha(25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.primary.withAlpha(76)),
      ),
      child: Row(
        children: [
          const Icon(Icons.analytics_outlined,
              color: HireIQTheme.primary, size: 32),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('SignalIQ Report Ready',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  'Q3 Enterprise Hiring Insights are ready for review.',
                  style: HireIQTheme.bodyStyle
                      .copyWith(fontSize: 12, color: HireIQTheme.textSecondary),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: HireIQTheme.primary),
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
            Text('Active Roles', style: HireIQTheme.subtitleStyle),
            TextButton(onPressed: () {}, child: const Text('See all')),
          ],
        ),
        const SizedBox(height: 10),
        _buildRoleCard('Head of Engineering', 'Johannesburg • Remote', '42'),
        _buildRoleCard('Senior Data Scientist', 'Cape Town • Hybrid', '18'),
        _buildRoleCard('Flutter Developer', 'Durban • Full-time', '65'),
      ],
    );
  }

  Widget _buildRoleCard(String title, String location, String appCount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: HireIQTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(location,
                    style: const TextStyle(
                        fontSize: 12, color: HireIQTheme.textSecondary)),
              ],
            ),
          ),
          Column(
            children: [
              Text(appCount,
                  style: HireIQTheme.subtitleStyle
                      .copyWith(color: HireIQTheme.primary)),
              const Text('Apps',
                  style: TextStyle(
                      fontSize: 10, color: HireIQTheme.textSecondary)),
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
        Text('Team Activity', style: HireIQTheme.subtitleStyle),
        const SizedBox(height: 15),
        _buildActivityItem(
            'Sarah M. shortlisted 3 candidates for Head of Eng.'),
        _buildActivityItem('David K. moved an offer to Approved state.'),
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
                color: HireIQTheme.border, shape: BoxShape.circle),
            child: const Icon(Icons.history,
                size: 16, color: HireIQTheme.textSecondary),
          ),
          const SizedBox(width: 15),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
