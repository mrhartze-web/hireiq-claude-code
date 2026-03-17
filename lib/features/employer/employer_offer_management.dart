import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class EmployerOfferManagement extends StatelessWidget {
  const EmployerOfferManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Offer Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Active Offers',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 16),
                  _buildOfferCard('Senior Backend Engineer', 'Alex T.',
                      'R900k/yr', 'Pending Candidate', HireIQTheme.warning),
                  _buildOfferCard('Product Designer', 'Sarah M.', 'R750k/yr',
                      'Accepted', HireIQTheme.primaryTeal),
                  const SizedBox(height: 32),
                  const Text('Draft Offers',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HireIQTheme.textMuted)),
                  const SizedBox(height: 16),
                  _buildOfferCard('Frontend Developer', 'Michael B.',
                      'R600k/yr', 'Draft', HireIQTheme.textMuted),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard(String role, String candidate, String salary,
      String status, Color statusColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(role,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Candidate: $candidate',
                style: const TextStyle(color: HireIQTheme.textMuted)),
            const SizedBox(height: 2),
            Text('Offer: $salary',
                style: const TextStyle(
                    color: HireIQTheme.primaryNavy,
                    fontWeight: FontWeight.w500)),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
              color: statusColor.withAlpha(25),
              borderRadius: BorderRadius.circular(8)),
          child: Text(status,
              style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
        ),
        onTap: () {},
      ),
    );
  }
}
