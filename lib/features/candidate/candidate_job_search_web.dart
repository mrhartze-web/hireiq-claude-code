import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateJobSearchWeb extends ConsumerStatefulWidget {
  const CandidateJobSearchWeb({super.key});
  @override
  ConsumerState<CandidateJobSearchWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateJobSearchWeb> {
  int _selected = 0;

  static const _jobs = [
    _JItem('Senior Flutter Developer', 'TechFlow Solutions', 'Cape Town · Hybrid', 'R85k–R120k', 94, 'Posted 2d ago'),
    _JItem('Lead Mobile Engineer', 'Capitec Bank', 'Stellenbosch · On-site', 'R95k–R130k', 88, 'Posted 3d ago'),
    _JItem('Software Engineer III', 'Standard Bank', 'Johannesburg · Remote', 'R80k–R115k', 82, 'Posted 5d ago'),
    _JItem('React Native Developer', 'OUTsurance', 'Cape Town · Hybrid', 'R75k–R100k', 79, 'Posted 1w ago'),
    _JItem('Frontend Developer', 'Nedbank', 'Johannesburg · On-site', 'R65k–R90k', 74, 'Posted 1w ago'),
  ];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left: filter panel
          SizedBox(width: 240, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Job Search', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(prefixIcon: const Icon(Icons.search_rounded, size: 18, color: HireIQTheme.textMuted), hintText: 'Search...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14))),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _FilterLabel('Job Type'),
                ...['Full-time', 'Part-time', 'Contract', 'Freelance'].map((t) => CheckboxListTile(value: t == 'Full-time', onChanged: (_) {}, title: Text(t, style: GoogleFonts.inter(fontSize: 13)), contentPadding: EdgeInsets.zero, controlAffinity: ListTileControlAffinity.leading, dense: true, activeColor: HireIQTheme.primaryTeal)),
                const Divider(color: HireIQTheme.borderLight),
                _FilterLabel('Work Arrangement'),
                ...['Remote', 'Hybrid', 'On-site'].map((t) => CheckboxListTile(value: t == 'Remote', onChanged: (_) {}, title: Text(t, style: GoogleFonts.inter(fontSize: 13)), contentPadding: EdgeInsets.zero, controlAffinity: ListTileControlAffinity.leading, dense: true, activeColor: HireIQTheme.primaryTeal)),
                const Divider(color: HireIQTheme.borderLight),
                _FilterLabel('Salary Range'),
                RangeSlider(values: const RangeValues(50000, 120000), min: 20000, max: 200000, onChanged: (_) {}, activeColor: HireIQTheme.primaryTeal),
                Text('R50k – R120k', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
              ]),
            ),
          ])),
          const SizedBox(width: 20),
          // Centre: job list
          SizedBox(width: 380, child: Column(children: _jobs.asMap().entries.map((e) {
            final j = e.value;
            final isSelected = e.key == _selected;
            return GestureDetector(
              onTap: () => setState(() => _selected = e.key),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: isSelected ? HireIQTheme.primaryTeal : HireIQTheme.borderLight, width: isSelected ? 2 : 1)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Container(width: 36, height: 36, decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(HireIQTheme.radiusSm)), child: Center(child: Text(j.company.substring(0, 2), style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)))),
                    const SizedBox(width: 10),
                    Expanded(child: Text(j.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary))),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('${j.matchiq}%', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))),
                  ]),
                  const SizedBox(height: 6),
                  Text(j.salary, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)),
                  Text('${j.company} · ${j.location}', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                  Text(j.posted, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                ]),
              ),
            );
          }).toList())),
          const SizedBox(width: 20),
          // Right: preview
          Expanded(child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(_jobs[_selected].title, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text(_jobs[_selected].company, style: GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textMuted)),
              const SizedBox(height: 16),
              Row(children: [
                const Icon(Icons.auto_awesome_rounded, color: HireIQTheme.primaryTeal, size: 16),
                const SizedBox(width: 6),
                Text('${_jobs[_selected].matchiq}% MatchIQ score', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
              ]),
              const SizedBox(height: 16),
              Text('About the Role', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 8),
              Text('We are looking for an experienced engineer to join our growing team. You will work closely with product and design to deliver high-quality solutions used by millions of South Africans.', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted, height: 1.65)),
              const SizedBox(height: 20),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Quick Apply', style: GoogleFonts.inter(fontWeight: FontWeight.w700)))),
            ]),
          )),
        ]),
      ),
    );
  }
}

class _JItem { const _JItem(this.title, this.company, this.location, this.salary, this.matchiq, this.posted); final String title, company, location, salary, posted; final int matchiq; }
Widget _FilterLabel(String t) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(t, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
