import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> chats = [
      {
        'id': '1',
        'name': 'Apex Digital',
        'message': 'Re: Senior Flutter Developer...',
        'time': '10:45 AM',
        'unread': '1',
      },
      {
        'id': '2',
        'name': 'Sarah Recruiter',
        'message': 'Great news about your profile!',
        'time': 'Yesterday',
        'unread': '0',
      },
      {
        'id': '3',
        'name': 'FinServ Now',
        'message': 'Thanks for your application...',
        'time': 'Mon',
        'unread': '0',
      },
      {
        'id': '4',
        'name': 'TalentHub Recruiter',
        'message': 'Your profile was shortlisted for the role...',
        'time': '2 Mar',
        'unread': '0',
      },
      {
        'id': '5',
        'name': 'WorkCorp SA',
        'message': 'Hello! Your gig has been accepted...',
        'time': '1 Mar',
        'unread': '0',
      },
    ];

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: HireIQTheme.primaryNavy),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: HireIQTheme.primaryNavy),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: chats.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          indent: 80,
          color: HireIQTheme.borderLight,
        ),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return _buildChatTile(context, chat);
        },
      ),
    );
  }

  Widget _buildChatTile(BuildContext context, Map<String, String> chat) {
    bool isUnread = chat['unread'] != '0';
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: HireIQTheme.primaryNavy.withAlpha(25),
            child: Text(
              chat['name']![0],
              style: const TextStyle(
                color: HireIQTheme.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          if (isUnread)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: HireIQTheme.success,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            chat['name']!,
            style: TextStyle(
              fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
              fontSize: 16,
              color: HireIQTheme.textPrimary,
            ),
          ),
          Text(
            chat['time']!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isUnread
                      ? HireIQTheme.primaryTeal
                      : HireIQTheme.textMuted,
                  fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          chat['message']!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color:
                    isUnread ? HireIQTheme.textPrimary : HireIQTheme.textMuted,
                fontWeight: isUnread ? FontWeight.w500 : FontWeight.normal,
              ),
        ),
      ),
      onTap: () {
        // Use the constant if it existed, but since we are updating it:
        context.push('/messages/${chat['id']}');
      },
    );
  }
}
