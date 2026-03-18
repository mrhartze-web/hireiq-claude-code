import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';

class AdminRecruiterManagement extends StatelessWidget {
  const AdminRecruiterManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Recruiter Network',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.person_add, color: Colors.white),
              onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildRecruiterTile(
              'Jane Doe', 'Top Tier', 15, 'R450k', HireIQTheme.primaryTeal),
          _buildRecruiterTile(
              'John Smith', 'Standard', 3, 'R60k', HireIQTheme.primaryNavy),
          _buildRecruiterTile(
              'Alice Brown', 'Probation', 0, 'R0', HireIQTheme.warning),
        ],
      ),
    );
  }

  Widget _buildRecruiterTile(String name, String tier, int placements,
      String earnings, Color tierColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
            radius: 24,
            backgroundColor: tierColor.withValues(alpha: 0.1),
            child: Text(
              name[0],
              style: GoogleFonts.inter(
                  color: tierColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
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
                      fontSize: 15,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: tierColor.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: Text(
                    tier,
                    style: GoogleFonts.inter(
                        color: tierColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '$placements Placements',
                      style: GoogleFonts.inter(
                          color: HireIQTheme.textMuted, fontSize: 12),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      'YTD: $earnings',
                      style: GoogleFonts.inter(
                          color: HireIQTheme.primaryNavy,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
              icon: const Icon(Icons.more_vert, color: HireIQTheme.textMuted),
              onPressed: () {}),
        ],
      ),
    );
  }
}
