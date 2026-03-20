import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidatePassportIqWeb extends ConsumerWidget {
  const CandidatePassportIqWeb({super.key});

  static const _steps = [
    _VStep('Identity Verification', true, 'Your South African ID has been verified'),
    _VStep('Education Verification', true, 'Degree from UCT confirmed with institution'),
    _VStep('Employment Verification', false, 'Upload payslips or letters from past employers'),
    _VStep('Reference Verification', false, 'References must be contacted via PassportIQ'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Icon(Icons.verified_rounded, color: HireIQTheme.primaryTeal, size: 28),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('PassportIQ', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('Verified credentials that build recruiter trust', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
          ]),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: status overview
            Expanded(child: Column(children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Text('Verification Status', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                    const Spacer(),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), decoration: BoxDecoration(color: HireIQTheme.warning.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('Partially Verified', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.warning))),
                  ]),
                  const SizedBox(height: 4),
                  Row(children: [
                    Container(width: 12, height: 12, decoration: const BoxDecoration(color: HireIQTheme.warning, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Text('2 of 4 verifications complete', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                  ]),
                  const SizedBox(height: 18),
                  ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: const LinearProgressIndicator(value: 0.5, minHeight: 10, backgroundColor: HireIQTheme.borderLight, valueColor: AlwaysStoppedAnimation<Color>(HireIQTheme.warning))),
                  const SizedBox(height: 20),
                  ..._steps.asMap().entries.map((e) {
                    final step = e.value;
                    final isLast = e.key == _steps.length - 1;
                    return Column(children: [
                      Padding(padding: const EdgeInsets.symmetric(vertical: 14), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(width: 36, height: 36, decoration: BoxDecoration(color: step.done ? HireIQTheme.success.withValues(alpha: 0.1) : HireIQTheme.background, shape: BoxShape.circle, border: Border.all(color: step.done ? HireIQTheme.success : HireIQTheme.borderMedium)), child: Icon(step.done ? Icons.check_rounded : Icons.hourglass_empty_rounded, color: step.done ? HireIQTheme.success : HireIQTheme.textMuted, size: 18)),
                        const SizedBox(width: 14),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(step.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                          Text(step.description, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.4)),
                        ])),
                        if (step.done) Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: HireIQTheme.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('Verified', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.success))),
                      ])),
                      if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                    ]);
                  }),
                ]),
              ),
            ])),
            const SizedBox(width: 24),
            // Right: document upload zones
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Upload Documents', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 12),
              ...['Employment Letters / Payslips', 'Reference Contact Details'].asMap().entries.map((e) => Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderMedium, width: 1.5), ),
                child: Column(children: [
                  Icon(Icons.cloud_upload_rounded, color: HireIQTheme.primaryTeal, size: 36),
                  const SizedBox(height: 10),
                  Text(e.value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                  const SizedBox(height: 4),
                  Text('Drag & drop files or click to browse', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                  Text('PDF, JPG, PNG — max 10MB', style: GoogleFonts.inter(fontSize: 10, color: HireIQTheme.textLight)),
                  const SizedBox(height: 14),
                  ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.primaryTeal, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Upload File', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700))),
                ]),
              )),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.2))),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [const Icon(Icons.verified_rounded, color: HireIQTheme.primaryTeal, size: 16), const SizedBox(width: 6), Text('PassportIQ Badge', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))]),
                  const SizedBox(height: 8),
                  Text('Fully verified candidates receive a PassportIQ badge visible to all employers — increasing interview chances by 2.5×.', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.5)),
                ]),
              ),
            ])),
          ]),
        ]),
      ),
    );
  }
}

class _VStep {
  const _VStep(this.title, this.done, this.description);
  final String title, description;
  final bool done;
}
