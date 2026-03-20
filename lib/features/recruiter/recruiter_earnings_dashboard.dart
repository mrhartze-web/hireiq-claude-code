import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class RecruiterEarningsDashboard extends ConsumerWidget {
  const RecruiterEarningsDashboard({super.key});

  static const _placements = [
    _Placement(candidate: 'Sipho van Rooyen', client: 'TechFlow Solutions', commission: 'R36,500', month: 'Mar 2026', status: 'Paid'),
    _Placement(candidate: 'Zanele Mokoena', client: 'OUTsurance', commission: 'R27,000', month: 'Feb 2026', status: 'Paid'),
    _Placement(candidate: 'Thabo Nkosi', client: 'Shoprite Holdings', commission: 'R42,000', month: 'Jan 2026', status: 'Paid'),
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
            title: Text('Earnings',
                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Hero Card
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Earnings — 2026',
                          style: GoogleFonts.inter(fontSize: 12, color: Colors.white.withValues(alpha: 0.6))),
                      const SizedBox(height: 8),
                      Text('R181,500',
                          style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _EStat('3', 'Placements'),
                          Container(width: 1, height: 28, color: Colors.white.withValues(alpha: 0.2), margin: const EdgeInsets.symmetric(horizontal: 20)),
                          _EStat('R60,500', 'Current Quarter'),
                          Container(width: 1, height: 28, color: Colors.white.withValues(alpha: 0.2), margin: const EdgeInsets.symmetric(horizontal: 20)),
                          _EStat('R36,500', 'This Month'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                Text('Recent Placements',
                    style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: HireIQTheme.surfaceWhite,
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                    border: Border.all(color: HireIQTheme.borderLight),
                    boxShadow: [BoxShadow(color: HireIQTheme.primaryNavy.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 3))],
                  ),
                  child: Column(
                    children: _placements.asMap().entries.map((e) {
                      final isLast = e.key == _placements.length - 1;
                      final p = e.value;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(p.candidate,
                                          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                                      Text('${p.client} • ${p.month}',
                                          style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(p.commission,
                                        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: HireIQTheme.success)),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: HireIQTheme.success.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                                      ),
                                      child: Text(p.status,
                                          style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: HireIQTheme.success)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),

                // Quarterly targets
                Text('Quarterly Target',
                    style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: HireIQTheme.surfaceWhite,
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                    border: Border.all(color: HireIQTheme.borderLight),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Q1 2026 Progress',
                              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)),
                          Text('60.5%',
                              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      LayoutBuilder(
                        builder: (context, constraints) => Stack(
                          children: [
                            Container(height: 10, decoration: BoxDecoration(color: HireIQTheme.borderLight, borderRadius: BorderRadius.circular(5))),
                            Container(height: 10, width: constraints.maxWidth * 0.605, decoration: BoxDecoration(color: HireIQTheme.primaryTeal, borderRadius: BorderRadius.circular(5))),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('R60,500 earned', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                          Text('Target: R100,000', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                        ],
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

class _Placement {
  const _Placement({required this.candidate, required this.client, required this.commission, required this.month, required this.status});
  final String candidate;
  final String client;
  final String commission;
  final String month;
  final String status;
}

class _EStat extends StatelessWidget {
  const _EStat(this.value, this.label);
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
        Text(label, style: GoogleFonts.inter(fontSize: 10, color: Colors.white.withValues(alpha: 0.5))),
      ],
    );
  }
}
