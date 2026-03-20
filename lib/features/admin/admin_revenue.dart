import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class AdminRevenue extends ConsumerWidget {
  const AdminRevenue({super.key});

  static const _breakdown = [
    _BreakdownItem('Candidate Subscriptions', 0.31, HireIQTheme.primaryTeal),
    _BreakdownItem('Employer Subscriptions', 0.28, HireIQTheme.primaryNavy),
    _BreakdownItem('Recruiter Subscriptions', 0.12, Color(0xFF7C3AED)),
    _BreakdownItem('Placement Fees', 0.19, HireIQTheme.amber),
    _BreakdownItem('Gig Commissions', 0.10, HireIQTheme.success),
  ];

  static const _months = ['Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar'];
  static const _monthValues = [74200.0, 85600.0, 96400.0, 105800.0, 116200.0, 127450.0];

  static const _topEmployers = [
    _TopEmployer('TechFlow Solutions', 'Enterprise', 'R18,500'),
    _TopEmployer('OUTsurance', 'Growth', 'R12,400'),
    _TopEmployer('Shoprite Holdings', 'Enterprise', 'R16,200'),
    _TopEmployer('Capitec Bank', 'Growth', 'R11,800'),
    _TopEmployer('Standard Bank', 'Enterprise', 'R20,100'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxVal = _monthValues.reduce((a, b) => a > b ? a : b);
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('Revenue Dashboard', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // MRR / ARR hero
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [HireIQTheme.primaryNavy, Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Monthly Recurring Revenue', style: GoogleFonts.inter(fontSize: 12, color: Colors.white.withValues(alpha: 0.6))),
              const SizedBox(height: 4),
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text('R127,450', style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white)),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: HireIQTheme.success.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
                  child: Row(children: [
                    const Icon(Icons.arrow_upward_rounded, size: 12, color: HireIQTheme.success),
                    const SizedBox(width: 2),
                    Text('+12%', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.success)),
                  ]),
                ),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                const Icon(Icons.calendar_today_rounded, size: 13, color: Colors.white54),
                const SizedBox(width: 6),
                Text('ARR Projection: R1,529,400', style: GoogleFonts.inter(fontSize: 13, color: Colors.white70)),
              ]),
            ]),
          ),
          const SizedBox(height: 24),

          // Revenue Breakdown
          Text('Revenue Breakdown', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(children: _breakdown.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Text(item.label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: HireIQTheme.textPrimary))),
                  Text('${(item.share * 100).round()}%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: item.color)),
                ]),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                  child: LinearProgressIndicator(
                    value: item.share,
                    minHeight: 8,
                    backgroundColor: HireIQTheme.borderLight,
                    valueColor: AlwaysStoppedAnimation<Color>(item.color),
                  ),
                ),
              ]),
            )).toList()),
          ),
          const SizedBox(height: 24),

          // Monthly bar chart
          Text('Monthly Trend (Last 6 Months)', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: List.generate(_months.length, (i) {
              final height = (_monthValues[i] / maxVal) * 120;
              final isLast = i == _months.length - 1;
              return Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: isLast ? HireIQTheme.primaryTeal : HireIQTheme.primaryNavy.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(_months[i], style: GoogleFonts.inter(fontSize: 10, color: isLast ? HireIQTheme.primaryNavy : HireIQTheme.textMuted)),
                ]),
              ));
            })),
          ),
          const SizedBox(height: 24),

          // Top Employers
          Text('Top 5 Paying Employers', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(children: _topEmployers.asMap().entries.map((e) {
              final isLast = e.key == _topEmployers.length - 1;
              final emp = e.value;
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(children: [
                    Text('${e.key + 1}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: HireIQTheme.textMuted)),
                    const SizedBox(width: 12),
                    Expanded(child: Text(emp.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
                      child: Text(emp.plan, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
                    ),
                    const SizedBox(width: 10),
                    Text(emp.mrr, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
                  ]),
                ),
                if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
              ]);
            }).toList()),
          ),
          const SizedBox(height: 24),

          // Peach Payments settlement
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: HireIQTheme.amber.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
              border: Border.all(color: HireIQTheme.amber.withValues(alpha: 0.3)),
            ),
            child: Row(children: [
              const Icon(Icons.account_balance_wallet_rounded, color: HireIQTheme.amber, size: 22),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Peach Payments Settlement', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                Text('Next settlement: 25 Mar 2026', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
              ])),
              Text('R112,840', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _BreakdownItem {
  const _BreakdownItem(this.label, this.share, this.color);
  final String label;
  final double share;
  final Color color;
}

class _TopEmployer {
  const _TopEmployer(this.name, this.plan, this.mrr);
  final String name, plan, mrr;
}
