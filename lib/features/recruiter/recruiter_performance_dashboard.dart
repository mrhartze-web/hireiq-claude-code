import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class RecruiterPerformanceDashboard extends ConsumerWidget {
  const RecruiterPerformanceDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            title: Text('Performance',
                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Grade card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [HireIQTheme.primaryNavy, Color(0xFF243659)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Your MatchIQ Performance Grade',
                                style: GoogleFonts.inter(fontSize: 13, color: Colors.white.withValues(alpha: 0.65))),
                            const SizedBox(height: 10),
                            Text('A+',
                                style: GoogleFonts.inter(fontSize: 52, fontWeight: FontWeight.w900, color: HireIQTheme.amber)),
                            const SizedBox(height: 4),
                            Text('Top 8% of all recruiters on HireIQ SA',
                                style: GoogleFonts.inter(fontSize: 12, color: Colors.white.withValues(alpha: 0.55))),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.06),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.emoji_events_rounded, size: 40, color: HireIQTheme.amber),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                Text('Performance Metrics',
                    style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.4,
                  children: const [
                    _PMetric(label: 'Placement Rate', value: '87%', sub: 'vs 64% avg', positive: true),
                    _PMetric(label: 'Client Satisfaction', value: '4.9/5', sub: '23 reviews', positive: true),
                    _PMetric(label: 'Avg. Time to Fill', value: '18 days', sub: 'vs 28 avg', positive: true),
                    _PMetric(label: 'Candidate Retention', value: '92%', sub: '12 month mark', positive: true),
                  ],
                ),
                const SizedBox(height: 24),

                Text('Badges Earned',
                    style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _Badge('🏆', 'Top Placer Q1 2026'),
                    _Badge('⚡', 'Speed Filler'),
                    _Badge('🎯', 'Precision Matcher'),
                    _Badge('🌟', 'Client Favourite'),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _PMetric extends StatelessWidget {
  const _PMetric({required this.label, required this.value, required this.sub, required this.positive});
  final String label;
  final String value;
  final String sub;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [BoxShadow(color: HireIQTheme.primaryNavy.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(value, style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: HireIQTheme.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
            ),
            child: Text(sub, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: HireIQTheme.success)),
          ),
        ],
      ),
    );
  }
}

Widget _Badge(String emoji, String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: HireIQTheme.amber.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
      border: Border.all(color: HireIQTheme.amber.withValues(alpha: 0.3)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        Text(label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
      ],
    ),
  );
}
