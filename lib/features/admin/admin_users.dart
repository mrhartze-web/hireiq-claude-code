import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class AdminUsersManagement extends StatelessWidget {
  const AdminUsersManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'User Management',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: HireIQTheme.background,
            child: Container(
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(color: HireIQTheme.borderLight),
                boxShadow: [
                  BoxShadow(
                    color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                style: GoogleFonts.inter(
                    fontSize: 14, color: HireIQTheme.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search users by name or email...',
                  hintStyle: GoogleFonts.inter(
                      color: HireIQTheme.textMuted, fontSize: 14),
                  prefixIcon: const Icon(Icons.search,
                      color: HireIQTheme.primaryNavy),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                    borderSide: const BorderSide(
                        color: HireIQTheme.primaryTeal, width: 1.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
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

  Widget _buildUserTile(
      String name, String email, String role, String status) {
    final bool isActive = status == 'Active';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: HireIQTheme.primaryNavy.withValues(alpha: 0.1),
            child: Text(
              name[0],
              style: GoogleFonts.inter(
                  color: HireIQTheme.primaryNavy, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 2),
                Text(
                  email,
                  style: GoogleFonts.inter(
                      fontSize: 12, color: HireIQTheme.textMuted),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildBadge(role, HireIQTheme.primaryNavy),
                    const SizedBox(width: 8),
                    _buildBadge(
                        status,
                        isActive
                            ? HireIQTheme.primaryTeal
                            : HireIQTheme.error),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.more_vert, color: HireIQTheme.textMuted),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
            color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}
