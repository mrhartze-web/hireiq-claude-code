import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Mark all read',
              style: GoogleFonts.inter(
                  color: HireIQTheme.primaryTeal,
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _buildDayHeader('Today'),
          _buildNotification(
            'MatchIQ matched you!',
            'New Flutter Dev role at Apex Digital matches 98% of your profile.',
            Icons.auto_awesome,
            HireIQTheme.primaryTeal,
            isUnread: true,
          ),
          _buildNotification(
            'Interview Scheduled',
            'Synergy Labs has invited you to an interview tomorrow at 10:00 AM.',
            Icons.calendar_today_outlined,
            HireIQTheme.amber,
            isUnread: true,
          ),
          _buildDayHeader('Yesterday'),
          _buildNotification(
            'Profile Viewed',
            'A recruiter from M-Pesa Africa viewed your profile.',
            Icons.visibility_outlined,
            HireIQTheme.primaryNavy,
          ),
          _buildNotification(
            'System Update',
            'HireIQ v2.1 is now live with enhanced SkillIQ verification.',
            Icons.system_update_alt,
            HireIQTheme.textMuted,
          ),
        ],
      ),
    );
  }

  Widget _buildDayHeader(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        label,
        style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: HireIQTheme.textMuted,
            fontSize: 12,
            letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildNotification(
    String title,
    String body,
    IconData icon,
    Color color, {
    bool isUnread = false,
  }) {
    return Container(
      color: isUnread
          ? HireIQTheme.primaryTeal.withValues(alpha: 0.05)
          : Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.inter(
                            fontWeight: isUnread
                                ? FontWeight.bold
                                : FontWeight.w600,
                            fontSize: 14,
                            color: HireIQTheme.primaryNavy),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                            color: HireIQTheme.primaryTeal,
                            shape: BoxShape.circle),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      color: HireIQTheme.textMuted,
                      height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
