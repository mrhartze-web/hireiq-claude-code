import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class MessageThreadScreen extends StatelessWidget {
  final String chatId;
  const MessageThreadScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white.withValues(alpha: 0.15),
              child: Text(
                'A',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Apex Digital',
                  style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  'Online',
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      color: HireIQTheme.primaryTeal,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.videocam_outlined, color: Colors.white)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.info_outline, color: Colors.white)),
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
                  "Great! I'll send the Google Meet link shortly. Looking forward to chatting!",
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
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: HireIQTheme.borderLight.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
          ),
          child: Text(
            date,
            style: GoogleFonts.inter(
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
                color: HireIQTheme.primaryNavy.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: GoogleFonts.inter(
                color: isMe ? Colors.white : HireIQTheme.textPrimary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: GoogleFonts.inter(
                color: isMe
                    ? Colors.white.withValues(alpha: 0.6)
                    : HireIQTheme.textMuted,
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
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                  border: Border.all(color: HireIQTheme.borderLight),
                ),
                child: TextField(
                  style: GoogleFonts.inter(
                      fontSize: 14, color: HireIQTheme.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.inter(
                        color: HireIQTheme.textMuted, fontSize: 14),
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
