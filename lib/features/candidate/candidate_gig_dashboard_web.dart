import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateGigDashboardWeb extends ConsumerStatefulWidget {
  const CandidateGigDashboardWeb({super.key});
  @override
  ConsumerState<CandidateGigDashboardWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateGigDashboardWeb> {
  String _filter = 'All';
  final _filters = ['All', 'Remote', 'On-site', 'Short-term', 'Long-term'];

  static const _gigs = [
    _Gig('React Native Developer', 'TechFlow Solutions', 'Cape Town · Remote', 'R65k–R85k', '3 months', 92),
    _Gig('Flutter Consultant', 'Capitec Bank', 'Stellenbosch · Hybrid', 'R80k–R100k', '6 months', 88),
    _Gig('Mobile Engineer', 'OUTsurance', 'Johannesburg · Remote', 'R75k–R95k', '4 months', 85),
    _Gig('iOS Developer', 'Discovery Health', 'Cape Town · On-site', 'R70k–R90k', '3 months', 79),
    _Gig('Android Developer', 'Standard Bank', 'Johannesburg · Hybrid', 'R65k–R80k', '5 months', 74),
    _Gig('Cross-Platform Developer', 'Shoprite Holdings', 'Durban · Remote', 'R60k–R80k', '2 months', 70),
  ];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left sidebar filters
          SizedBox(width: 220, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Gig Marketplace', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Type', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 12),
                ..._filters.map((f) => GestureDetector(
                  onTap: () => setState(() => _filter = f),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: _filter == f ? HireIQTheme.primaryNavy.withValues(alpha: 0.05) : null, borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)),
                    child: Row(children: [
                      Icon(Icons.circle, size: 8, color: _filter == f ? HireIQTheme.primaryTeal : HireIQTheme.borderMedium),
                      const SizedBox(width: 8),
                      Text(f, style: GoogleFonts.inter(fontSize: 13, fontWeight: _filter == f ? FontWeight.w700 : FontWeight.w400, color: _filter == f ? HireIQTheme.primaryNavy : HireIQTheme.textMuted)),
                    ]),
                  ),
                )),
                const SizedBox(height: 16),
                Text('Duration', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 8),
                RangeSlider(values: const RangeValues(1, 6), min: 1, max: 12, divisions: 11, onChanged: (_) {}, activeColor: HireIQTheme.primaryTeal),
                Text('1 – 6 months', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
              ]),
            ),
          ])),
          const SizedBox(width: 24),
          // Right: gig grid
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text('${_gigs.length} gigs found', style: GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textMuted)),
              const Spacer(),
              TextField(decoration: InputDecoration(prefixIcon: const Icon(Icons.search_rounded, size: 18, color: HireIQTheme.textMuted), hintText: 'Search gigs...', contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), constraints: const BoxConstraints(maxWidth: 280))),
            ]),
            const SizedBox(height: 16),
            LayoutBuilder(builder: (ctx, constraints) {
              const spacing = 16.0;
              const cols = 3;
              final width = (constraints.maxWidth - spacing * (cols - 1)) / cols;
              return Wrap(spacing: spacing, runSpacing: spacing, children: _gigs.map((g) => SizedBox(width: width, child: _GigCard(g))).toList());
            }),
          ])),
        ]),
      ),
    );
  }
}

class _GigCard extends StatelessWidget {
  const _GigCard(this.gig);
  final _Gig gig;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), child: Center(child: Text(gig.company.substring(0, 2), style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(gig.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
            Text(gig.company, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
          ])),
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Row(children: [const Icon(Icons.auto_awesome_rounded, size: 10, color: HireIQTheme.primaryTeal), const SizedBox(width: 3), Text('${gig.matchiq}%', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))])),
          ]),
        const SizedBox(height: 14),
        Row(children: [const Icon(Icons.location_on_outlined, size: 12, color: HireIQTheme.textMuted), const SizedBox(width: 4), Expanded(child: Text(gig.location, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)))]),
        const SizedBox(height: 4),
        Row(children: [const Icon(Icons.access_time_rounded, size: 12, color: HireIQTheme.textMuted), const SizedBox(width: 4), Text(gig.duration, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))]),
        const SizedBox(height: 12),
        Text(gig.rate, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('View & Apply', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)))),
      ]),
    );
  }
}

class _Gig { const _Gig(this.title, this.company, this.location, this.rate, this.duration, this.matchiq); final String title, company, location, rate, duration; final int matchiq; }
