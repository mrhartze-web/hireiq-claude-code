import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class RecruiterCandidateSearchWeb extends ConsumerStatefulWidget {
  const RecruiterCandidateSearchWeb({super.key});
  @override
  ConsumerState<RecruiterCandidateSearchWeb> createState() => _State();
}

class _State extends ConsumerState<RecruiterCandidateSearchWeb> {
  int _selected = 0;

  static const _candidates = [
    _RC('Thabo Mokoena', 'Senior Flutter Developer', 'Cape Town', 94, 'Available'),
    _RC('Sipho Dlamini', 'Mobile Engineer', 'Johannesburg', 88, 'Available'),
    _RC('Anele Khumalo', 'Lead Flutter Dev', 'Cape Town', 85, 'Passive'),
    _RC('Priya Naidoo', 'Frontend Developer', 'Durban', 81, 'Available'),
  ];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Filters
          SizedBox(width: 230, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Target Candidates', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 14),
            TextField(decoration: InputDecoration(prefixIcon: const Icon(Icons.search_rounded, size: 16), hintText: 'Search...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14))),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Filters', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 10),
                Text('Status', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)),
                ...['Available', 'Passive', 'Interviewing'].map((f) => CheckboxListTile(value: f == 'Available', onChanged: (_) {}, title: Text(f, style: GoogleFonts.inter(fontSize: 12)), contentPadding: EdgeInsets.zero, controlAffinity: ListTileControlAffinity.leading, dense: true, activeColor: HireIQTheme.primaryTeal)),
                const Divider(color: HireIQTheme.borderLight, height: 20),
                Text('MatchIQ ≥', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)),
                Slider(value: 80, min: 0, max: 100, onChanged: (_) {}, activeColor: HireIQTheme.primaryTeal),
                Text('80%+', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
              ]),
            ),
          ])),
          const SizedBox(width: 20),
          // List
          SizedBox(width: 340, child: Column(children: _candidates.asMap().entries.map((e) {
            final c = e.value;
            final isSelected = e.key == _selected;
            return GestureDetector(
              onTap: () => setState(() => _selected = e.key),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: isSelected ? HireIQTheme.primaryTeal : HireIQTheme.borderLight, width: isSelected ? 2 : 1)),
                child: Row(children: [
                  CircleAvatar(radius: 20, backgroundColor: HireIQTheme.primaryNavy, child: Text(c.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white))),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(c.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                    Text(c.role, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                    Text(c.location, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                  ])),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('${c.matchiq}%', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))),
                ]),
              ),
            );
          }).toList())),
          const SizedBox(width: 20),
          // Preview
          Expanded(child: (() {
            final c = _candidates[_selected];
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CircleAvatar(radius: 32, backgroundColor: HireIQTheme.primaryNavy, child: Text(c.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white))),
                const SizedBox(height: 14),
                Text(c.name, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
                Text(c.role, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)),
                Text(c.location, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                const SizedBox(height: 14),
                Row(children: [
                  const Icon(Icons.auto_awesome_rounded, color: HireIQTheme.primaryTeal, size: 14),
                  const SizedBox(width: 4),
                  Text('${c.matchiq}% MatchIQ', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
                  const SizedBox(width: 16),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(c.status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.success))),
                ]),
                const SizedBox(height: 20),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 13), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Submit to Client', style: GoogleFonts.inter(fontWeight: FontWeight.w700)))),
                const SizedBox(height: 10),
                SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.borderMedium), padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Add to CV Vault', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)))),
              ]),
            );
          })()),
        ]),
      ),
    );
  }
}

class _RC { const _RC(this.name, this.role, this.location, this.matchiq, this.status); final String name, role, location, status; final int matchiq; }
