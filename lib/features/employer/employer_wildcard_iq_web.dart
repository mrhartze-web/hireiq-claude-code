import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerWildcardIqWeb extends ConsumerWidget {
  const EmployerWildcardIqWeb({super.key});

  static const _wildcards = [
    _WC('Lerato Sithole', 'Project Manager → likely strong people leader', 'Johannesburg', 91, 'Culture Fit'),
    _WC('Ayanda Dlamini', 'Teacher → analytical + communication skills', 'Cape Town', 87, 'Transferable Skills'),
    _WC('Ruan van Niekerk', 'Ex-Founder → entrepreneurial mindset at scale', 'Cape Town', 83, 'Growth Potential'),
    _WC('Khaya Mthembu', 'UX Researcher → user empathy for product roles', 'Johannesburg', 79, 'Adjacent Role'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('WildcardIQ', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('AI-discovered unconventional candidates who could be your best hires', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.2))), child: Row(children: [const Icon(Icons.auto_awesome_rounded, size: 14, color: HireIQTheme.primaryTeal), const SizedBox(width: 6), Text('AI confidence: High', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))])),
          ]),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: HireIQTheme.amber.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.amber.withValues(alpha: 0.2))),
            child: Row(children: [const Icon(Icons.lightbulb_rounded, color: HireIQTheme.amber, size: 22), const SizedBox(width: 12), Expanded(child: Text('WildcardIQ finds candidates who don\'t match your role on paper but have exceptional transferable skills, cultural fit, or growth potential that traditional filtering would miss.', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted, height: 1.55)))]),
          ),
          const SizedBox(height: 28),
          LayoutBuilder(builder: (ctx, constraints) {
            const cols = 2;
            const spacing = 16.0;
            final width = (constraints.maxWidth - spacing * (cols - 1)) / cols;
            return Wrap(spacing: spacing, runSpacing: spacing, children: _wildcards.map((wc) => SizedBox(width: width, child: _WCCard(wc))).toList());
          }),
        ]),
      ),
    );
  }
}

class _WCCard extends StatelessWidget {
  const _WCCard(this.wc);
  final _WC wc;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(radius: 24, backgroundColor: HireIQTheme.primaryNavy, child: Text(wc.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white))),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(wc.name, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
            Text(wc.location, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
          ])),
          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Row(children: [const Icon(Icons.auto_awesome_rounded, size: 11, color: HireIQTheme.primaryTeal), const SizedBox(width: 4), Text('${wc.match}%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))])),
        ]),
        const SizedBox(height: 14),
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: HireIQTheme.amber.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(wc.reason, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.amber))),
        const SizedBox(height: 10),
        Text(wc.rationale, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.55)),
        const SizedBox(height: 14),
        Row(children: [
          Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('View Profile', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)))),
          const SizedBox(width: 10),
          Expanded(child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.primaryNavy), padding: const EdgeInsets.symmetric(vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Contact', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)))),
        ]),
      ]),
    );
  }
}

class _WC { const _WC(this.name, this.rationale, this.location, this.match, this.reason); final String name, rationale, location, reason; final int match; }
