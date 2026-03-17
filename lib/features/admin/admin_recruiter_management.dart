import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class AdminRecruiterManagement extends StatelessWidget {
  const AdminRecruiterManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Recruiter Network'),
        actions: [
          IconButton(icon: const Icon(Icons.person_add), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildRecruiterTile(
              'Jane Doe', 'Top Tier', 15, 'R450k', HireIQTheme.primaryTeal),
          _buildRecruiterTile(
              'John Smith', 'Standard', 3, 'R60k', HireIQTheme.primaryNavy),
          _buildRecruiterTile(
              'Alice Brown', 'Probation', 0, 'R0', HireIQTheme.warning),
        ],
      ),
    );
  }

  Widget _buildRecruiterTile(String name, String tier, int placements,
      String earnings, Color tierColor) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: HireIQTheme.borderLight)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: tierColor.withAlpha(25),
          child: Text(name[0],
              style: TextStyle(
                  color: tierColor, fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        title: Text(name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                  color: tierColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(tier,
                  style: TextStyle(
                      color: tierColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('$placements Placements',
                    style: const TextStyle(
                        color: HireIQTheme.textMuted, fontSize: 13)),
                const SizedBox(width: 16),
                Text('YTD: $earnings',
                    style: const TextStyle(
                        color: HireIQTheme.primaryNavy,
                        fontWeight: FontWeight.w500,
                        fontSize: 13)),
              ],
            ),
          ],
        ),
        trailing:
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
      ),
    );
  }
}
