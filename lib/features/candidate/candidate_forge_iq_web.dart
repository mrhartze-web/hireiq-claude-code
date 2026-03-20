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
  final _roleCtrl = TextEditingController(text: 'Senior Flutter Developer');
  final _expCtrl = TextEditingController(text: '6 years building cross-platform apps with Flutter and Dart.\nPreviously at TechFlow Solutions and Standard Bank.');
  bool _generating = false;

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('ForgeIQ — CV Builder', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('AI-powered CV generation tailored to your target role', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            Row(children: [
              const Icon(Icons.auto_awesome_rounded, size: 16, color: HireIQTheme.primaryTeal),
              const SizedBox(width: 6),
              Text('ForgeIQ', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
            ]),
          ]),
          const SizedBox(height: 32),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: form
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _Section2('Target Role', TextField(controller: _roleCtrl, onChanged: (_) => setState(() {}), decoration: InputDecoration(prefixIcon: const Icon(Icons.work_outline_rounded, size: 18, color: HireIQTheme.textMuted), hintText: 'e.g. Senior Flutter Developer', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))))),
              const SizedBox(height: 20),
              _Section2('Summary & Experience', TextField(controller: _expCtrl, onChanged: (_) => setState(() {}), maxLines: 5, decoration: InputDecoration(hintText: 'Describe your experience...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.all(16)))),
              const SizedBox(height: 20),
              _Section2('Key Skills', Wrap(spacing: 8, runSpacing: 8, children: ['Flutter', 'Dart', 'Firebase', 'Riverpod', 'REST APIs', 'Git'].map((s) => Chip(label: Text(s, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)), backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.08), side: BorderSide(color: HireIQTheme.primaryTeal.withValues(alpha: 0.3)), padding: EdgeInsets.zero)).toList())),
              const SizedBox(height: 28),
              SizedBox(width: double.infinity, child: ElevatedButton.icon(
                onPressed: () async { setState(() => _generating = true); await Future.delayed(const Duration(seconds: 2)); if (mounted) setState(() => _generating = false); },
                icon: _generating ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: HireIQTheme.primaryNavy)) : const Icon(Icons.auto_awesome_rounded, size: 16),
                label: Text(_generating ? 'Generating...' : 'Generate with ForgeIQ', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14)),
                style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))),
              )),
            ])),
            const SizedBox(width: 28),
            // Right: live preview
            Expanded(child: Container(
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), decoration: BoxDecoration(color: HireIQTheme.background, borderRadius: const BorderRadius.vertical(top: Radius.circular(HireIQTheme.radiusLg))), child: Row(children: [const Icon(Icons.preview_rounded, size: 16, color: HireIQTheme.textMuted), const SizedBox(width: 8), Text('Live Preview', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textMuted))])),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  // CV header
                  Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.04), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Thabo Mokoena', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
                    Text(_roleCtrl.text.isEmpty ? 'Your Role' : _roleCtrl.text, style: GoogleFonts.inter(fontSize: 14, color: HireIQTheme.primaryTeal, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text('Cape Town · thabo@email.co.za · +27 82 000 1234', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                  ])),
                  const SizedBox(height: 16),
                  Text('Professional Summary', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy, letterSpacing: 0.5)),
                  const SizedBox(height: 8),
                  Text(_expCtrl.text.isEmpty ? 'Your experience summary will appear here...' : _expCtrl.text, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.6)),
                ])),
              ]),
            )),
          ]),
        ]),
      ),
    );
  }
}

Widget _Section2(String title, Widget child) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)), const SizedBox(height: 8), child]);
