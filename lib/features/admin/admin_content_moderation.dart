import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class AdminContentModeration extends StatelessWidget {
  const AdminContentModeration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Content Moderation'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              labelColor: HireIQTheme.primaryNavy,
              unselectedLabelColor: HireIQTheme.textMuted,
              indicatorColor: HireIQTheme.primaryNavy,
              tabs: [
                Tab(text: 'Flagged Job Posts'),
                Tab(text: 'Flagged User Profiles'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      _buildFlaggedItem(
                          'Apex Digital',
                          'Job Post: "Software Engineer (H1B Only)"',
                          'Flagged for discriminatory language (H1B Only)',
                          '2h ago'),
                      _buildFlaggedItem(
                          'FinTech Startup',
                          'Job Post: "Earn R1m/day working from home!"',
                          'Flagged as potential spam/scam',
                          '4h ago'),
                    ],
                  ),
                  ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      _buildFlaggedItem(
                          'User: JohnDoe123',
                          'Profile Verification Failed',
                          'PassportIQ image check failed (blurry ID)',
                          'Yesterday'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlaggedItem(
      String entity, String context, String reason, String time) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: HireIQTheme.borderLight)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(entity,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy)),
                Text(time,
                    style: const TextStyle(
                        color: HireIQTheme.textMuted, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            Text(context,
                style: const TextStyle(
                    color: HireIQTheme.primaryNavy,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                  color: HireIQTheme.error.withAlpha(25),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: HireIQTheme.error, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text(reason,
                          style: const TextStyle(
                              color: HireIQTheme.error, fontSize: 13))),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      foregroundColor: HireIQTheme.textMuted),
                  child: const Text('Dismiss'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HireIQTheme.error,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Take Action'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
