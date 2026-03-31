import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class RecruiterDashboardWeb extends ConsumerWidget {
  const RecruiterDashboardWeb({super.key});

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
            'Recruiter Dashboard',
            style: GoogleFonts.inter(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: HireIQTheme.primaryNavy,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Good morning, Lindiwe — here's your pipeline today.",
            style: GoogleFonts.inter(
              fontSize: 15,
              color: HireIQTheme.textMuted,
            ),
          ),
          const SizedBox(height: 28),

          // Stats row
          const Row(
            children: [
              _RecruiterStatCard(
                label: 'Active Briefs',
                value: '6',
                icon: Icons.description_rounded,
                color: HireIQTheme.primaryNavy,
                sub: '2 expiring soon',
              ),
              SizedBox(width: 16),
              _RecruiterStatCard(
                label: 'Candidates Submitted',
                value: '28',
                icon: Icons.people_rounded,
                color: HireIQTheme.primaryTeal,
                sub: '+5 this week',
              ),
              SizedBox(width: 16),
              _RecruiterStatCard(
                label: 'Interviews Arranged',
                value: '9',
                icon: Icons.video_call_rounded,
                color: HireIQTheme.info,
                sub: '3 this week',
              ),
              SizedBox(width: 16),
              _RecruiterStatCard(
                label: 'Placements MTD',
                value: '2',
                icon: Icons.handshake_rounded,
                color: HireIQTheme.success,
                sub: 'R48,000 earned',
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Main content row
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _ActiveBriefs()),
              SizedBox(width: 24),
              Expanded(child: _TodaysTasks()),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Recruiter stat card ────────────────────────────────────────────────────────

class _RecruiterStatCard extends StatelessWidget {
  const _RecruiterStatCard({
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
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: HireIQTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
          border: Border.all(color: HireIQTheme.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: HireIQTheme.textPrimary,
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

// ── Active briefs ──────────────────────────────────────────────────────────────

class _ActiveBriefs extends StatelessWidget {
  const _ActiveBriefs();

  static const _briefs = [
    ('Senior Flutter Developer', 'TechFlow Solutions', 'Closing 25 Mar', HireIQTheme.error),
    ('Product Manager', 'Capitec Bank', 'Closing 30 Mar', HireIQTheme.warning),
    ('DevOps Engineer', 'Standard Bank', 'Closing 10 Apr', HireIQTheme.success),
    ('UI/UX Designer', 'Nedbank', 'Closing 15 Apr', HireIQTheme.success),
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
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Text(
                  'Active Briefs',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: HireIQTheme.primaryNavy,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View all',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: HireIQTheme.primaryTeal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: HireIQTheme.borderLight),
          ...List.generate(_briefs.length, (i) {
            final brief = _briefs[i];
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              brief.$1,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: HireIQTheme.textPrimary,
                              ),
                            ),
                            Text(
                              brief.$2,
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: HireIQTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: brief.$4.withValues(alpha: 0.1),
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusFull),
                        ),
                        child: Text(
                          brief.$3,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: brief.$4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < _briefs.length - 1)
                  const Divider(height: 1, color: HireIQTheme.borderLight),
              ],
            );
          }),
        ],
      ),
    );
  }
}

// ── Today's tasks ──────────────────────────────────────────────────────────────

class _TodaysTasks extends StatelessWidget {
  const _TodaysTasks();

  static const _tasks = [
    (true, 'Call Thabo re: TechFlow offer', '09:00'),
    (false, 'Submit 3 CVs to Capitec Bank', 'ASAP'),
    (false, 'Arrange interview for Sipho', 'Today'),
    (false, 'Send placement agreement to Nedbank', 'EOD'),
    (false, 'Follow up: Priya N. interview feedback', 'Tomorrow'),
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
            "Today's Tasks",
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: 14),
          ..._tasks.map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Icon(
                    t.$1
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    size: 18,
                    color: t.$1 ? HireIQTheme.success : HireIQTheme.borderMedium,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      t.$2,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: t.$1
                            ? HireIQTheme.textMuted
                            : HireIQTheme.textPrimary,
                        decoration: t.$1 ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                  Text(
                    t.$3,
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
