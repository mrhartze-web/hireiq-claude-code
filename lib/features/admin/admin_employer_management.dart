import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';

class AdminEmployerManagement extends StatelessWidget {
  const AdminEmployerManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Employer Accounts',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildEmployerTile(
              'Apex Digital', 'Verified', 5, HireIQTheme.primaryTeal),
          _buildEmployerTile('FinTech Startup', 'Pending Verification', 1,
              HireIQTheme.warning),
          _buildEmployerTile(
              'Global Logistics Ltd', 'Suspended', 0, HireIQTheme.error),
          _buildEmployerTile(
              'Cyberdyne Systems', 'Verified', 12, HireIQTheme.primaryTeal),
        ],
      ),
    );
  }

  Widget _buildEmployerTile(
      String name, String status, int activeJobs, Color statusColor) {
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
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: HireIQTheme.primaryNavy.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
              border: Border.all(color: HireIQTheme.borderLight),
            ),
            child: const Icon(Icons.business, color: HireIQTheme.primaryNavy),
          ),
          const SizedBox(width: 14),
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
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                          color: statusColor, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      status,
                      style: GoogleFonts.inter(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$activeJobs Active Listings',
                  style: GoogleFonts.inter(
                      color: HireIQTheme.textMuted, fontSize: 12),
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
