import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/empty_state.dart';

class CandidateCareerGoals extends ConsumerStatefulWidget {
  const CandidateCareerGoals({super.key});

  @override
  ConsumerState<CandidateCareerGoals> createState() =>
      _CandidateCareerGoalsState();
}

class _CandidateCareerGoalsState extends ConsumerState<CandidateCareerGoals> {
  String _selectedTimeline = '12 months';
  final _timelines = ['3 months', '6 months', '12 months', '2 years'];

  static const _goals = [
    _Goal(
      title: 'Become a Senior Engineer',
      category: 'Career Level',
      progress: 0.6,
      targetDate: 'Jun 2026',
    ),
    _Goal(
      title: 'Learn System Design',
      category: 'Skill',
      progress: 0.35,
      targetDate: 'Apr 2026',
    ),
    _Goal(
      title: 'Earn AWS Certification',
      category: 'Certification',
      progress: 0.80,
      targetDate: 'Mar 2026',
    ),
  ];

  static const _skillsToAcquire = [
    'System Design',
    'Kubernetes',
    'Terraform',
    'Leadership',
    'Architecture Patterns',
  ];

  @override
  Widget build(BuildContext context) {
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
              'Career Goals',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Edit',
                  style: GoogleFonts.inter(
                      color: HireIQTheme.amber, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── UpliftIQ Tip Card ─────────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7C3AED), Color(0xFF6D28D9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.rocket_launch_rounded,
                            size: 20, color: Colors.white),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Powered by UpliftIQ™',
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Your goals power your personalised career roadmap',
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: 0.85),
                                  height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Target Role ───────────────────────────────────────────
                Text(
                  'Target Role & Salary',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 12),
                _buildOutlinedField('Target Role', 'e.g. Senior Software Engineer'),
                const SizedBox(height: 10),
                _buildOutlinedField(
                    'Target Salary (ZAR)', 'e.g. R850,000 per year'),
                const SizedBox(height: 12),

                // ── Timeline ──────────────────────────────────────────────
                Text(
                  'Timeline',
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.textPrimary),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: _timelines.map((t) {
                    final active = t == _selectedTimeline;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedTimeline = t),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: active
                              ? HireIQTheme.primaryNavy
                              : HireIQTheme.surfaceWhite,
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusFull),
                          border: Border.all(
                            color: active
                                ? HireIQTheme.primaryNavy
                                : HireIQTheme.borderLight,
                          ),
                        ),
                        child: Text(
                          t,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: active
                                ? Colors.white
                                : HireIQTheme.textMuted,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                // ── Active Goals ──────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Active Goals',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: HireIQTheme.primaryNavy),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        '+ Add Goal',
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: HireIQTheme.primaryTeal),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (_goals.isEmpty)
                  const EmptyState(
                    icon: Icons.flag_rounded,
                    heading: 'No goals set yet',
                    body:
                        'Set your first goal to activate your UpliftIQ career roadmap.',
                    ctaLabel: 'Set a Goal',
                  )
                else
                  ..._goals.map((g) => _GoalCard(goal: g)),
                const SizedBox(height: 24),

                // ── Skills to Acquire ─────────────────────────────────────
                Text(
                  'Skills to Acquire',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _skillsToAcquire.map((s) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: HireIQTheme.primaryNavy.withValues(alpha: 0.06),
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusFull),
                        border: Border.all(color: HireIQTheme.borderLight),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add_rounded,
                              size: 14, color: HireIQTheme.primaryTeal),
                          const SizedBox(width: 4),
                          Text(
                            s,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: HireIQTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 28),

                // ── Save Button ───────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HireIQTheme.amber,
                      foregroundColor: HireIQTheme.primaryNavy,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusLg)),
                    ),
                    child: Text(
                      'Save Career Goals',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutlinedField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: HireIQTheme.textPrimary)),
        const SizedBox(height: 6),
        TextFormField(
          style:
              GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                GoogleFonts.inter(color: HireIQTheme.textMuted, fontSize: 13),
            filled: true,
            fillColor: HireIQTheme.surfaceWhite,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
              borderSide: const BorderSide(color: HireIQTheme.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
              borderSide: const BorderSide(color: HireIQTheme.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
              borderSide: const BorderSide(
                  color: HireIQTheme.primaryTeal, width: 1.5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
      ],
    );
  }
}

class _Goal {
  const _Goal({
    required this.title,
    required this.category,
    required this.progress,
    required this.targetDate,
  });

  final String title;
  final String category;
  final double progress;
  final String targetDate;
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({required this.goal});
  final _Goal goal;

  @override
  Widget build(BuildContext context) {
    final pct = (goal.progress * 100).toInt();
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal.title,
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: HireIQTheme.primaryNavy),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${goal.category} • Target: ${goal.targetDate}',
                      style: GoogleFonts.inter(
                          fontSize: 12, color: HireIQTheme.textMuted),
                    ),
                  ],
                ),
              ),
              Text(
                '$pct%',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: pct >= 70
                        ? HireIQTheme.success
                        : HireIQTheme.primaryTeal),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: HireIQTheme.borderLight,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) => Container(
                  height: 6,
                  width: constraints.maxWidth * goal.progress,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: pct >= 70
                          ? [HireIQTheme.success, const Color(0xFF16A34A)]
                          : [HireIQTheme.primaryTeal, const Color(0xFF0B7A70)],
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
