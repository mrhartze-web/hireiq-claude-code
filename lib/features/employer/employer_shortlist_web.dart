import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerShortlistWeb extends ConsumerWidget {
  const EmployerShortlistWeb({super.key});

  static const _candidates = [
    _ShortC('Thabo Mokoena', 'Senior Flutter Dev', 94, 'Cape Town', 'R95k/mo', true),
    _ShortC('Sipho Dlamini', 'Senior Flutter Dev', 88, 'Johannesburg', 'R85k/mo', false),
    _ShortC('Anele Khumalo', 'Lead Flutter Dev', 85, 'Cape Town', 'R110k/mo', true),
    _ShortC('Nomvula Sithole', 'Full Stack Dev', 81, 'Cape Town', 'R90k/mo', false),
    _ShortC('Ayanda Nkosi', 'Flutter Developer', 78, 'Durban', 'R75k/mo', false),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('My Shortlist', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('${_candidates.length} candidates shortlisted for Senior Flutter Developer', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.share_rounded, size: 14), label: Text('Share Shortlist', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)), style: OutlinedButton.styleFrom(foregroundColor: HireIQTheme.primaryNavy, side: const BorderSide(color: HireIQTheme.borderMedium), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
            const SizedBox(width: 12),
            ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.send_rounded, size: 14), label: Text('Invite All to Interview', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
          ]),
          const SizedBox(height: 28),
          LayoutBuilder(builder: (ctx, constraints) {
            const cols = 3;
            const spacing = 16.0;
            final width = (constraints.maxWidth - spacing * (cols - 1)) / cols;
            return Wrap(spacing: spacing, runSpacing: spacing, children: _candidates.map((c) => SizedBox(width: width, child: _ShortCard(c))).toList());
          }),
        ]),
      ),
    );
  }
}

class _ShortCard extends StatelessWidget {
  const _ShortCard(this.c);
  final _ShortC c;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: c.featured ? HireIQTheme.amber.withValues(alpha: 0.4) : HireIQTheme.borderLight)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (c.featured) Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.amber.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('⭐  Top Pick', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.amber))),
        Row(children: [
          CircleAvatar(radius: 24, backgroundColor: HireIQTheme.primaryNavy, child: Text(c.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(c.name, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
            Text(c.role, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
          ])),
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Row(children: [const Icon(Icons.auto_awesome_rounded, size: 10, color: HireIQTheme.primaryTeal), const SizedBox(width: 3), Text('${c.matchiq}%', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))])),
        ]),
        const SizedBox(height: 12),
        Row(children: [const Icon(Icons.location_on_outlined, size: 12, color: HireIQTheme.textMuted), const SizedBox(width: 4), Text(c.location, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))]),
        const SizedBox(height: 4),
        Text(c.salary, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
        const SizedBox(height: 14),
        Row(children: [
          Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Invite', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)))),
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18, color: HireIQTheme.error), onPressed: () {}),
        ]),
      ]),
    );
  }
}

class _ShortC { const _ShortC(this.name, this.role, this.matchiq, this.location, this.salary, this.featured); final String name, role, location, salary; final int matchiq; final bool featured; }
