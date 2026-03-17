import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class RecruiterPipeline extends StatelessWidget {
  const RecruiterPipeline({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Recruit Pipeline'),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: HireIQTheme.primaryTeal,
            labelColor: HireIQTheme.primaryNavy,
            unselectedLabelColor: HireIQTheme.textMuted,
            tabs: [
              Tab(text: 'Screening (15)'),
              Tab(text: 'Interview (8)'),
              Tab(text: 'Offer (3)'),
              Tab(text: 'Hired (42)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPipelineList(),
            _buildPipelineList(),
            _buildPipelineList(),
            _buildPipelineList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPipelineList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildCandidateTile('Sarah Jenkins', 'Senior Developer', '8 min ago'),
        _buildCandidateTile('Michael Chen', 'Product Manager', '2 hours ago'),
        _buildCandidateTile('Emma Wilson', 'UX Designer', 'Yesterday'),
        _buildCandidateTile('David Miller', 'Cloud Specialist', '2 days ago'),
      ],
    );
  }

  Widget _buildCandidateTile(String name, String role, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: HireIQTheme.primaryTeal.withAlpha(25),
          child: Text(name[0],
              style: const TextStyle(
                  color: HireIQTheme.primaryTeal, fontWeight: FontWeight.bold)),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(role),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Icon(Icons.arrow_forward_ios,
                size: 14, color: HireIQTheme.textMuted),
            const SizedBox(height: 4),
            Text(time,
                style: const TextStyle(
                    fontSize: 10, color: HireIQTheme.textMuted)),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
