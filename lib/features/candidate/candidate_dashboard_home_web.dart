import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateDashboardHomeWeb extends ConsumerWidget {
  const CandidateDashboardHomeWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const WebLayout(
      child: _DashboardBody(),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 36, 40, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting
          Text(
            'Good morning, Thabo',
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: HireIQTheme.primaryNavy,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Here's your job-search summary for today.",
            style: GoogleFonts.inter(
              fontSize: 15,
              color: HireIQTheme.textMuted,
            ),
          ),
          const SizedBox(height: 28),

          // Stats row
          const Row(
            children: [
              _StatCard(
                label: 'MatchIQ Score',
                value: '87%',
                icon: Icons.auto_awesome_rounded,
                color: HireIQTheme.primaryTeal,
                sub: '+3 this week',
              ),
              SizedBox(width: 16),
              _StatCard(
                label: 'Applications',
                value: '6',
                icon: Icons.send_rounded,
                color: HireIQTheme.primaryNavy,
                sub: '2 in review',
              ),
              SizedBox(width: 16),
              _StatCard(
                label: 'Profile Completion',
                value: '72%',
                icon: Icons.person_rounded,
                color: HireIQTheme.warning,
                sub: 'Add 3 more items',
              ),
              SizedBox(width: 16),
              _StatCard(
                label: 'Saved Jobs',
                value: '14',
                icon: Icons.bookmark_rounded,
                color: HireIQTheme.info,
                sub: '3 closing soon',
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Main content row
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: Recommended jobs (2/3 width)
              Expanded(
                flex: 2,
                child: _RecommendedJobs(),
              ),
              SizedBox(width: 24),
              // Right: Activity + quick actions (1/3 width)
              Expanded(
                child: Column(
                  children: [
                    _ActivityFeed(),
                    SizedBox(height: 16),
                    _QuickActions(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Stat card ──────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  const _StatCard({
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
            Row(
              children: [
                Icon(icon, color: color, size: 18),
                const Spacer(),
              ],
            ),
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

// ── Recommended jobs ───────────────────────────────────────────────────────────

class _RecommendedJobs extends StatelessWidget {
  const _RecommendedJobs();

  static const _jobs = [
    ('Senior Flutter Developer', 'TechFlow Solutions', 'Cape Town', 'R85k–R120k', 94),
    ('Lead Mobile Engineer', 'Capitec Bank', 'Johannesburg', 'R95k–R130k', 91),
    ('Software Engineer', 'Standard Bank', 'Remote', 'R80k–R110k', 88),
    ('React Native Dev', 'OUTsurance', 'Cape Town', 'R70k–R95k', 84),
    ('Frontend Dev', 'Discovery', 'Johannesburg', 'R65k–R90k', 81),
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
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
            child: Row(
              children: [
                Text(
                  'Recommended for You',
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
                    'Browse all',
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
          // Job rows
          ...List.generate(_jobs.length, (i) {
            final j = _jobs[i];
            return Column(
              children: [
                _JobRow(
                  title: j.$1,
                  company: j.$2,
                  location: j.$3,
                  salary: j.$4,
                  matchScore: j.$5,
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

class _JobRow extends StatelessWidget {
  const _JobRow({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.matchScore,
  });

  final String title;
  final String company;
  final String location;
  final String salary;
  final int matchScore;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.textPrimary,
                    ),
                  ),
                  Text(
                    '$company · $location',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: HireIQTheme.textMuted,
                    ),
                  ),
                  Text(
                    salary,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy,
                    ),
                  ),
                ],
              ),
            ),
            // Match score badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.auto_awesome_rounded,
                    size: 10,
                    color: HireIQTheme.primaryTeal,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    '$matchScore%',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryTeal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Apply button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: HireIQTheme.amber,
                foregroundColor: HireIQTheme.primaryNavy,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                ),
              ),
              child: Text(
                'Apply',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Activity feed ──────────────────────────────────────────────────────────────

class _ActivityFeed extends StatelessWidget {
  const _ActivityFeed();

  static const _activities = [
    (Icons.check_circle_rounded, HireIQTheme.success, 'TechFlow shortlisted you', '2h ago'),
    (Icons.visibility_rounded, HireIQTheme.info, 'Capitec viewed your profile', '5h ago'),
    (Icons.send_rounded, HireIQTheme.primaryTeal, 'Applied to Standard Bank', 'Yesterday'),
    (Icons.bookmark_rounded, HireIQTheme.warning, 'Saved: OUTsurance Dev role', '2 days ago'),
    (Icons.auto_awesome_rounded, HireIQTheme.primaryTeal, 'MatchIQ updated +3 points', '3 days ago'),
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
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: 14),
          ..._activities.map(
            (a) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: a.$2.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(a.$1, color: a.$2, size: 16),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a.$3,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: HireIQTheme.textPrimary,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Quick actions ──────────────────────────────────────────────────────────────

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.primaryNavy,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 14),
          const _QuickActionRow(
            icon: Icons.edit_document,
            label: 'Update CV with ForgeIQ',
          ),
          const SizedBox(height: 8),
          const _QuickActionRow(
            icon: Icons.search_rounded,
            label: 'Search new jobs',
          ),
          const SizedBox(height: 8),
          const _QuickActionRow(
            icon: Icons.verified_rounded,
            label: 'Complete PassportIQ',
          ),
        ],
      ),
    );
  }
}

class _QuickActionRow extends StatelessWidget {
  const _QuickActionRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70, size: 16),
            const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white54,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
