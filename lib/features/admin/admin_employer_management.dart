import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class AdminEmployerManagement extends StatelessWidget {
  const AdminEmployerManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Employer Accounts'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildEmployerTile(
              'Apex Digital', 'Verified', 5, HireIQTheme.primaryTeal),
          _buildEmployerTile('FinTech Startup', 'Pending Verification', 1,
              HireIQTheme.warning),
          _buildEmployerTile(
              'Global Logistics Ltd', 'Suspended', 0, HireIQTheme.error),
          _buildEmployerTile(
              'Cyberdyne Systems', 'Verified', 12, HireIQTheme.primaryTeal),
        ],
      ),
    );
  }

  Widget _buildEmployerTile(
      String name, String status, int activeJobs, Color statusColor) {
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
          child: const Icon(Icons.business, color: HireIQTheme.primaryNavy),
        ),
        title: Text(name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration:
                      BoxDecoration(color: statusColor, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Text(status,
                    style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
              ],
            ),
            const SizedBox(height: 8),
            Text('$activeJobs Active Listings',
                style: const TextStyle(
                    color: HireIQTheme.textMuted, fontSize: 13)),
          ],
        ),
        trailing:
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
      ),
    );
  }
}
