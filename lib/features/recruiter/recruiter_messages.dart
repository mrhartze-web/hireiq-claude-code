import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';

class RecruiterMessages extends StatelessWidget {
  const RecruiterMessages({super.key});

  @override
  Widget build(BuildContext context) {
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
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {}),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: HireIQTheme.surfaceWhite,
              child: TabBar(
                labelColor: HireIQTheme.primaryNavy,
                unselectedLabelColor: HireIQTheme.textMuted,
                indicatorColor: HireIQTheme.primaryTeal,
                indicatorWeight: 3,
                labelStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 14),
                unselectedLabelStyle:
                    GoogleFonts.inter(fontSize: 14),
                tabs: const [
                  Tab(text: 'Clients'),
                  Tab(text: 'Candidates'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      _buildMessageTile(
                          'Apex Digital (John)',
                          'Are we still on track to receive 3 candidate submissions by tomorrow?',
                          '10m ago',
                          true),
                      _buildMessageTile(
                          'FinTech Startup (Sarah)',
                          'Thanks for the brief update. Looks perfect.',
                          '1h ago',
                          false),
                    ],
                  ),
                  ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      _buildMessageTile(
                          'Alice Johnson',
                          'Yes, I am available for an interview on Wednesday.',
                          '2m ago',
                          true),
                      _buildMessageTile(
                          'Bob Smith',
                          'What is the salary range for the role at FinTech Startup?',
                          'Yesterday',
                          false),
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

  Widget _buildMessageTile(
      String sender, String preview, String time, bool isUnread) {
    return Container(
      color: isUnread
          ? HireIQTheme.primaryTeal.withValues(alpha: 0.05)
          : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
            child: Text(
              sender[0],
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryTeal),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        sender,
                        style: GoogleFonts.inter(
                            fontWeight: isUnread
                                ? FontWeight.bold
                                : FontWeight.w600,
                            color: HireIQTheme.primaryNavy,
                            fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.inter(
                          color: isUnread
                              ? HireIQTheme.primaryTeal
                              : HireIQTheme.textMuted,
                          fontSize: 12,
                          fontWeight: isUnread
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  preview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                      color: isUnread
                          ? HireIQTheme.textPrimary
                          : HireIQTheme.textMuted,
                      fontSize: 13,
                      height: 1.4,
                      fontWeight: isUnread
                          ? FontWeight.w500
                          : FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
