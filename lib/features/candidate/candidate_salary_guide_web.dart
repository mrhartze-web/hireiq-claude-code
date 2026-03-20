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
  String _location = 'Cape Town';

  static const _breakdown = [
    _Level('Junior (0–2 yrs)', 'R35k', 'R55k', 'R45k', 0.3),
    _Level('Mid-level (3–5 yrs)', 'R60k', 'R90k', 'R75k', 0.55),
    _Level('Senior (6–9 yrs)', 'R90k', 'R130k', 'R110k', 0.75),
    _Level('Principal (10+ yrs)', 'R130k', 'R180k', 'R155k', 1.0),
  ];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Salary Intelligence', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Powered by SignalIQ — real-time South African salary data', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Row(children: [
              Expanded(child: DropdownButtonFormField<String>(
                value: _role,
                decoration: InputDecoration(labelText: 'Role', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14)),
                items: ['Flutter Developer', 'React Native Developer', 'Data Scientist', 'DevOps Engineer'].map((r) => DropdownMenuItem(value: r, child: Text(r, style: GoogleFonts.inter(fontSize: 13)))).toList(),
                onChanged: (v) => setState(() => _role = v!),
              )),
              const SizedBox(width: 16),
              Expanded(child: DropdownButtonFormField<String>(
                value: _location,
                decoration: InputDecoration(labelText: 'Location', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14)),
                items: ['Cape Town', 'Johannesburg', 'Durban', 'Pretoria', 'Remote'].map((r) => DropdownMenuItem(value: r, child: Text(r, style: GoogleFonts.inter(fontSize: 13)))).toList(),
                onChanged: (v) => setState(() => _location = v!),
              )),
              const SizedBox(width: 16),
              ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.primaryTeal, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Update', style: GoogleFonts.inter(fontWeight: FontWeight.w600))),
            ]),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [HireIQTheme.primaryNavy, Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('$_role · $_location', style: GoogleFonts.inter(fontSize: 14, color: Colors.white60)),
                const SizedBox(height: 8),
                Text('R60k – R130k /month', style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white)),
                const SizedBox(height: 8),
                Row(children: [const Icon(Icons.trending_up_rounded, color: HireIQTheme.success, size: 16), const SizedBox(width: 6), Text('+8% YoY · 124 active roles', style: GoogleFonts.inter(fontSize: 13, color: Colors.white70))]),
              ])),
              Column(children: [
                Text('Your Value', style: GoogleFonts.inter(fontSize: 13, color: Colors.white54)),
                Text('R95k', style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w800, color: HireIQTheme.amber)),
                Text('est. market rate', style: GoogleFonts.inter(fontSize: 11, color: Colors.white54)),
              ]),
            ]),
          ),
          const SizedBox(height: 24),
          Text('Salary by Experience Level', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), color: HireIQTheme.background, child: Row(children: [_TH2('Experience Level', flex: 3), _TH2('Min'), _TH2('Max'), _TH2('Median'), _TH2('Demand', flex: 3)])),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              ..._breakdown.asMap().entries.map((e) {
                final lvl = e.value;
                final isLast = e.key == _breakdown.length - 1;
                return Column(children: [
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), child: Row(children: [
                    Expanded(flex: 3, child: Text(lvl.label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary))),
                    Expanded(child: Text(lvl.min, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                    Expanded(child: Text(lvl.max, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                    Expanded(child: Text(lvl.median, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
                    Expanded(flex: 3, child: Row(children: [
                      Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: LinearProgressIndicator(value: lvl.demandRatio, minHeight: 8, backgroundColor: HireIQTheme.borderLight, valueColor: const AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal)))),
                      const SizedBox(width: 10),
                      Text('${(lvl.demandRatio * 100).round()}%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.primaryTeal)),
                    ])),
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

class _Level { const _Level(this.label, this.min, this.max, this.median, this.demandRatio); final String label, min, max, median; final double demandRatio; }
Widget _TH2(String l, {int flex = 1}) => Expanded(flex: flex, child: Text(l, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
