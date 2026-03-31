import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerDashboardWeb extends ConsumerWidget {
  const EmployerDashboardWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const WebLayout(
      child: _DashboardBody(),
    );
  }
}

// ── Dashboard body ─────────────────────────────────────────────────────────────

class _DashboardBody extends StatelessWidget {
  const _DashboardBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 36, 40, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Employer Dashboard',
            style: GoogleFonts.inter(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: HireIQTheme.primaryNavy,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Welcome back, TechFlow Solutions.',
            style: GoogleFonts.inter(
              fontSize: 15,
              color: HireIQTheme.textMuted,
            ),
          ),
          const SizedBox(height: 28),

          // Stats row
          const Row(
            children: [
              _EmployerStatCard(
                label: 'Active Jobs',
                value: '8',
                icon: Icons.work_rounded,
                color: HireIQTheme.primaryNavy,
                sub: '+2 this month',
              ),
              SizedBox(width: 16),
              _EmployerStatCard(
                label: 'Total Candidates',
                value: '142',
                icon: Icons.people_rounded,
                color: HireIQTheme.primaryTeal,
                sub: '34 new this week',
              ),
              SizedBox(width: 16),
              _EmployerStatCard(
                label: 'Interviews Scheduled',
                value: '12',
                icon: Icons.video_call_rounded,
                color: HireIQTheme.info,
                sub: '5 this week',
              ),
              SizedBox(width: 16),
              _EmployerStatCard(
                label: 'Offers Extended',
                value: '3',
                icon: Icons.handshake_rounded,
                color: HireIQTheme.success,
                sub: '2 accepted',
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Main content row
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Active jobs table (2/3 width)
              Expanded(flex: 2, child: _ActiveJobsTable()),
              SizedBox(width: 24),
              // Recent activity (1/3 width)
              Expanded(child: _RecentActivity()),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Employer stat card ─────────────────────────────────────────────────────────

class _EmployerStatCard extends StatelessWidget {
  const _EmployerStatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.sub,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: HireIQTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
          border: Border.all(color: HireIQTheme.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View',
                    style: GoogleFonts.inter(fontSize: 12, color: color),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: HireIQTheme.textMuted,
              ),
            ),
            Text(
              sub,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: HireIQTheme.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Active jobs table ──────────────────────────────────────────────────────────

class _ActiveJobsTable extends StatelessWidget {
  const _ActiveJobsTable();

  static const _jobs = [
    ('Senior Flutter Developer', '34', '88%', 'Active'),
    ('Product Manager', '22', '81%', 'Active'),
    ('DevOps Engineer', '18', '76%', 'Active'),
    ('UI/UX Designer', '29', '85%', 'Paused'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  'Active Job Posts',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: HireIQTheme.primaryNavy,
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 14),
                  label: Text(
                    'Post Job',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HireIQTheme.amber,
                    foregroundColor: HireIQTheme.primaryNavy,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusMd),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: HireIQTheme.borderLight),
          // Column headers
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: HireIQTheme.background,
            child: const Row(
              children: [
                _TableHeaderCell(label: 'Role', flex: 2),
                _TableHeaderCell(label: 'Applicants'),
                _TableHeaderCell(label: 'MatchIQ avg'),
                _TableHeaderCell(label: 'Status'),
              ],
            ),
          ),
          const Divider(height: 1, color: HireIQTheme.borderLight),
          // Rows
          ...List.generate(_jobs.length, (i) {
            final row = _jobs[i];
            final isActive = row.$4 == 'Active';
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 14),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          row.$1,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: HireIQTheme.textPrimary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          row.$2,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: HireIQTheme.textMuted,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          row.$3,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryTeal,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isActive
                                ? HireIQTheme.success.withValues(alpha: 0.1)
                                : HireIQTheme.warning.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                                HireIQTheme.radiusFull),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            row.$4,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: isActive
                                  ? HireIQTheme.success
                                  : HireIQTheme.warning,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < _jobs.length - 1)
                  const Divider(height: 1, color: HireIQTheme.borderLight),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _TableHeaderCell extends StatelessWidget {
  const _TableHeaderCell({required this.label, this.flex = 1});

  final String label;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: HireIQTheme.textMuted,
        ),
      ),
    );
  }
}

// ── Recent activity ────────────────────────────────────────────────────────────

class _RecentActivity extends StatelessWidget {
  const _RecentActivity();

  static const _activities = [
    (Icons.person_add_rounded, 'New application', 'Sipho M. applied to Flutter Dev', '5m'),
    (Icons.auto_awesome_rounded, 'SignalIQ alert', 'High-match candidate spotted', '22m'),
    (Icons.calendar_today_rounded, 'Interview set', 'Meeting confirmed with Anele K.', '1h'),
    (Icons.handshake_rounded, 'Offer accepted', 'Priya N. accepted offer', '3h'),
    (Icons.rate_review_rounded, 'Review pending', 'Stage 2 feedback due', '1d'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activity',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: 14),
          ..._activities.map(
            (a) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(a.$1, size: 16, color: HireIQTheme.primaryTeal),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a.$2,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.textPrimary,
                          ),
                        ),
                        Text(
                          a.$3,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: HireIQTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    a.$4,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: HireIQTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
