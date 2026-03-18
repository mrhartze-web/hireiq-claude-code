import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
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
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Messages',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white),
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
    final bool isUnread = chat['unread'] != '0';
    return InkWell(
      onTap: () => context.push('/messages/${chat['id']}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor:
                      HireIQTheme.primaryNavy.withValues(alpha: 0.1),
                  child: Text(
                    chat['name']![0],
                    style: GoogleFonts.inter(
                      color: HireIQTheme.primaryNavy,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat['name']!,
                        style: GoogleFonts.inter(
                          fontWeight:
                              isUnread ? FontWeight.bold : FontWeight.w600,
                          fontSize: 15,
                          color: HireIQTheme.primaryNavy,
                        ),
                      ),
                      Text(
                        chat['time']!,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: isUnread
                              ? HireIQTheme.primaryTeal
                              : HireIQTheme.textMuted,
                          fontWeight: isUnread
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat['message']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: isUnread
                          ? HireIQTheme.textPrimary
                          : HireIQTheme.textMuted,
                      fontWeight:
                          isUnread ? FontWeight.w500 : FontWeight.normal,
                    ),
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
