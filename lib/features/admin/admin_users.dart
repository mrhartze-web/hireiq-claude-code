import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class AdminUsersManagement extends StatelessWidget {
  const AdminUsersManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: HireIQTheme.surfaceWhite,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search users by name or email...',
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildUserTile(
                    'Alice Cooper', 'alice@company.com', 'Employer', 'Active'),
                _buildUserTile(
                    'Bob Wilson', 'bob@gmail.com', 'Candidate', 'Active'),
                _buildUserTile('Charlie Brown', 'charlie@recruits.io',
                    'Recruiter', 'Suspended'),
                _buildUserTile(
                    'Diana Ross', 'diana@admin.hireiq', 'Admin', 'Active'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTile(String name, String email, String role, String status) {
    final bool isActive = status == 'Active';

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: HireIQTheme.primaryNavy.withAlpha(25),
        child: Text(name[0],
            style: const TextStyle(color: HireIQTheme.primaryNavy)),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(email, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Row(
            children: [
              _buildBadge(role, HireIQTheme.primaryNavy),
              const SizedBox(width: 8),
              _buildBadge(status,
                  isActive ? HireIQTheme.primaryTeal : HireIQTheme.error),
            ],
          ),
        ],
      ),
      trailing: const Icon(Icons.more_vert),
      isThreeLine: true,
      onTap: () {},
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style:
            TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
