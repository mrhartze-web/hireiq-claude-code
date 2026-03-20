import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidatePassportIqWeb extends ConsumerWidget {
  const CandidatePassportIqWeb({super.key});

  static const _steps = [
    _VStep('Identity Verification', 'Upload SA ID or Passport', true, HireIQTheme.success),
    _VStep('Qualification Check', 'Tertiary certificates', true, HireIQTheme.success),
    _VStep('Employment History', 'Work reference letters', false, HireIQTheme.warning),
    _VStep('Criminal Clearance', 'SAPS clearance certificate', false, HireIQTheme.textMuted),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left: verification status
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const Icon(Icons.verified_user_rounded, color: HireIQTheme.primaryTeal, size: 32),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('PassportIQ', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
                Text('Verified credentials boost your MatchIQ by up to 15%', style: GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textMuted)),
              ]),
            ]),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [HireIQTheme.primaryNavy, Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
              ),
              child: Row(children: [
                Stack(alignment: Alignment.center, children: [
                  SizedBox(width: 90, height: 90, child: CircularProgressIndicator(value: 0.5, strokeWidth: 8, backgroundColor: Colors.white24, color: HireIQTheme.amber)),
                  Text('50%', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                ]),
                const SizedBox(width: 24),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Verification Progress', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                  Text('2 of 4 verifications complete', style: GoogleFonts.inter(fontSize: 13, color: Colors.white60)),
                  const SizedBox(height: 8),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: HireIQTheme.amber.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('PassportIQ Partial', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.amber))),
                ])),
              ]),
            ),
            const SizedBox(height: 24),
            Text('Verification Steps', style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 14),
            ..._steps.asMap().entries.map((e) {
              final s = e.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Row(children: [
                  Container(width: 36, height: 36, decoration: BoxDecoration(color: s.color.withValues(alpha: 0.1), shape: BoxShape.circle), child: Center(child: Icon(s.done ? Icons.check_rounded : Icons.lock_outline_rounded, size: 16, color: s.color))),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(s.title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                    Text(s.subtitle, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                  ])),
                  if (!s.done) Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: HireIQTheme.amber, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('Upload', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
                ]),
              );
            }),
          ])),
          const SizedBox(width: 28),
          // Right: upload area
          Expanded(child: Column(children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Upload Documents', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.04), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.3), style: BorderStyle.solid)),
                  child: Column(children: [
                    const Icon(Icons.cloud_upload_outlined, size: 48, color: HireIQTheme.primaryTeal),
                    const SizedBox(height: 12),
                    Text('Drag and drop documents here', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)),
                    Text('or click to browse', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                    const SizedBox(height: 16),
                    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Choose File', style: GoogleFonts.inter(fontWeight: FontWeight.w700))),
                  ]),
                ),
                const SizedBox(height: 16),
                Text('Accepted: PDF, JPG, PNG · Max 10MB per file', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
              ]),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: HireIQTheme.success.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.success.withValues(alpha: 0.2))),
              child: Row(children: [
                const Icon(Icons.shield_rounded, color: HireIQTheme.success, size: 24),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Your data is secure', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                  Text('Documents are encrypted and only shared with employers you apply to.', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                ])),
              ]),
            ),
          ])),
        ]),
      ),
    );
  }
}

class _VStep { const _VStep(this.title, this.subtitle, this.done, this.color); final String title, subtitle; final bool done; final Color color; }
