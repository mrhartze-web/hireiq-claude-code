import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateMessagesInbox extends StatelessWidget {
  const CandidateMessagesInbox({super.key});

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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Messages',
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
                  _HeaderIconButton(
                    icon: Icons.search_rounded,
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // ── Thread list ─────────────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                children: const [
                  _ThreadTile(
                    sender: 'Apex Digital',
                    preview:
                        'Sarah from Apex Digital: Are you available for a quick chat tomorrow?',
                    time: '2m ago',
                    isUnread: true,
                  ),
                  _ThreadTile(
                    sender: 'FinTech Startup',
                    preview:
                        'We were impressed by your MatchIQ fit. When can we schedule an interview?',
                    time: '1h ago',
                    isUnread: true,
                  ),
                  _ThreadTile(
                    sender: 'HireIQ Support',
                    preview:
                        'Your PassportIQ verification was successful! Your profile is now live.',
                    time: 'Yesterday',
                    isUnread: false,
                    isSystem: true,
                  ),
                  _ThreadTile(
                    sender: 'Cyberdyne Systems',
                    preview:
                        'Thank you for your application, however we have decided to move forward with other candidates at this time.',
                    time: '2 days ago',
                    isUnread: false,
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

// ── Header icon button ─────────────────────────────────────────────────────────

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: HireIQTheme.surfaceWhite,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: HireIQTheme.textSecondary),
      ),
    );
  }
}

// ── Thread tile ────────────────────────────────────────────────────────────────

class _ThreadTile extends StatelessWidget {
  const _ThreadTile({
    required this.sender,
    required this.preview,
    required this.time,
    required this.isUnread,
    this.isSystem = false,
  });

  final String sender;
  final String preview;
  final String time;
  final bool isUnread;
  final bool isSystem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
          // Avatar
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: isSystem
                  ? HireIQTheme.primaryNavy
                  : HireIQTheme.primaryTeal.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: isSystem
                ? const Icon(
                    Icons.support_agent_rounded,
                    color: Colors.white,
                    size: 22,
                  )
                : Center(
                    child: Text(
                      sender[0].toUpperCase(),
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryTeal,
                      ),
                    ),
                  ),
          ),

          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        sender,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight:
                              isUnread ? FontWeight.w700 : FontWeight.w600,
                          color: HireIQTheme.primaryNavy,
                          letterSpacing: -0.1,
                        ),
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight:
                            isUnread ? FontWeight.w700 : FontWeight.w400,
                        color: isUnread
                            ? HireIQTheme.primaryTeal
                            : HireIQTheme.textLight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  preview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: isUnread
                        ? HireIQTheme.textSecondary
                        : HireIQTheme.textMuted,
                    fontWeight:
                        isUnread ? FontWeight.w500 : FontWeight.w400,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),

          // Unread dot
          if (isUnread) ...[
            const SizedBox(width: 10),
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 4),
              decoration: const BoxDecoration(
                color: HireIQTheme.primaryTeal,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
