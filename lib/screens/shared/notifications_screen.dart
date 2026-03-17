import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/job-feed'),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Clear all',
                style: TextStyle(color: HireIQColors.teal)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        children: [
          _buildSectionHeader('Today'),
          _buildNotificationItem(
            context,
            'New Interview Request',
            'TechCorp wants to interview you for Senior Designer position. Choose a slot.',
            '2h ago',
            Icons.calendar_today_rounded,
            HireIQColors.teal,
            isNew: true,
          ),
          _buildNotificationItem(
            context,
            'Application Viewed',
            'Global Solutions viewed your Product Manager application.',
            '5h ago',
            Icons.remove_red_eye_outlined,
            Colors.blueAccent,
            isNew: true,
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('Earlier'),
          _buildNotificationItem(
            context,
            'New Message',
            'Sarah from Recruiting: "Hi! We\'ve reviewed your portfolio and would love..."',
            'Yesterday',
            Icons.chat_bubble_outline_rounded,
            Colors.purpleAccent,
          ),
          _buildNotificationItem(
            context,
            'Job Match',
            'A new UX Lead position matches your profile in San Francisco.',
            'Oct 12',
            Icons.stars_rounded,
            Colors.amber,
          ),
          _buildNotificationItem(
            context,
            'Profile Tip',
            'Users with a profile photo get 3x more recruiter views. Add one now!',
            'Oct 10',
            Icons.lightbulb_outline_rounded,
            HireIQColors.teal,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: HireIQColors.navy),
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    String title,
    String body,
    String time,
    IconData icon,
    Color color, {
    bool isNew = false,
  }) {
    return GestureDetector(
      onTap: () => context.go('/application-detail'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isNew ? color.withValues(alpha: 0.05) : HireIQColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color:
                  isNew ? color.withValues(alpha: 0.2) : HireIQColors.silver),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isNew ? Colors.white : HireIQColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
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
                      Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: HireIQColors.navy),
                      ),
                      if (isNew)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                              color: HireIQColors.teal, shape: BoxShape.circle),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: const TextStyle(
                        color: HireIQColors.textMuted,
                        fontSize: 13,
                        height: 1.5),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    time,
                    style: TextStyle(
                        color: HireIQColors.textMuted.withValues(alpha: 0.6),
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
