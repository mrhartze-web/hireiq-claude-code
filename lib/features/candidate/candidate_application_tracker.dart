import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class ApplicationTracker extends ConsumerWidget {
  const ApplicationTracker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Applications',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: HireIQTheme.primaryNavy,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    '3 active applications',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: HireIQTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ),

            // ── List ──────────────────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                children: const [
                  _ApplicationCard(
                    role: 'Senior Flutter Developer',
                    company: 'Apex Digital',
                    status: 'Interview Scheduled',
                    stage: 3,
                    statusColor: HireIQTheme.primaryTeal,
                    appliedDate: 'Applied 2 days ago',
                  ),
                  _ApplicationCard(
                    role: 'UX Designer',
                    company: 'Synergy Labs',
                    status: 'CV Under Review',
                    stage: 1,
                    statusColor: HireIQTheme.amber,
                    appliedDate: 'Applied 5 days ago',
                  ),
                  _ApplicationCard(
                    role: 'Backend Engineer',
                    company: 'M-Pesa Africa',
                    status: 'Applied',
                    stage: 0,
                    statusColor: HireIQTheme.textMuted,
                    appliedDate: 'Applied 1 week ago',
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

// ── Application card ──────────────────────────────────────────────────────────

class _ApplicationCard extends StatelessWidget {
  const _ApplicationCard({
    required this.role,
    required this.company,
    required this.status,
    required this.stage,
    required this.statusColor,
    required this.appliedDate,
  });

  final String role;
  final String company;
  final String status;
  final int stage;
  final Color statusColor;
  final String appliedDate;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
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
        children: [
          // ── Top row ──────────────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                ),
                child: Icon(
                  Icons.work_outline_rounded,
                  color: statusColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      company,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: HireIQTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              // Status badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ── Pipeline stepper ─────────────────────────────────────────
          _PipelineStepper(stage: stage, statusColor: statusColor),

          const SizedBox(height: 14),

          // ── Applied date ─────────────────────────────────────────────
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 12,
                color: HireIQTheme.textLight,
              ),
              const SizedBox(width: 5),
              Text(
                appliedDate,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: HireIQTheme.textLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Pipeline stepper ──────────────────────────────────────────────────────────

class _PipelineStepper extends StatelessWidget {
  const _PipelineStepper({required this.stage, required this.statusColor});

  final int stage;
  final Color statusColor;

  static const List<String> _labels = [
    'Applied',
    'Reviewed',
    'Interview',
    'Offer',
    'Hired',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dots + lines row
        Row(
          children: List.generate(5, (i) {
            final isActive = i <= stage;
            final isCurrent = i == stage;
            final isLast = i == 4;
            return Expanded(
              child: Row(
                children: [
                  // Dot
                  Container(
                    width: isCurrent ? 16 : 12,
                    height: isCurrent ? 16 : 12,
                    decoration: BoxDecoration(
                      color: isActive ? statusColor : HireIQTheme.borderLight,
                      shape: BoxShape.circle,
                      border: isCurrent
                          ? Border.all(
                              color: statusColor.withValues(alpha: 0.3),
                              width: 3,
                            )
                          : null,
                      boxShadow: isCurrent
                          ? [
                              BoxShadow(
                                color: statusColor.withValues(alpha: 0.35),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                  ),
                  // Connector line
                  if (!isLast)
                    Expanded(
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: i < stage
                              ? statusColor
                              : HireIQTheme.borderLight,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),

        const SizedBox(height: 6),

        // Labels row
        Row(
          children: List.generate(5, (i) {
            final isActive = i <= stage;
            return Expanded(
              child: Text(
                _labels[i],
                style: GoogleFonts.inter(
                  fontSize: 9,
                  fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive ? statusColor : HireIQTheme.textLight,
                ),
                textAlign: i == 0
                    ? TextAlign.left
                    : i == 4
                        ? TextAlign.right
                        : TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }),
        ),
      ],
    );
  }
}
