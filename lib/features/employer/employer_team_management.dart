import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerTeamManagement extends ConsumerStatefulWidget {
  const EmployerTeamManagement({super.key});

  @override
  ConsumerState<EmployerTeamManagement> createState() =>
      _EmployerTeamManagementState();
}

class _EmployerTeamManagementState
    extends ConsumerState<EmployerTeamManagement> {
  static const _members = [
    _TeamMember(
      name: 'Sarah Botha',
      role: 'Admin',
      email: 'sarah.botha@techflow.co.za',
      lastActive: 'Today',
      avatar: 'SB',
    ),
    _TeamMember(
      name: 'Ravi Pillay',
      role: 'Recruiter',
      email: 'ravi.pillay@techflow.co.za',
      lastActive: 'Yesterday',
      avatar: 'RP',
    ),
    _TeamMember(
      name: 'Nandi Mthembu',
      role: 'Hiring Manager',
      email: 'nandi.mthembu@techflow.co.za',
      lastActive: '3 days ago',
      avatar: 'NM',
    ),
  ];

  static const _pending = [
    _TeamMember(
      name: 'Alex van der Berg',
      role: 'Recruiter',
      email: 'alex.vdb@techflow.co.za',
      lastActive: 'Invited 19 Mar',
      avatar: 'AV',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Team Management',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Invite',
              style: GoogleFonts.inter(
                  color: HireIQTheme.amber, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Seats Usage ───────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.25)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.people_rounded,
                      color: HireIQTheme.primaryTeal, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Team Seats',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: HireIQTheme.primaryNavy),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '3 of 5 seats used',
                          style: GoogleFonts.inter(
                              fontSize: 12, color: HireIQTheme.textMuted),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Upgrade',
                      style: GoogleFonts.inter(
                          color: HireIQTheme.primaryTeal,
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Active Members ────────────────────────────────────────────
            Text(
              'Team Members',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 12),
            Container(
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
              child: Column(
                children: _members.asMap().entries.map((e) {
                  final isLast = e.key == _members.length - 1;
                  return Column(
                    children: [
                      _MemberTile(member: e.value),
                      if (!isLast)
                        const Divider(
                            height: 1, color: HireIQTheme.borderLight),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // ── Pending Invites ───────────────────────────────────────────
            Text(
              'Pending Invites',
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 12),
            Container(
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
              child: Column(
                children: _pending.asMap().entries.map((e) {
                  final isLast = e.key == _pending.length - 1;
                  return Column(
                    children: [
                      _MemberTile(member: e.value, isPending: true),
                      if (!isLast)
                        const Divider(
                            height: 1, color: HireIQTheme.borderLight),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamMember {
  const _TeamMember({
    required this.name,
    required this.role,
    required this.email,
    required this.lastActive,
    required this.avatar,
  });

  final String name;
  final String role;
  final String email;
  final String lastActive;
  final String avatar;
}

class _MemberTile extends StatelessWidget {
  const _MemberTile({required this.member, this.isPending = false});

  final _TeamMember member;
  final bool isPending;

  Color get _roleColor {
    switch (member.role) {
      case 'Admin':
        return HireIQTheme.primaryNavy;
      case 'Recruiter':
        return HireIQTheme.primaryTeal;
      default:
        return HireIQTheme.amber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: (isPending
                    ? HireIQTheme.warning
                    : HireIQTheme.primaryTeal)
                .withValues(alpha: 0.12),
            child: Text(
              member.avatar,
              style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: isPending ? HireIQTheme.warning : HireIQTheme.primaryTeal),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 2),
                Text(
                  member.email,
                  style: GoogleFonts.inter(
                      fontSize: 11, color: HireIQTheme.textMuted),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: _roleColor.withValues(alpha: 0.1),
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusFull),
                      ),
                      child: Text(
                        member.role,
                        style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: _roleColor),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.access_time_rounded,
                        size: 10, color: HireIQTheme.textMuted),
                    const SizedBox(width: 3),
                    Text(
                      member.lastActive,
                      style: GoogleFonts.inter(
                          fontSize: 10, color: HireIQTheme.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isPending)
            TextButton(
              onPressed: () {},
              child: Text(
                'Resend',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: HireIQTheme.primaryTeal),
              ),
            )
          else
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert_rounded,
                  color: HireIQTheme.textMuted, size: 18),
              onSelected: (_) {},
              itemBuilder: (_) => [
                const PopupMenuItem(value: 'role', child: Text('Change Role')),
                const PopupMenuItem(value: 'remove', child: Text('Remove')),
              ],
            ),
        ],
      ),
    );
  }
}
