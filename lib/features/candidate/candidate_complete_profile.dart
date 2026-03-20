import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateCompleteProfile extends ConsumerWidget {
  const CandidateCompleteProfile({super.key});

  static const _items = [
    _ChecklistItem(
        label: 'Profile Photo',
        points: 10,
        subtitle: 'A professional photo builds trust with employers',
        isComplete: true,
        icon: Icons.photo_camera_outlined),
    _ChecklistItem(
        label: 'Skills',
        points: 15,
        subtitle: 'Add at least 5 skills to improve matching',
        isComplete: true,
        icon: Icons.psychology_outlined),
    _ChecklistItem(
        label: 'Work Experience',
        points: 20,
        subtitle: 'Add your employment history',
        isComplete: true,
        icon: Icons.work_outline_rounded),
    _ChecklistItem(
        label: 'Education',
        points: 15,
        subtitle: 'Add your highest qualification',
        isComplete: false,
        icon: Icons.school_outlined),
    _ChecklistItem(
        label: 'References',
        points: 15,
        subtitle: 'Add at least 2 professional references',
        isComplete: false,
        icon: Icons.people_outline_rounded),
    _ChecklistItem(
        label: 'PassportIQ Verification',
        points: 25,
        subtitle: 'Verify your identity to unlock premium matches',
        isComplete: false,
        icon: Icons.verified_user_outlined),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed = _items.where((i) => i.isComplete).length;
    final totalPoints = _items.fold(0, (sum, i) => sum + i.points);
    final earnedPoints =
        _items.where((i) => i.isComplete).fold(0, (sum, i) => sum + i.points);
    final progress = earnedPoints / totalPoints;

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Complete Profile',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
              child: Column(
                children: [
                  // ── Progress Ring Card ────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusXl),
                      border: Border.all(color: HireIQTheme.borderLight),
                      boxShadow: [
                        BoxShadow(
                          color: HireIQTheme.primaryNavy
                              .withValues(alpha: 0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 96,
                          height: 96,
                          child: CustomPaint(
                            painter: _ProgressRingPainter(
                                progress: progress,
                                color: HireIQTheme.primaryTeal),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${(progress * 100).toInt()}%',
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: HireIQTheme.primaryNavy),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Profile Strength',
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: HireIQTheme.primaryNavy),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '$completed of ${_items.length} sections complete',
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: HireIQTheme.textMuted),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: HireIQTheme.amber
                                      .withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(
                                      HireIQTheme.radiusFull),
                                ),
                                child: Text(
                                  '+${totalPoints - earnedPoints} MatchIQ pts available',
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: HireIQTheme.amber),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Checklist ─────────────────────────────────────────
                  Row(
                    children: [
                      Text(
                        'Profile Sections',
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryNavy),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ..._items.map((item) => _ChecklistCard(item: item)),
                  const SizedBox(height: 20),

                  // ── Impact Card ───────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          HireIQTheme.primaryNavy,
                          Color(0xFF243659)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.auto_awesome_rounded,
                                color: HireIQTheme.amber, size: 22),
                            const SizedBox(width: 10),
                            Text(
                              'Total MatchIQ Impact',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _ImpactStat('$earnedPoints', 'Earned'),
                            Container(
                                width: 1,
                                height: 36,
                                color:
                                    Colors.white.withValues(alpha: 0.15)),
                            _ImpactStat('$totalPoints', 'Total'),
                            Container(
                                width: 1,
                                height: 36,
                                color:
                                    Colors.white.withValues(alpha: 0.15)),
                            _ImpactStat(
                                '+${totalPoints - earnedPoints}', 'Available'),
                          ],
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

class _ImpactStat extends StatelessWidget {
  const _ImpactStat(this.value, this.label);
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: HireIQTheme.amber),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.inter(
              fontSize: 12, color: Colors.white.withValues(alpha: 0.65)),
        ),
      ],
    );
  }
}

class _ChecklistItem {
  const _ChecklistItem({
    required this.label,
    required this.points,
    required this.subtitle,
    required this.isComplete,
    required this.icon,
  });

  final String label;
  final int points;
  final String subtitle;
  final bool isComplete;
  final IconData icon;
}

class _ChecklistCard extends StatelessWidget {
  const _ChecklistCard({required this.item});
  final _ChecklistItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
          color: item.isComplete
              ? HireIQTheme.success.withValues(alpha: 0.3)
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
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (item.isComplete
                      ? HireIQTheme.success
                      : HireIQTheme.primaryNavy)
                  .withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.isComplete ? Icons.check_circle_rounded : item.icon,
              size: 20,
              color: item.isComplete
                  ? HireIQTheme.success
                  : HireIQTheme.primaryNavy,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  style: GoogleFonts.inter(
                      fontSize: 12, color: HireIQTheme.textMuted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          if (!item.isComplete)
            GestureDetector(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: HireIQTheme.amber,
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  '+${item.points}pts',
                  style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: HireIQTheme.primaryNavy),
                ),
              ),
            )
          else
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: HireIQTheme.success.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
              ),
              child: Text(
                '+${item.points}pts',
                style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.success),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Progress Ring Painter ─────────────────────────────────────────────────────

class _ProgressRingPainter extends CustomPainter {
  const _ProgressRingPainter({
    required this.progress,
    required this.color,
  });

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 12) / 2;

    final trackPaint = Paint()
      ..color = HireIQTheme.borderLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
