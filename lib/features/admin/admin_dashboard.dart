import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme.dart';

// ── Role switcher data ─────────────────────────────────────────────────────────

class _RoleOption {
  const _RoleOption({
    required this.label,
    required this.icon,
    required this.color,
    this.route,
  });

  final String label;
  final IconData icon;
  final Color color;
  final String? route; // null = stay on current screen
}

const _roleOptions = <_RoleOption>[
  _RoleOption(
    label: 'Candidate',
    icon: Icons.person_rounded,
    color: HireIQTheme.primaryTeal,
    route: '/candidate',
  ),
  _RoleOption(
    label: 'Employer',
    icon: Icons.business_rounded,
    color: HireIQTheme.primaryNavy,
    route: '/employer',
  ),
  _RoleOption(
    label: 'Recruiter',
    icon: Icons.handshake_rounded,
    color: HireIQTheme.recruiterAccent,
    route: '/recruiter',
  ),
  _RoleOption(
    label: 'Admin',
    icon: Icons.shield_rounded,
    color: Color(0xFF94A3B8),
    route: null,
  ),
];

// ── Screen ─────────────────────────────────────────────────────────────────────

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  void _navigate(BuildContext context, _RoleOption option) {
    if (option.route != null) {
      context.go(option.route!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('You are currently on the Admin dashboard'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: HireIQTheme.primaryNavy,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showRoleSwitcherSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _RoleSwitcherSheet(
        onSelect: (option) {
          Navigator.of(context).pop();
          _navigate(context, option);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      floatingActionButton: FloatingActionButton(
        mini: true,
        tooltip: 'Switch Role',
        backgroundColor: HireIQTheme.primaryTeal,
        foregroundColor: Colors.white,
        onPressed: () => _showRoleSwitcherSheet(context),
        child: const Icon(Icons.swap_horiz_rounded),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'System Admin',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── View As section ─────────────────────────────────────
                  _ViewAsSection(
                    onSelect: (option) => _navigate(context, option),
                  ),

                  const SizedBox(height: 28),

                  Text(
                    'Platform Overview',
                    style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'System status and key metrics at a glance.',
                    style: GoogleFonts.inter(
                        fontSize: 14, color: HireIQTheme.textMuted),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeader('System Health'),
                  const SizedBox(height: 16),
                  _buildStatusItem(
                      'Server Status', 'Operational', HireIQTheme.success),
                  _buildStatusItem(
                      'Database IQ', 'Synchronized', HireIQTheme.primaryTeal),
                  _buildStatusItem(
                      'AI Processing', 'Queueing (5)', HireIQTheme.warning),
                  const SizedBox(height: 32),
                  _buildSectionHeader('User Overview'),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: [
                      _buildMetricCard('Candidates', '12.4k',
                          Icons.people_outline),
                      _buildMetricCard(
                          'Employers', '842', Icons.business_outlined),
                      _buildMetricCard(
                          'Recruiters', '156', Icons.badge_outlined),
                      _buildMetricCard(
                          'New Today', '+42', Icons.trending_up),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // ── Page Directory ───────────────────────────────────────
                  GestureDetector(
                    onTap: () => context.push('/admin/pages'),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            HireIQTheme.primaryNavy,
                            HireIQTheme.primaryNavy
                                .withValues(alpha: 0.85),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusLg),
                        boxShadow: [
                          BoxShadow(
                            color: HireIQTheme.primaryNavy
                                .withValues(alpha: 0.25),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: HireIQTheme.primaryTeal
                                  .withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(
                                  HireIQTheme.radiusMd),
                            ),
                            child: const Icon(
                              Icons.map_outlined,
                              color: HireIQTheme.primaryTeal,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Page Directory',
                                  style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Browse and launch every screen in the app',
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.white
                                          .withValues(alpha: 0.65)),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white54,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                  _buildSectionHeader('Recent Flags'),
                  const SizedBox(height: 16),
                  ...List.generate(
                    3,
                    (index) => _buildFlagCard(context, index),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: HireIQTheme.primaryNavy),
    );
  }

  Widget _buildStatusItem(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 8),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
                fontSize: 14, color: HireIQTheme.textPrimary),
          ),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                value,
                style: GoogleFonts.inter(
                    color: color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: HireIQTheme.primaryTeal, size: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy),
              ),
              Text(
                label,
                style: GoogleFonts.inter(
                    fontSize: 12, color: HireIQTheme.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFlagCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => context.push('/admin/moderation'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
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
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: HireIQTheme.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.flag_outlined,
                  color: HireIQTheme.error, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Suspicious Activity #$index',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Automated ShieldIQ detection',
                    style: GoogleFonts.inter(
                        fontSize: 13, color: HireIQTheme.textMuted),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: HireIQTheme.textMuted),
          ],
        ),
      ),
    );
  }
}

// ── View As section ────────────────────────────────────────────────────────────

class _ViewAsSection extends StatelessWidget {
  const _ViewAsSection({required this.onSelect});

  final void Function(_RoleOption) onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: const Border(
          left: BorderSide(color: HireIQTheme.primaryTeal, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'View As',
            style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy),
          ),
          const SizedBox(height: 12),
          Row(
            children: _roleOptions
                .map((option) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _RolePillButton(
                          option: option,
                          isActive: option.route == null,
                          onTap: () => onSelect(option),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.info_outline_rounded,
                  size: 13, color: Color(0xFF94A3B8)),
              const SizedBox(width: 6),
              Text(
                'QC Mode — view any role experience',
                style: GoogleFonts.inter(
                    fontSize: 12, color: const Color(0xFF94A3B8)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Role pill button ───────────────────────────────────────────────────────────

class _RolePillButton extends StatelessWidget {
  const _RolePillButton({
    required this.option,
    required this.onTap,
    this.isActive = false,
  });

  final _RoleOption option;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: option.color,
          borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
          border: isActive
              ? Border.all(color: Colors.white, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: option.color.withValues(alpha: isActive ? 0.55 : 0.35),
              blurRadius: isActive ? 12 : 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(option.icon, color: Colors.white, size: 20),
            const SizedBox(height: 4),
            Text(
              option.label,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600),
            ),
            if (isActive) ...[
              const SizedBox(height: 2),
              const Icon(Icons.check_rounded, color: Colors.white, size: 10),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Role switcher bottom sheet ─────────────────────────────────────────────────

class _RoleSwitcherSheet extends StatelessWidget {
  const _RoleSwitcherSheet({required this.onSelect});

  final void Function(_RoleOption) onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(HireIQTheme.radiusXl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: HireIQTheme.borderLight,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Switch Role',
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy),
          ),
          const SizedBox(height: 4),
          Text(
            'Navigate to any role dashboard for QC review.',
            style: GoogleFonts.inter(
                fontSize: 13, color: HireIQTheme.textMuted),
          ),
          const SizedBox(height: 20),
          ..._roleOptions.map(
            (option) => _SheetRoleTile(
              option: option,
              onTap: () => onSelect(option),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Sheet role tile ────────────────────────────────────────────────────────────

class _SheetRoleTile extends StatelessWidget {
  const _SheetRoleTile({required this.option, required this.onTap});

  final _RoleOption option;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: option.color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
          border: Border.all(color: option.color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: option.color,
                shape: BoxShape.circle,
              ),
              child: Icon(option.icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 14),
            Text(
              option.label,
              style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: HireIQTheme.primaryNavy),
            ),
            const Spacer(),
            if (option.route != null)
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 14, color: option.color)
            else
              Text(
                'Current',
                style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF94A3B8),
                    fontWeight: FontWeight.w500),
              ),
          ],
        ),
      ),
    );
  }
}
