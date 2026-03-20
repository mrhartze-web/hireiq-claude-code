import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class RecruiterSignalIqReport extends ConsumerStatefulWidget {
  const RecruiterSignalIqReport({super.key});

  @override
  ConsumerState<RecruiterSignalIqReport> createState() =>
      _RecruiterSignalIqReportState();
}

class _RecruiterSignalIqReportState
    extends ConsumerState<RecruiterSignalIqReport> {
  String _period = 'Q1 2026';
  final _periods = ['Q1 2026', 'Q4 2025', 'Q3 2025'];

  static const _roleInsights = [
    _RoleInsight(role: 'Flutter Developer', demand: 'Very High', avgDays: 14, submitted: 8, placed: 5),
    _RoleInsight(role: 'Data Scientist', demand: 'High', avgDays: 22, submitted: 4, placed: 2),
    _RoleInsight(role: 'Product Manager', demand: 'Moderate', avgDays: 31, submitted: 3, placed: 1),
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
            title: Text('SignalIQ Report',
                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: DropdownButton<String>(
                    value: _period,
                    underline: const SizedBox(),
                    dropdownColor: HireIQTheme.primaryNavy,
                    iconEnabledColor: Colors.white,
                    style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),
                    items: _periods.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                    onChanged: (v) => setState(() => _period = v ?? _period),
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // performance summary
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
                      Row(children: [
                        const Icon(Icons.bar_chart_rounded, color: HireIQTheme.amber, size: 20),
                        const SizedBox(width: 8),
                        Text('$_period Summary', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                      ]),
                      const SizedBox(height: 16),
                      Row(children: [
                        _SumStat('Submissions', '15'),
                        _SumStat('Placements', '8'),
                        _SumStat('Conversion', '53%'),
                        _SumStat('Earnings', 'R105k'),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                Text('Role Performance', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 12),
                ..._roleInsights.map((r) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                      border: Border.all(color: HireIQTheme.borderLight),
                      boxShadow: [BoxShadow(color: HireIQTheme.primaryNavy.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 3))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text(r.role, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: (r.demand == 'Very High' ? HireIQTheme.success : r.demand == 'High' ? HireIQTheme.primaryTeal : HireIQTheme.warning).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                              ),
                              child: Text(r.demand,
                                  style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: r.demand == 'Very High' ? HireIQTheme.success : r.demand == 'High' ? HireIQTheme.primaryTeal : HireIQTheme.warning)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(height: 1, color: HireIQTheme.borderLight),
                        const SizedBox(height: 12),
                        Row(children: [
                          Expanded(child: _InsightStat('Submitted', '${r.submitted}')),
                          Expanded(child: _InsightStat('Placed', '${r.placed}')),
                          Expanded(child: _InsightStat('Avg Days', '${r.avgDays}')),
                          Expanded(child: _InsightStat('Rate', '${(r.placed / r.submitted * 100).round()}%')),
                        ]),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.auto_awesome_rounded, size: 14, color: HireIQTheme.primaryTeal),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'SignalIQ Tip: Focus on Flutter placements this quarter — demand is up 18% vs last quarter and your conversion rate is highest in this category.',
                          style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.primaryTeal, height: 1.45),
                        ),
                      ),
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

class _RoleInsight {
  const _RoleInsight({required this.role, required this.demand, required this.avgDays, required this.submitted, required this.placed});
  final String role;
  final String demand;
  final int avgDays;
  final int submitted;
  final int placed;
}

class _SumStat extends StatelessWidget {
  const _SumStat(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
          Text(label, style: GoogleFonts.inter(fontSize: 10, color: Colors.white.withValues(alpha: 0.5))),
        ],
      ),
    );
  }
}

Widget _InsightStat(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(value, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
      Text(label, style: GoogleFonts.inter(fontSize: 10, color: HireIQTheme.textMuted)),
    ],
  );
}
