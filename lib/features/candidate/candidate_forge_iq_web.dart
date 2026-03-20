import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateForgeIqWeb extends ConsumerStatefulWidget {
  const CandidateForgeIqWeb({super.key});
  @override
  ConsumerState<CandidateForgeIqWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateForgeIqWeb> {
  final _role = TextEditingController(text: 'Senior Flutter Developer');
  final _summary = TextEditingController(text: 'Passionate mobile engineer with 5+ years building production Flutter apps for South African fintechs and retailers...');
  final _skills = TextEditingController(text: 'Flutter, Dart, Firebase, Riverpod, REST APIs, CI/CD');

  @override
  void dispose() {
    _role.dispose(); _summary.dispose(); _skills.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [const Icon(Icons.auto_awesome_rounded, color: HireIQTheme.primaryTeal, size: 22), const SizedBox(width: 8), Text('ForgeIQ CV Builder', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy))]),
              Text('AI-powered CV builder that adapts to each application', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
          ]),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: form
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _FCard('Target Role', Column(children: [
                TextField(controller: _role, decoration: InputDecoration(labelText: 'Target role / job title', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14))),
              ])),
              const SizedBox(height: 16),
              _FCard('Professional Summary', Column(children: [
                TextField(controller: _summary, maxLines: 4, decoration: InputDecoration(labelText: 'Write a compelling summary...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.all(14))),
                const SizedBox(height: 8),
                Align(alignment: Alignment.centerRight, child: TextButton.icon(onPressed: () {}, icon: const Icon(Icons.auto_awesome_rounded, size: 14), label: Text('Improve with AI', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)), style: TextButton.styleFrom(foregroundColor: HireIQTheme.primaryTeal))),
              ])),
              const SizedBox(height: 16),
              _FCard('Experience', Column(children: [
                _ExpRow('Senior Flutter Developer', 'TechFlow Solutions', '2022 – Present'),
                const Divider(color: HireIQTheme.borderLight, height: 20),
                _ExpRow('Flutter Developer', 'Capitec Bank', '2020 – 2022'),
                const SizedBox(height: 8),
                TextButton.icon(onPressed: () {}, icon: const Icon(Icons.add, size: 14), label: Text('Add experience', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)), style: TextButton.styleFrom(foregroundColor: HireIQTheme.primaryNavy)),
              ])),
              const SizedBox(height: 16),
              _FCard('Skills', Column(children: [
                TextField(controller: _skills, decoration: InputDecoration(labelText: 'Skills (comma separated)', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14))),
                const SizedBox(height: 10),
                Wrap(spacing: 8, runSpacing: 6, children: ['Flutter', 'Dart', 'Firebase', 'Riverpod', 'REST APIs', 'CI/CD'].map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.07), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(s, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)))).toList()),
              ])),
              const SizedBox(height: 20),
              Row(children: [
                Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.auto_awesome_rounded, size: 16), label: Text('Generate Full CV', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))))),
                const SizedBox(width: 12),
                Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.description_rounded, size: 16), label: Text('Write Cover Letter', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.primaryTeal, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))))),
              ]),
            ])),
            const SizedBox(width: 28),
            // Right: Live preview
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [Text('Live Preview', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)), const Spacer(), Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Row(mainAxisSize: MainAxisSize.min, children: [Container(width: 6, height: 6, margin: const EdgeInsets.only(right: 5), decoration: const BoxDecoration(color: HireIQTheme.primaryTeal, shape: BoxShape.circle)), Text('Live', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))]))]),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('THABO MOKOENA', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w900, color: HireIQTheme.primaryNavy, letterSpacing: 1)),
                  Text(_role.text, style: GoogleFonts.inter(fontSize: 14, color: HireIQTheme.primaryTeal, fontWeight: FontWeight.w600)),
                  Text('Cape Town, SA · thabo@example.com · +27 82 000 5678', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                  const Divider(color: HireIQTheme.borderLight, height: 24),
                  Text('PROFESSIONAL SUMMARY', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.5, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 6),
                  Text(_summary.text, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.55)),
                  const Divider(color: HireIQTheme.borderLight, height: 24),
                  Text('EXPERIENCE', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.5, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 8),
                  _PreviewExp('Senior Flutter Developer', 'TechFlow Solutions', '2022 – Present'),
                  const SizedBox(height: 10),
                  _PreviewExp('Flutter Developer', 'Capitec Bank', '2020 – 2022'),
                  const Divider(color: HireIQTheme.borderLight, height: 24),
                  Text('SKILLS', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.5, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 8),
                  Text(_skills.text, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                ]),
              ),
              const SizedBox(height: 12),
              SizedBox(width: double.infinity, child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download_rounded, size: 14), label: Text('Download PDF', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)), style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.borderMedium), padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), foregroundColor: HireIQTheme.primaryNavy))),
            ])),
          ]),
        ]),
      ),
    );
  }
}

Widget _FCard(String title, Widget child) => Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)), const SizedBox(height: 12), child]));
Widget _ExpRow(String role, String company, String dates) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(role, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)), Text('$company  ·  $dates', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))]);
Widget _PreviewExp(String role, String company, String dates) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(role, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)), Text(company, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)), Text(dates, style: GoogleFonts.inter(fontSize: 10, color: HireIQTheme.primaryTeal))]);
