import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateNotifications extends StatelessWidget {
  const CandidateNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifications',
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: HireIQTheme.primaryNavy,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          '2 unread',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: HireIQTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusFull),
                        border: Border.all(
                          color:
                              HireIQTheme.primaryTeal.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        'Mark all read',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: HireIQTheme.primaryTeal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Notification list ────────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                children: const [
                  _DayLabel(label: 'Today'),
                  SizedBox(height: 10),
                  _NotificationTile(
                    title: 'MatchIQ Match',
                    body:
                        'You matched 92% for the Senior Developer role at Apex Digital.',
                    icon: Icons.auto_awesome,
                    iconColor: HireIQTheme.primaryTeal,
                    isUnread: true,
                    time: '2m ago',
                  ),
                  SizedBox(height: 10),
                  _NotificationTile(
                    title: 'Application Viewed',
                    body:
                        'FinTech Startup has viewed your application for Backend Engineer.',
                    icon: Icons.visibility_outlined,
                    iconColor: HireIQTheme.primaryNavy,
                    isUnread: true,
                    time: '1h ago',
                  ),
                  SizedBox(height: 20),
                  _DayLabel(label: 'Earlier'),
                  SizedBox(height: 10),
                  _NotificationTile(
                    title: 'Profile Update Recommended',
                    body:
                        'Update your career goals to get better MatchIQ recommendations.',
                    icon: Icons.engineering_outlined,
                    iconColor: HireIQTheme.warning,
                    isUnread: false,
                    time: '2 days ago',
                  ),
                  SizedBox(height: 10),
                  _NotificationTile(
                    title: 'System Message',
                    body:
                        'Welcome to HireIQ! Complete your PassportIQ to start applying.',
                    icon: Icons.message_outlined,
                    iconColor: HireIQTheme.textMuted,
                    isUnread: false,
                    time: '3 days ago',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Day label ──────────────────────────────────────────────────────────────────

class _DayLabel extends StatelessWidget {
  const _DayLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: HireIQTheme.textLight,
        letterSpacing: 0.4,
      ),
    );
  }
}

// ── Notification tile ──────────────────────────────────────────────────────────

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.title,
    required this.body,
    required this.icon,
    required this.iconColor,
    required this.isUnread,
    required this.time,
  });

  final String title;
  final String body;
  final IconData icon;
  final Color iconColor;
  final bool isUnread;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread
            ? HireIQTheme.primaryTeal.withValues(alpha: 0.05)
            : HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
          color: isUnread
              ? HireIQTheme.primaryTeal.withValues(alpha: 0.2)
              : HireIQTheme.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon box
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),

          const SizedBox(width: 12),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight:
                              isUnread ? FontWeight.w700 : FontWeight.w600,
                          color: HireIQTheme.primaryNavy,
                          letterSpacing: -0.1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: HireIQTheme.textLight,
                      ),
                    ),
                    if (isUnread) ...[
                      const SizedBox(width: 8),
                      Container(
                        width: 7,
                        height: 7,
                        margin: const EdgeInsets.only(top: 3),
                        decoration: const BoxDecoration(
                          color: HireIQTheme.primaryTeal,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  body,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: HireIQTheme.textMuted,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
