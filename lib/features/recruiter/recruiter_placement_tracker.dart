import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';

class RecruiterPlacementTracker extends StatelessWidget {
  const RecruiterPlacementTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Placement Pipeline',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.white),
              onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Active Submissions',
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy),
          ),
          const SizedBox(height: 16),
          _buildTrackerCard(
              'Alice Johnson',
              'Senior Developer',
              'Apex Digital',
              'Interviewing',
              HireIQTheme.primaryTeal),
          _buildTrackerCard(
              'Bob Smith',
              'Backend Engineer',
              'FinTech Startup',
              'Submitted',
              HireIQTheme.textMuted),
          _buildTrackerCard(
              'Charlie Davis',
              'UI/UX Designer',
              'Global Tech',
              'Offer Extended',
              HireIQTheme.amber),
        ],
      ),
    );
  }

  Widget _buildTrackerCard(String candidate, String role, String client,
      String status, Color statusColor) {
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
            backgroundColor:
                HireIQTheme.primaryNavy.withValues(alpha: 0.08),
            child: Text(
              candidate[0],
              style: GoogleFonts.inter(
                  color: HireIQTheme.primaryNavy,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(candidate,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 2),
                Text('$role at $client',
                    style: GoogleFonts.inter(
                        color: HireIQTheme.textMuted, fontSize: 13)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.inter(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios,
              size: 14, color: HireIQTheme.textMuted),
        ],
      ),
    );
  }
}
