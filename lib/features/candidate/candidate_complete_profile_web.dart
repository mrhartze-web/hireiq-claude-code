import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateCompleteProfileWeb extends ConsumerStatefulWidget {
  const CandidateCompleteProfileWeb({super.key});
  @override
  ConsumerState<CandidateCompleteProfileWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateCompleteProfileWeb> {
  int _expanded = 0;

  static const _sections = ['Personal Information', 'Work Experience', 'Education', 'Skills', 'Salary Expectations'];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left: form
          Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Complete Your Profile', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
            Text('Fill in all sections to maximise your MatchIQ score', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            const SizedBox(height: 28),
            ..._sections.asMap().entries.map((e) {
              final isExpanded = e.key == _expanded;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: isExpanded ? HireIQTheme.primaryTeal : HireIQTheme.borderLight)),
                child: Column(children: [
                  InkWell(
                    onTap: () => setState(() => _expanded = e.key == _expanded ? -1 : e.key),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(children: [
                        Container(width: 28, height: 28, decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), shape: BoxShape.circle), child: Center(child: Text('${e.key + 1}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal)))),
                        const SizedBox(width: 12),
                        Expanded(child: Text(e.value, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary))),
                        Icon(isExpanded ? Icons.expand_less : Icons.expand_more, color: HireIQTheme.textMuted),
                      ]),
                    ),
                  ),
                  if (isExpanded) ...[
                    const Divider(height: 1, color: HireIQTheme.borderLight),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(children: [
                        _TF('First Name'), const SizedBox(height: 14), _TF('Last Name'), const SizedBox(height: 14), _TF('Phone Number'), const SizedBox(height: 14), _TF('City'),
                        const SizedBox(height: 20),
                        Align(alignment: Alignment.centerRight, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.primaryTeal, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Save Section', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)))),
                      ]),
                    ),
                  ],
                ]),
              );
            }),
          ])),
          const SizedBox(width: 28),
          // Right: progress + tips
          SizedBox(width: 280, child: Column(children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Profile Completion', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 16),
                Center(child: Stack(alignment: Alignment.center, children: [
                  SizedBox(width: 110, height: 110, child: CircularProgressIndicator(value: 0.60, strokeWidth: 10, backgroundColor: HireIQTheme.borderLight, color: HireIQTheme.primaryTeal)),
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    Text('60%', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
                    Text('done', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                  ]),
                ])),
                const SizedBox(height: 16),
                ..._sections.asMap().entries.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(children: [
                    Icon(e.key < 3 ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded, size: 16, color: e.key < 3 ? HireIQTheme.success : HireIQTheme.textMuted),
                    const SizedBox(width: 8),
                    Text(e.value, style: GoogleFonts.inter(fontSize: 12, color: e.key < 3 ? HireIQTheme.textPrimary : HireIQTheme.textMuted)),
                  ]),
                )),
              ]),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: HireIQTheme.amber.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.amber.withValues(alpha: 0.2))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [const Icon(Icons.lightbulb_rounded, color: HireIQTheme.amber, size: 16), const SizedBox(width: 8), Text('Pro Tip', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))]),
                const SizedBox(height: 8),
                Text('Profiles with all sections filled get 3× more views from employers.', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.5)),
              ]),
            ),
          ])),
        ]),
      ),
    );
  }
}

Widget _TF(String label) => TextField(decoration: InputDecoration(labelText: label, labelStyle: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted), border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14)));
