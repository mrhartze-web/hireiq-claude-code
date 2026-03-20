import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class RecruiterPlacementTrackerWeb extends ConsumerWidget {
  const RecruiterPlacementTrackerWeb({super.key});

  static const _placements = [
    _Placement('Ruan van Niekerk', 'DevOps Engineer', 'Capitec Bank', 'Feb 2026', 'R95,000', 'R11,400', '3 months guarantee', 'Active'),
    _Placement('Priya Naidoo', 'Product Manager', 'Standard Bank', 'Jan 2026', 'R115,000', 'R11,500', '3 months guarantee', 'Active'),
    _Placement('Sipho Dlamini', 'Flutter Developer', 'TechFlow', 'Dec 2025', 'R85,000', 'R7,650', 'Guarantee expired', 'Clear'),
    _Placement('Ayanda Nkosi', 'UI/UX Designer', 'Nedbank', 'Nov 2025', 'R80,000', 'R7,200', 'Guarantee expired', 'Clear'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Placement Tracker', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Track all confirmed placements and guarantee periods', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          Row(children: [
            _PStat('Total Placements', '4', HireIQTheme.primaryNavy, Icons.handshake_rounded),
            const SizedBox(width: 16),
            _PStat('In Guarantee Period', '2', HireIQTheme.warning, Icons.shield_rounded),
            const SizedBox(width: 16),
            _PStat('Guarantee Clear', '2', HireIQTheme.success, Icons.verified_rounded),
            const SizedBox(width: 16),
            _PStat('Total Fees Earned', 'R37,750', HireIQTheme.primaryTeal, Icons.savings_rounded),
          ]),
          const SizedBox(height: 28),
          Container(
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), color: HireIQTheme.background, child: Row(children: [_PTH('Candidate', 2), _PTH('Role', 2), _PTH('Client', 2), _PTH('Start Date'), _PTH('Salary'), _PTH('Fee Earned'), _PTH('Guarantee'), _PTH('Status')])),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              ..._placements.asMap().entries.map((e) {
                final p = e.value;
                final isLast = e.key == _placements.length - 1;
                final isActive = p.status == 'Active';
                return Column(children: [
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                    Expanded(flex: 2, child: Text(p.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary))),
                    Expanded(flex: 2, child: Text(p.role, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                    Expanded(flex: 2, child: Text(p.client, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                    Expanded(child: Text(p.startDate, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
                    Expanded(child: Text(p.salary, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textPrimary))),
                    Expanded(child: Text(p.fee, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal))),
                    Expanded(child: Text(p.guarantee, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))),
                    Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: isActive ? HireIQTheme.warning.withValues(alpha: 0.1) : HireIQTheme.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(p.status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: isActive ? HireIQTheme.warning : HireIQTheme.success)))),
                  ])),
                  if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                ]);
              }),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _Placement { const _Placement(this.name, this.role, this.client, this.startDate, this.salary, this.fee, this.guarantee, this.status); final String name, role, client, startDate, salary, fee, guarantee, status; }
Widget _PStat(String l, String v, Color c, IconData icon) => Expanded(child: Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Row(children: [Icon(icon, color: c, size: 20), const SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(v, style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: c)), Text(l, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))])])));
Widget _PTH(String t, [int flex = 1]) => Expanded(flex: flex, child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
