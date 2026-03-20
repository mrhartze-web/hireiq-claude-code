import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateSalaryGuideWeb extends ConsumerStatefulWidget {
  const CandidateSalaryGuideWeb({super.key});
  @override
  ConsumerState<CandidateSalaryGuideWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateSalaryGuideWeb> {
  String _role = 'Flutter Developer';
  String _exp = 'Senior';
  String _city = 'Cape Town';

  static const _data = <String, (int, int, int)>{
    'Flutter Developer': (65000, 87000, 130000),
    'React Native Developer': (60000, 80000, 120000),
    'Mobile Architect': (90000, 120000, 160000),
    'Frontend Developer': (55000, 72000, 110000),
    'Backend Developer': (58000, 78000, 115000),
  };

  @override
  Widget build(BuildContext context) {
    final d = _data[_role] ?? (65000, 87000, 130000);
    final (minS, midS, maxS) = d;

    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Salary Guide', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('SA tech salary benchmarks powered by real HireIQ data', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Filters
            SizedBox(width: 240, child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Filter', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 14),
                _SGuideDD('Job Role', _role, _data.keys.toList(), (v) => setState(() => _role = v)),
                const SizedBox(height: 12),
                _SGuideDD('Experience Level', _exp, ['Junior', 'Mid', 'Senior', 'Lead', 'Principal'], (v) => setState(() => _exp = v)),
                const SizedBox(height: 12),
                _SGuideDD('City', _city, ['Cape Town', 'Johannesburg', 'Durban', 'Pretoria', 'Remote'], (v) => setState(() => _city = v)),
              ]),
            )),
            const SizedBox(width: 20),
            // Main salary range
            Expanded(child: Column(children: [
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(gradient: const LinearGradient(colors: [HireIQTheme.primaryNavy, Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('$_exp $_role · $_city', style: GoogleFonts.inter(fontSize: 14, color: Colors.white60)),
                  const SizedBox(height: 4),
                  Text('R${(midS / 1000).round()}k/month', style: GoogleFonts.inter(fontSize: 48, fontWeight: FontWeight.w900, color: Colors.white)),
                  Text('Market median salary', style: GoogleFonts.inter(fontSize: 13, color: Colors.white60)),
                  const SizedBox(height: 24),
                  Row(children: [
                    _SBandCard('Min', 'R${(minS / 1000).round()}k', HireIQTheme.error),
                    const SizedBox(width: 12),
                    _SBandCard('Median', 'R${(midS / 1000).round()}k', HireIQTheme.primaryTeal),
                    const SizedBox(width: 12),
                    _SBandCard('Max', 'R${(maxS / 1000).round()}k', HireIQTheme.success),
                  ]),
                  const SizedBox(height: 24),
                  // Gradient bar
                  Stack(children: [
                    ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: Container(height: 20, decoration: const BoxDecoration(gradient: LinearGradient(colors: [HireIQTheme.error, HireIQTheme.primaryTeal, HireIQTheme.success])))),
                    Positioned(left: ((midS - minS) / (maxS - minS) * (MediaQuery.of(context).size.width * 0.45)).clamp(0, double.infinity), top: 2, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle))),
                  ]),
                ]),
              ),
              const SizedBox(height: 20),
              // Breakdown table
              Container(
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(children: [
                  _SRow('Junior', 'R45k', 'R60k', 'R75k'),
                  const Divider(height: 1, color: HireIQTheme.borderLight),
                  _SRow('Mid', 'R65k', 'R80k', 'R100k'),
                  const Divider(height: 1, color: HireIQTheme.borderLight),
                  _SRowHighlight('Senior', 'R80k', 'R100k', 'R130k'),
                  const Divider(height: 1, color: HireIQTheme.borderLight),
                  _SRow('Lead', 'R110k', 'R130k', 'R165k'),
                  const Divider(height: 1, color: HireIQTheme.borderLight),
                  _SRow('Principal', 'R145k', 'R170k', 'R220k'),
                ]),
              ),
            ])),
          ]),
        ]),
      ),
    );
  }
}

Widget _SGuideDD(String label, String value, List<String> items, void Function(String) onChanged) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: HireIQTheme.textMuted)), const SizedBox(height: 6), DropdownButtonFormField<String>(value: value, onChanged: (v) => onChanged(v!), items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.inter(fontSize: 12)))).toList(), decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9)))]);
Widget _SBandCard(String label, String value, Color c) => Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: GoogleFonts.inter(fontSize: 11, color: Colors.white60)), Text(value, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: c))])));
Widget _SRow(String l, String mn, String md, String mx) => Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13), child: Row(children: [Expanded(child: Text(l, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textPrimary))), _SCell(mn, HireIQTheme.error), _SCell(md, HireIQTheme.primaryTeal), _SCell(mx, HireIQTheme.success)]));
Widget _SRowHighlight(String l, String mn, String md, String mx) => Container(color: HireIQTheme.primaryTeal.withValues(alpha: 0.05), child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13), child: Row(children: [Expanded(child: Text(l, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))), _SCell(mn, HireIQTheme.error), _SCell(md, HireIQTheme.primaryTeal), _SCell(mx, HireIQTheme.success)])));
Widget _SCell(String v, Color c) => SizedBox(width: 70, child: Text(v, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: c), textAlign: TextAlign.right));
