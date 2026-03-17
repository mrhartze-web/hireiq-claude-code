import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class CandidateMessagesInbox extends StatelessWidget {
  const CandidateMessagesInbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildMessageTile(
            context,
            'Apex Digital',
            'Sarah from Apex Digital: Are you available for a quick chat tomorrow?',
            '2m ago',
            true,
          ),
          _buildMessageTile(
            context,
            'FinTech Startup',
            'We were impressed by your MatchIQ fit. When can we schedule...',
            '1h ago',
            true,
          ),
          _buildMessageTile(
            context,
            'HireIQ Support',
            'Your PassportIQ verification was successful! Your profile is now live.',
            'Yesterday',
            false,
            isSystemMsg: true,
          ),
          _buildMessageTile(
            context,
            'Cyberdyne Systems',
            'Thank you for your application, however we have decided to move forward...',
            '2 days ago',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildMessageTile(
    BuildContext context,
    String sender,
    String preview,
    String time,
    bool isUnread, {
    bool isSystemMsg = false,
  }) {
    return Container(
      color:
          isUnread ? HireIQTheme.primaryTeal.withAlpha(12) : Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: isSystemMsg
              ? HireIQTheme.primaryNavy
              : HireIQTheme.primaryTeal.withAlpha(25),
          child: isSystemMsg
              ? const Icon(Icons.support_agent, color: Colors.white)
              : Text(sender[0],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryTeal)),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sender,
              style: TextStyle(
                  fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                  color: HireIQTheme.primaryNavy),
            ),
            Text(
              time,
              style: TextStyle(
                  color: isUnread
                      ? HireIQTheme.primaryTeal
                      : HireIQTheme.textMuted,
                  fontSize: 12,
                  fontWeight: isUnread ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            preview,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color:
                    isUnread ? HireIQTheme.primaryNavy : HireIQTheme.textMuted,
                height: 1.4,
                fontWeight: isUnread ? FontWeight.w500 : FontWeight.normal),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
