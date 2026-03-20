import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateSmartApplyWeb extends ConsumerStatefulWidget {
  const CandidateSmartApplyWeb({super.key});
  @override
  ConsumerState<CandidateSmartApplyWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateSmartApplyWeb> {
  int _step = 0;
  bool _applying = false;

  final _steps = ['Select Jobs', 'Review & Customise', 'Submit Applications'];

  static const _jobs = [
    _SmartJob('Senior Flutter Developer', 'TechFlow Solutions', 94),
    _SmartJob('Lead Mobile Engineer', 'Capitec Bank', 88),
    _SmartJob('Software Engineer III', 'Standard Bank', 82),
    _SmartJob('React Native Developer', 'OUTsurance', 79),
  ];

  final _selected = <int>{0, 1};

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('SmartApply', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('AI-powered batch applications — apply to multiple jobs at once', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          // Stepper
          Row(children: _steps.asMap().entries.map((e) {
            final idx = e.key;
            final isActive = idx == _step;
            final isDone = idx < _step;
            return Expanded(child: Row(children: [
              CircleAvatar(radius: 14, backgroundColor: isActive ? HireIQTheme.primaryTeal : isDone ? HireIQTheme.success : HireIQTheme.borderMedium, child: isDone ? const Icon(Icons.check_rounded, size: 14, color: Colors.white) : Text('${idx + 1}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white))),
              const SizedBox(width: 8),
              Text(e.value, style: GoogleFonts.inter(fontSize: 13, fontWeight: isActive ? FontWeight.w700 : FontWeight.w500, color: isActive ? HireIQTheme.primaryNavy : HireIQTheme.textMuted)),
              if (idx < _steps.length - 1) Expanded(child: Container(height: 1.5, margin: const EdgeInsets.symmetric(horizontal: 12), color: HireIQTheme.borderLight)),
            ]));
          }).toList()),
          const SizedBox(height: 28),
          // Content area
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Jobs list
            Expanded(child: Container(
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(children: [
                Container(padding: const EdgeInsets.all(16), decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: HireIQTheme.borderLight))), child: Row(children: [Text('AI-matched jobs for you', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)), const Spacer(), Text('${_selected.length} selected', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.primaryTeal, fontWeight: FontWeight.w600))])),
                ..._jobs.asMap().entries.map((e) {
                  final j = e.value;
                  final isChecked = _selected.contains(e.key);
                  return Column(children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), child: Row(children: [
                      Checkbox(value: isChecked, onChanged: (v) => setState(() => v! ? _selected.add(e.key) : _selected.remove(e.key)), activeColor: HireIQTheme.primaryTeal, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                      const SizedBox(width: 10),
                      Container(width: 40, height: 40, decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(HireIQTheme.radiusSm)), child: Center(child: Text(j.company.substring(0, 2), style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)))),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(j.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                        Text(j.company, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                      ])),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('${j.matchiq}%', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))),
                    ])),
                    if (e.key < _jobs.length - 1) const Divider(height: 1, color: HireIQTheme.borderLight),
                  ]);
                }),
              ]),
            )),
            const SizedBox(width: 24),
            // Action panel
            SizedBox(width: 320, child: Column(children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [const Icon(Icons.auto_awesome_rounded, color: HireIQTheme.primaryTeal, size: 18), const SizedBox(width: 8), Text('AI Cover Letter', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))]),
                  const SizedBox(height: 12),
                  Text('SmartApply generates a personalised cover letter for each selected role, tailored to the job requirements and your profile.', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted, height: 1.55)),
                  const SizedBox(height: 20),
                  Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.2))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Ready to apply:', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                    const SizedBox(height: 8),
                    Text('• ${_selected.length} jobs selected', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textPrimary)),
                    Text('• AI cover letters will be generated', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textPrimary)),
                    Text('• Profile auto-attached', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textPrimary)),
                  ])),
                  const SizedBox(height: 20),
                  SizedBox(width: double.infinity, child: ElevatedButton.icon(
                    onPressed: _selected.isEmpty ? null : () async { setState(() => _applying = true); await Future.delayed(const Duration(seconds: 2)); if (mounted) setState(() { _applying = false; _step = 2; }); },
                    icon: _applying ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: HireIQTheme.primaryNavy)) : const Icon(Icons.send_rounded, size: 16),
                    label: Text(_applying ? 'Submitting...' : 'SmartApply Now', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14)),
                    style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))),
                  )),
                  if (_step == 2) ...[const SizedBox(height: 14), Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: HireIQTheme.success.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), child: Row(children: [const Icon(Icons.check_circle_rounded, color: HireIQTheme.success, size: 18), const SizedBox(width: 8), Text('Applications submitted!', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.success))]))],
                ]),
              ),
            ])),
          ]),
        ]),
      ),
    );
  }
}

class _SmartJob { const _SmartJob(this.title, this.company, this.matchiq); final String title, company; final int matchiq; }
