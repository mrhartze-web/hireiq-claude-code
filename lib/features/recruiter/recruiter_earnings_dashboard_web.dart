import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class RecruiterEarningsDashboardWeb extends ConsumerWidget {
  const RecruiterEarningsDashboardWeb({super.key});

  static const _placements = [
    _Earn('Thabo Mokoena', 'TechFlow Solutions', 'R105,000', '10%', 'R10,500', 'Mar 2026', HireIQTheme.success),
    _Earn('Priya Naidoo', 'Capitec Bank', 'R115,000', '10%', 'R11,500', 'Feb 2026', HireIQTheme.primaryTeal),
    _Earn('Sipho Dlamini', 'Standard Bank', 'R95,000', '9%', 'R8,550', 'Jan 2026', HireIQTheme.primaryTeal),
    _Earn('Anele Khumalo', 'Discovery', 'R85,000', '8%', 'R6,800', 'Dec 2025', HireIQTheme.primaryNavy),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Earnings Dashboard', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Your placement fees and projected income', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          // Hero earnings card
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [HireIQTheme.primaryNavy, Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Total Earned — 2026', style: GoogleFonts.inter(fontSize: 14, color: Colors.white70)),
                Text('R30,550', style: GoogleFonts.inter(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white)),
                const SizedBox(height: 8),
                Row(children: [const Icon(Icons.trending_up_rounded, color: HireIQTheme.success, size: 16), const SizedBox(width: 4), Text('+22% vs last year', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.success))]),
              ])),
              const SizedBox(width: 24),
              ...[
                ('MTD', 'R10,500'),
                ('QTD', 'R30,550'),
                ('Pipeline', 'R42,000'),
              ].map((s) => Container(margin: const EdgeInsets.only(left: 24), padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(s.$1, style: GoogleFonts.inter(fontSize: 12, color: Colors.white54)),
                Text(s.$2, style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
              ]))),
            ]),
          ),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Monthly bar chart
            Expanded(child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Monthly Earnings', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 20),
                SizedBox(height: 180, child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  ['Oct', 6.8], ['Nov', 8.55], ['Dec', 6.8], ['Jan', 8.55], ['Feb', 11.5], ['Mar', 10.5],
                ].map((m) {
                  final val = m[1] as double;
                  return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text('R${val}k', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                    const SizedBox(height: 4),
                    Container(width: 32, height: val * 12, decoration: BoxDecoration(color: HireIQTheme.primaryTeal, borderRadius: const BorderRadius.vertical(top: Radius.circular(4)))),
                    const SizedBox(height: 6),
                    Text(m[0] as String, style: GoogleFonts.inter(fontSize: 10, color: HireIQTheme.textMuted)),
                  ]);
                }).toList())),
              ]),
            )),
            const SizedBox(width: 24),
            // Placements table
            Expanded(flex: 2, child: Container(
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(children: [
                Padding(padding: const EdgeInsets.all(20), child: Text('Placement History', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), color: HireIQTheme.background, child: Row(children: [_EH('Candidate', 2), _EH('Client', 2), _EH('Salary'), _EH('Fee %'), _EH('Earned'), _EH('Month')])),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                ..._placements.asMap().entries.map((e) {
                  final p = e.value;
                  final isLast = e.key == _placements.length - 1;
                  return Column(children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                      Expanded(flex: 2, child: Text(p.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary))),
                      Expanded(flex: 2, child: Text(p.client, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                      Expanded(child: Text(p.salary, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                      Expanded(child: Text(p.fee, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                      Expanded(child: Text(p.earned, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal))),
                      Expanded(child: Text(p.month, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                    ])),
                    if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                  ]);
                }),
              ]),
            )),
          ]),
        ]),
      ),
    );
  }
}

class _Earn { const _Earn(this.name, this.client, this.salary, this.fee, this.earned, this.month, this.color); final String name, client, salary, fee, earned, month; final Color color; }
Widget _EH(String t, [int flex = 1]) => Expanded(flex: flex, child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
