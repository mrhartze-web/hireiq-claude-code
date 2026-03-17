import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class RecruiterClientManagement extends StatelessWidget {
  const RecruiterClientManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('My Clients'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildClientCard('Apex Digital', 'Technology', 2),
          _buildClientCard('FinTech Startup', 'Finance', 1),
          _buildClientCard('Global Logistics Ltd', 'Logistics', 0),
        ],
      ),
    );
  }

  Widget _buildClientCard(String name, String industry, int activeRoles) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: HireIQTheme.borderLight)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: HireIQTheme.primaryNavy.withAlpha(12),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: HireIQTheme.borderLight),
          ),
          child: const Icon(Icons.business, color: HireIQTheme.primaryTeal),
        ),
        title: Text(name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(industry,
                style: const TextStyle(color: HireIQTheme.textMuted)),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.work_outline,
                    color: activeRoles > 0
                        ? HireIQTheme.primaryTeal
                        : HireIQTheme.textMuted,
                    size: 16),
                const SizedBox(width: 4),
                Text('$activeRoles Active Briefs',
                    style: TextStyle(
                        color: activeRoles > 0
                            ? HireIQTheme.primaryTeal
                            : HireIQTheme.textMuted,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 16, color: HireIQTheme.textMuted),
        onTap: () {},
      ),
    );
  }
}
