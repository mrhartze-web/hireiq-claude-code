import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class CandidateNotifications extends StatelessWidget {
  const CandidateNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Mark all as read'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _buildDayHeader('Today'),
          _buildNotification(
            context,
            'MatchIQ Match',
            'You matched 92% for the Senior Developer role at Apex Digital.',
            Icons.auto_awesome,
            HireIQTheme.primaryTeal,
            isUnread: true,
          ),
          _buildNotification(
            context,
            'Application Viewed',
            'FinTech Startup has viewed your application for Backend Engineer.',
            Icons.visibility_outlined,
            HireIQTheme.primaryNavy,
            isUnread: true,
          ),
          _buildDayHeader('Earlier'),
          _buildNotification(
            context,
            'Profile Update Recommended',
            'Update your career goals to get better MatchIQ recommendations.',
            Icons.engineering_outlined,
            HireIQTheme.warning,
          ),
          _buildNotification(
            context,
            'System Message',
            'Welcome to HireIQ! Complete your PassportIQ to start applying.',
            Icons.message_outlined,
            HireIQTheme.textMuted,
          ),
        ],
      ),
    );
  }

  Widget _buildDayHeader(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: HireIQTheme.textMuted,
            fontSize: 13),
      ),
    );
  }

  Widget _buildNotification(
    BuildContext context,
    String title,
    String body,
    IconData icon,
    Color color, {
    bool isUnread = false,
  }) {
    return Container(
      color:
          isUnread ? HireIQTheme.primaryTeal.withAlpha(12) : Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: color.withAlpha(25), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontWeight:
                                isUnread ? FontWeight.bold : FontWeight.w600,
                            fontSize: 16,
                            color: HireIQTheme.primaryNavy)),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                            color: HireIQTheme.primaryTeal,
                            shape: BoxShape.circle),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(body,
                    style: const TextStyle(
                        color: HireIQTheme.textMuted, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
