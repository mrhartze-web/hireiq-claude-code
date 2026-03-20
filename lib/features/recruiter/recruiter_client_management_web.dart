import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class RecruiterClientManagementWeb extends ConsumerWidget {
  const RecruiterClientManagementWeb({super.key});

  static const _clients = [
    _Client('TechFlow Solutions', 'Fintech', 'Thabo M.', '3 Active', 'R180,000'),
    _Client('Capitec Bank', 'Banking', 'Lindiwe N.', '2 Active', 'R120,000'),
    _Client('Standard Bank', 'Banking', 'Sipho D.', '1 Active', 'R95,000'),
    _Client('Nedbank', 'Banking', 'Priya K.', '0 Active', 'R48,000'),
    _Client('Discovery', 'Insurance', 'Anele B.', '1 Active', 'R75,000'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Client Management', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('${_clients.length} clients · R518,000 total billings', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, size: 16), label: Text('Add Client', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
          ]),
          const SizedBox(height: 28),
          LayoutBuilder(builder: (ctx, constraints) {
            const cols = 3;
            const spacing = 16.0;
            final width = (constraints.maxWidth - spacing * (cols - 1)) / cols;
            return Wrap(spacing: spacing, runSpacing: spacing, children: _clients.map((c) => SizedBox(width: width, child: _ClientCard(c))).toList());
          }),
        ]),
      ),
    );
  }
}

class _ClientCard extends StatelessWidget {
  const _ClientCard(this.client);
  final _Client client;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: HireIQTheme.primaryNavy, borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), child: Center(child: Text(client.name.substring(0, 2), style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white)))),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(client.name, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
            Text(client.industry, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
          ])),
          IconButton(icon: const Icon(Icons.more_vert_rounded, size: 16, color: HireIQTheme.textMuted), onPressed: () {}),
        ]),
        const SizedBox(height: 12),
        Row(children: [const Icon(Icons.person_outlined, size: 12, color: HireIQTheme.textMuted), const SizedBox(width: 4), Text('Contact: ${client.contact}', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))]),
        const SizedBox(height: 8),
        const Divider(color: HireIQTheme.borderLight),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Briefs', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)), Text(client.briefs, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))])),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Billings', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)), Text(client.billings, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))])),
        ]),
        const SizedBox(height: 14),
        SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.primaryNavy), padding: const EdgeInsets.symmetric(vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('View Briefs', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)))),
      ]),
    );
  }
}

class _Client { const _Client(this.name, this.industry, this.contact, this.briefs, this.billings); final String name, industry, contact, briefs, billings; }
