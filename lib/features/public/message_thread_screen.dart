import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class MessageThreadScreen extends StatelessWidget {
  final String chatId;
  const MessageThreadScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: HireIQTheme.primaryNavy.withAlpha(25),
              child: const Text('A',
                  style: TextStyle(
                      color: HireIQTheme.primaryNavy,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Apex Digital',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Text('Online',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: HireIQTheme.success,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.videocam_outlined,
                  color: HireIQTheme.primaryNavy)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.info_outline,
                  color: HireIQTheme.primaryNavy)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDateTag('Thursday, 12 March'),
                _buildMessage(
                  context,
                  'Hi Thabo! Thanks for applying for the position. We reviewed your profile and were very impressed with your assessment score of 94. Great to see a PassportIQ verified profile.',
                  false,
                  '10:00 AM',
                ),
                _buildMessage(
                  context,
                  "We'd like to invite you for a technical interview with our engineering lead.",
                  false,
                  '10:01 AM',
                ),
                _buildMessage(
                  context,
                  'Hi! Thank you so much for the opportunity. Thursday at 10am works perfectly for me.',
                  true,
                  '10:05 AM',
                ),
                _buildMessage(
                  context,
                  "Great! I'll send the Google Meet link shortly. Looking forward to chatting! 🎉",
                  false,
                  '10:06 AM',
                ),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildDateTag(String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: HireIQTheme.borderLight.withAlpha(127),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            date,
            style: const TextStyle(
                fontSize: 12,
                color: HireIQTheme.textMuted,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(
      BuildContext context, String text, bool isMe, String time) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isMe ? HireIQTheme.primaryNavy : HireIQTheme.surfaceWhite,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 16),
          ),
          boxShadow: [
            if (!isMe)
              BoxShadow(
                color: Colors.black.withAlpha(12),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isMe ? Colors.white : HireIQTheme.textPrimary,
                fontSize: 15,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                color: isMe ? Colors.white70 : HireIQTheme.textMuted,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        border: Border(top: BorderSide(color: HireIQTheme.borderLight)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add, color: HireIQTheme.textMuted)),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: HireIQTheme.background,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: HireIQTheme.textMuted),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: const BoxDecoration(
                color: HireIQTheme.primaryTeal,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
