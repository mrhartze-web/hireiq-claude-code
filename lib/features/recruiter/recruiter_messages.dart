import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class RecruiterMessages extends StatelessWidget {
  const RecruiterMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
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
                Tab(text: 'Clients'),
                Tab(text: 'Candidates'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
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
      color:
          isUnread ? HireIQTheme.primaryTeal.withAlpha(12) : Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: HireIQTheme.primaryTeal.withAlpha(25),
          child: Text(sender[0],
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: HireIQTheme.primaryTeal)),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(sender,
                style: TextStyle(
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                    color: HireIQTheme.primaryNavy)),
            Text(time,
                style: TextStyle(
                    color: isUnread
                        ? HireIQTheme.primaryTeal
                        : HireIQTheme.textMuted,
                    fontSize: 12,
                    fontWeight:
                        isUnread ? FontWeight.bold : FontWeight.normal)),
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
