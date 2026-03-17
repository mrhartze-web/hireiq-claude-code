import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(onPressed: () {}, child: const Text('Mark all as read')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _buildDayHeader('Today'),
          _buildNotification(
            context,
            'MatchIQ matched you!',
            'New Flutter Dev role at Apex Digital matches 98% of your profile.',
            Icons.auto_awesome,
            HireIQTheme.primaryTeal,
            isUnread: true,
          ),
          _buildNotification(
            context,
            'Interview Scheduled',
            'Synergy Labs has invited you to an interview tomorrow at 10:00 AM.',
            Icons.calendar_today_outlined,
            HireIQTheme.amber,
            isUnread: true,
          ),
          _buildDayHeader('Yesterday'),
          _buildNotification(
            context,
            'Profile Viewed',
            'A recruiter from M-Pesa Africa viewed your profile.',
            Icons.visibility_outlined,
            HireIQTheme.primaryNavy,
          ),
          _buildNotification(
            context,
            'System Update',
            'HireIQ v2.1 is now live with enhanced SkillIQ verification.',
            Icons.system_update_alt,
            HireIQTheme.textMuted,
          ),
        ],
      ),
    );
  }

  Widget _buildDayHeader(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        label,
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
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: color.withAlpha(25), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
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
                                isUnread ? FontWeight.bold : FontWeight.w600)),
                    if (isUnread)
                      Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                              color: HireIQTheme.primaryTeal,
                              shape: BoxShape.circle)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(body,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
