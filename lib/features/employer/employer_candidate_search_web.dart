import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerCandidateSearchWeb extends ConsumerStatefulWidget {
  const EmployerCandidateSearchWeb({super.key});
  @override
  ConsumerState<EmployerCandidateSearchWeb> createState() => _State();
}

class _State extends ConsumerState<EmployerCandidateSearchWeb> {
  int _selected = 0;

  static const _candidates = [
    _CandS('Thabo Mokoena', 'Senior Flutter Developer', 'Cape Town', 'R95k/mo', 94, 'Available', ['Flutter', 'Dart', 'Firebase']),
    _CandS('Sipho Dlamini', 'Mobile Engineer', 'Johannesburg', 'R85k/mo', 88, 'Available', ['Swift', 'Kotlin', 'Flutter']),
    _CandS('Anele Khumalo', 'Lead Flutter Dev', 'Cape Town', 'R110k/mo', 85, 'Interviewing', ['Flutter', 'BLoC', 'Riverpod']),
    _CandS('Priya Naidoo', 'Frontend Developer', 'Durban', 'R75k/mo', 81, 'Available', ['React', 'TypeScript', 'CSS']),
    _CandS('Nomvula Sithole', 'Full Stack Developer', 'Cape Town', 'R90k/mo', 78, 'Available', ['Node', 'Flutter', 'SQL']),
  ];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left: filters
          SizedBox(width: 240, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Search Candidates', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(prefixIcon: const Icon(Icons.search_rounded, size: 18), hintText: 'Search...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14))),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Filters', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 12),
                Text('Availability', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.textMuted)),
                ...['Available', 'Open to offers', 'Actively looking'].map((f) => CheckboxListTile(value: f == 'Available', onChanged: (_) {}, title: Text(f, style: GoogleFonts.inter(fontSize: 12)), contentPadding: EdgeInsets.zero, controlAffinity: ListTileControlAffinity.leading, dense: true, activeColor: HireIQTheme.primaryTeal)),
                const Divider(color: HireIQTheme.borderLight),
                Text('Location', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.textMuted)),
                ...['Cape Town', 'Johannesburg', 'Durban', 'Remote'].map((l) => CheckboxListTile(value: l == 'Cape Town', onChanged: (_) {}, title: Text(l, style: GoogleFonts.inter(fontSize: 12)), contentPadding: EdgeInsets.zero, controlAffinity: ListTileControlAffinity.leading, dense: true, activeColor: HireIQTheme.primaryTeal)),
                const Divider(color: HireIQTheme.borderLight),
                Text('MatchIQ Minimum', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.textMuted)),
                Slider(value: 75, min: 0, max: 100, onChanged: (_) {}, activeColor: HireIQTheme.primaryTeal),
                Text('75%+', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
              ]),
            ),
          ])),
          const SizedBox(width: 20),
          // Centre: candidate list
          SizedBox(width: 360, child: Column(children: _candidates.asMap().entries.map((e) {
            final c = e.value;
            final isSelected = e.key == _selected;
            return GestureDetector(
              onTap: () => setState(() => _selected = e.key),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: isSelected ? HireIQTheme.primaryTeal : HireIQTheme.borderLight, width: isSelected ? 2 : 1)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    CircleAvatar(radius: 20, backgroundColor: HireIQTheme.primaryNavy, child: Text(c.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white))),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(c.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                      Text(c.role, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                    ])),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('${c.matchiq}%', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))),
                  ]),
                  const SizedBox(height: 8),
                  Row(children: [const Icon(Icons.location_on_outlined, size: 12, color: HireIQTheme.textMuted), const SizedBox(width: 4), Text(c.location, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)), const Spacer(), Text(c.salary, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))]),
                ]),
              ),
            );
          }).toList())),
          const SizedBox(width: 20),
          // Right: candidate preview
          Expanded(child: (() {
            final c = _candidates[_selected];
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CircleAvatar(radius: 36, backgroundColor: HireIQTheme.primaryNavy, child: Text(c.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white))),
                const SizedBox(height: 14),
                Text(c.name, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
                Text(c.role, style: GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textMuted)),
                const SizedBox(height: 14),
                Row(children: [const Icon(Icons.auto_awesome_rounded, color: HireIQTheme.primaryTeal, size: 16), const SizedBox(width: 4), Text('${c.matchiq}% MatchIQ', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))]),
                const SizedBox(height: 14),
                Text('Skills', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 8),
                Wrap(spacing: 8, runSpacing: 8, children: c.skills.map((s) => Chip(label: Text(s, style: GoogleFonts.inter(fontSize: 12)), backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.08), side: BorderSide(color: HireIQTheme.primaryTeal.withValues(alpha: 0.3)), padding: EdgeInsets.zero)).toList()),
                const SizedBox(height: 20),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Contact Candidate', style: GoogleFonts.inter(fontWeight: FontWeight.w700)))),
                const SizedBox(height: 10),
                SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.borderMedium), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('View Full Profile', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)))),
              ]),
            );
          })()),
        ]),
      ),
    );
  }
}

class _CandS { const _CandS(this.name, this.role, this.location, this.salary, this.matchiq, this.availability, this.skills); final String name, role, location, salary, availability; final int matchiq; final List<String> skills; }
