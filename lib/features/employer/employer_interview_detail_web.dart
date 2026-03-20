import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerInterviewDetailWeb extends ConsumerWidget {
  const EmployerInterviewDetailWeb({super.key});

  static const _panelists = [
    _Panelist('Thabo Mokoena', 'Engineering Manager', 'Confirmed'),
    _Panelist('Sipho Dlamini', 'Senior Flutter Dev', 'Confirmed'),
    _Panelist('Priya Naidoo', 'HR Lead', 'Pending'),
  ];

  static const _scorecard = [
    _Score('Technical Skills', 4, 5),
    _Score('Communication', 5, 5),
    _Score('Culture Fit', 4, 5),
    _Score('Problem Solving', 3, 5),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left: interview details
          Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Interview Details', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  CircleAvatar(radius: 28, backgroundColor: HireIQTheme.primaryNavy, child: Text('SM', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white))),
                  const SizedBox(width: 16),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Sipho Mokoena', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
                    Text('Candidate for Senior Flutter Developer', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)),
                  ]),
                  const Spacer(),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), decoration: BoxDecoration(color: HireIQTheme.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('Confirmed', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.success))),
                ]),
                const SizedBox(height: 20),
                const Divider(color: HireIQTheme.borderLight),
                const SizedBox(height: 16),
                _IRow(Icons.calendar_today_rounded, 'Date & Time', 'Tuesday, 25 March 2026 · 10:00 – 11:00 SAST'),
                _IRow(Icons.videocam_rounded, 'Format', 'Video Call via Google Meet'),
                _IRow(Icons.auto_awesome_rounded, 'MatchIQ Score', '94% match for this role'),
                _IRow(Icons.link_rounded, 'Meeting Link', 'meet.google.com/abc-xyz-123'),
                const SizedBox(height: 16),
                Row(children: [
                  ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.videocam_rounded, size: 14), label: Text('Join Meeting', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
                  const SizedBox(width: 12),
                  OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.borderMedium), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Reschedule', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13, color: HireIQTheme.textPrimary))),
                ]),
              ]),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Interview Panel', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 14),
                ..._panelists.map((p) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(children: [
                  CircleAvatar(radius: 16, backgroundColor: HireIQTheme.primaryNavy.withValues(alpha: 0.1), child: Text(p.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy))),
                  const SizedBox(width: 10),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(p.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)),
                    Text(p.role, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                  ])),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: p.status == 'Confirmed' ? HireIQTheme.success.withValues(alpha: 0.1) : HireIQTheme.warning.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(p.status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: p.status == 'Confirmed' ? HireIQTheme.success : HireIQTheme.warning))),
                ]))),
              ]),
            ),
          ])),
          const SizedBox(width: 28),
          // Right: scorecard
          Expanded(child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Interview Scorecard', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 20),
              ..._scorecard.map((s) => Padding(padding: const EdgeInsets.only(bottom: 20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [Expanded(child: Text(s.category, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary))), Text('${s.scored}/${s.total}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy))]),
                const SizedBox(height: 8),
                Row(children: List.generate(s.total, (i) => Padding(padding: const EdgeInsets.only(right: 4), child: Icon(i < s.scored ? Icons.star_rounded : Icons.star_outline_rounded, color: i < s.scored ? HireIQTheme.amber : HireIQTheme.borderMedium, size: 22)))),
              ]))),
              TextField(maxLines: 4, decoration: InputDecoration(labelText: 'Add notes...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.all(14))),
              const SizedBox(height: 14),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.primaryNavy, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Submit Scorecard', style: GoogleFonts.inter(fontWeight: FontWeight.w700)))),
            ]),
          )),
        ]),
      ),
    );
  }
}

class _Panelist { const _Panelist(this.name, this.role, this.status); final String name, role, status; }
class _Score { const _Score(this.category, this.scored, this.total); final String category; final int scored, total; }
Widget _IRow(IconData icon, String label, String value) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(children: [Icon(icon, size: 16, color: HireIQTheme.primaryTeal), const SizedBox(width: 10), Text('$label: ', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)), Expanded(child: Text(value, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)))]));
