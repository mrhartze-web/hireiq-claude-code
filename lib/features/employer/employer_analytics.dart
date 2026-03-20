import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/skeleton_loader.dart';

class EmployerAnalytics extends ConsumerStatefulWidget {
  const EmployerAnalytics({super.key});

  @override
  ConsumerState<EmployerAnalytics> createState() => _EmployerAnalyticsState();
}

class _EmployerAnalyticsState extends ConsumerState<EmployerAnalytics> {
  String _period = '30 days';
  bool _isLoading = false;
  final _periods = ['7 days', '30 days', '90 days'];

  static const _funnel = [
    _FunnelItem(label: 'Views', count: 842, color: HireIQTheme.primaryNavy),
    _FunnelItem(label: 'Applications', count: 187, color: HireIQTheme.primaryTeal),
    _FunnelItem(label: 'Shortlisted', count: 43, color: HireIQTheme.amber),
    _FunnelItem(label: 'Interviewed', count: 18, color: Color(0xFF7C3AED)),
    _FunnelItem(label: 'Hired', count: 4, color: HireIQTheme.success),
  ];

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: SafeArea(child: SkeletonLoader(itemCount: 5)),
      );
    }

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
              'Recruitment Analytics',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.ios_share_outlined,
                    size: 20, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Period Filter ─────────────────────────────────────────
                Row(
                  children: _periods.map((p) {
                    final active = p == _period;
                    return GestureDetector(
                      onTap: () => setState(() => _period = p),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 7),
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
                          p,
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: active ? Colors.white : HireIQTheme.textMuted),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // ── KPI Cards ─────────────────────────────────────────────
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.6,
                  children: const [
                    _KpiCard(label: 'Total Views', value: '842', change: '+18%'),
                    _KpiCard(label: 'Applications', value: '187', change: '+23%'),
                    _KpiCard(label: 'Interviews', value: '18', change: '+12%'),
                    _KpiCard(label: 'Hired', value: '4', change: '+1'),
                  ],
                ),
                const SizedBox(height: 24),

                // ── Hiring Funnel ─────────────────────────────────────────
                Text(
                  'Hiring Funnel',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(20),
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
                    children: _funnel.asMap().entries.map((e) {
                      final item = e.value;
                      final maxCount = _funnel.first.count;
                      final ratio = item.count / maxCount;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.label,
                                  style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: HireIQTheme.textPrimary),
                                ),
                                Text(
                                  item.count.toString(),
                                  style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: item.color),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            LayoutBuilder(
                              builder: (context, constraints) => Stack(
                                children: [
                                  Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: HireIQTheme.borderLight,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  Container(
                                    height: 8,
                                    width: constraints.maxWidth * ratio,
                                    decoration: BoxDecoration(
                                      color: item.color,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),

                // ── AI Insights ───────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [HireIQTheme.primaryNavy, Color(0xFF243659)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.auto_awesome_rounded,
                              color: HireIQTheme.amber, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'MatchIQ Insight',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...[
                        '💡 Your Senior Engineer role has a 22% higher application rate than similar roles.',
                        '💡 Adding a salary range increased views by 38% compared to hidden salary listings.',
                        '💡 Candidates from Cape Town show a higher interview completion rate (94% vs 78% nationally).',
                      ].map((tip) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              tip,
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: 0.8),
                                  height: 1.5),
                            ),
                          )),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _FunnelItem {
  const _FunnelItem({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;
}

class _KpiCard extends StatelessWidget {
  const _KpiCard(
      {required this.label, required this.value, required this.change});

  final String label;
  final String value;
  final String change;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: HireIQTheme.textMuted),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: HireIQTheme.primaryNavy),
          ),
          const SizedBox(height: 4),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: HireIQTheme.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
            ),
            child: Text(
              change,
              style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.success),
            ),
          ),
        ],
      ),
    );
  }
}
