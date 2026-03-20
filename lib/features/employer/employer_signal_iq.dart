import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerSignalIq extends ConsumerWidget {
  const EmployerSignalIq({super.key});

  static const _signals = [
    _Signal(
      role: 'Senior Flutter Developer',
      demand: 'Very High',
      demandTrend: '+12% MoM',
      medianSalary: 'R65,000/month',
      candidatePool: 234,
      timeToHire: '21 days',
    ),
    _Signal(
      role: 'Data Scientist',
      demand: 'High',
      demandTrend: '+8% MoM',
      medianSalary: 'R72,000/month',
      candidatePool: 148,
      timeToHire: '28 days',
    ),
    _Signal(
      role: 'Product Manager',
      demand: 'Moderate',
      demandTrend: '+3% MoM',
      medianSalary: 'R85,000/month',
      candidatePool: 92,
      timeToHire: '35 days',
    ),
  ];

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
            title: Text(
              'SignalIQ Intelligence',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: HireIQTheme.primaryTeal.withValues(alpha: 0.2),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusFull),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.wifi_rounded,
                            size: 12, color: HireIQTheme.primaryTeal),
                        const SizedBox(width: 4),
                        Text(
                          'Live',
                          style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: HireIQTheme.primaryTeal),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Market Overview ───────────────────────────────────────
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
                          const Icon(Icons.trending_up_rounded,
                              color: HireIQTheme.amber, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'SA Tech Hiring Market',
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          _MarketStat(
                              label: 'Market Temp',
                              value: '🔥 Hot'),
                          _MarketStat(
                              label: 'Open Roles',
                              value: '4,823'),
                          _MarketStat(
                              label: 'Avg. Salary',
                              value: 'R61k'),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        '📌 Demand for Flutter developers in Cape Town is outpacing supply. Post your role with MatchIQ to attract top talent faster.',
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.7),
                            height: 1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Role Signals ──────────────────────────────────────────
                Text(
                  'Role Intelligence',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 12),
                ..._signals.map((s) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _SignalCard(signal: s),
                    )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Signal {
  const _Signal({
    required this.role,
    required this.demand,
    required this.demandTrend,
    required this.medianSalary,
    required this.candidatePool,
    required this.timeToHire,
  });

  final String role;
  final String demand;
  final String demandTrend;
  final String medianSalary;
  final int candidatePool;
  final String timeToHire;
}

class _MarketStat extends StatelessWidget {
  const _MarketStat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.white),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.inter(
                fontSize: 10,
                color: Colors.white.withValues(alpha: 0.5)),
          ),
        ],
      ),
    );
  }
}

class _SignalCard extends StatelessWidget {
  const _SignalCard({required this.signal});
  final _Signal signal;

  Color get _demandColor {
    switch (signal.demand) {
      case 'Very High':
        return HireIQTheme.success;
      case 'High':
        return HireIQTheme.primaryTeal;
      case 'Moderate':
        return HireIQTheme.warning;
      default:
        return HireIQTheme.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
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
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  signal.role,
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _demandColor.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  signal.demand,
                  style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: _demandColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: HireIQTheme.borderLight),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 3.5,
            children: [
              _SignalStat('Median Salary', signal.medianSalary),
              _SignalStat('Demand Trend', signal.demandTrend),
              _SignalStat('Candidate Pool', signal.candidatePool.toString()),
              _SignalStat('Avg Time to Hire', signal.timeToHire),
            ],
          ),
        ],
      ),
    );
  }
}

class _SignalStat extends StatelessWidget {
  const _SignalStat(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.primaryNavy),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
              fontSize: 10, color: HireIQTheme.textMuted),
        ),
      ],
    );
  }
}
