import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateInterviewPrepWeb extends ConsumerStatefulWidget {
  const CandidateInterviewPrepWeb({super.key});
  @override
  ConsumerState<CandidateInterviewPrepWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateInterviewPrepWeb> {
  int _selected = 0;

  static const _interviews = [
    _IV('TechFlow Solutions', 'Senior Flutter Developer', '22 Mar 2026 · 10:00', 'Video', true),
    _IV('Capitec Bank', 'Lead Mobile Engineer', '25 Mar 2026 · 14:00', 'InPerson', false),
    _IV('Standard Bank', 'Software Engineer III', '28 Mar 2026 · 09:30', 'Phone', false),
  ];

  static const _questions = [
    'Walk me through your Flutter architecture approach for large-scale apps.',
    'How do you handle state management across complex screens?',
    'Describe a challenging bug you debugged in production.',
    'How do you approach performance optimisation in Flutter?',
    'What is your experience with CI/CD for mobile apps?',
  ];

  @override
  Widget build(BuildContext context) {
    final iv = _interviews[_selected];
    final typeColor = iv.type == 'Video' ? HireIQTheme.info : iv.type == 'Phone' ? HireIQTheme.warning : HireIQTheme.success;
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Interview Preparation', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Prepare thoroughly for every upcoming interview', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: interview list
            SizedBox(width: 340, child: Column(children: [
              ..._interviews.asMap().entries.map((e) {
                final i = e.value;
                final sel = _selected == e.key;
                final tc = i.type == 'Video' ? HireIQTheme.info : i.type == 'Phone' ? HireIQTheme.warning : HireIQTheme.success;
                return GestureDetector(
                  onTap: () => setState(() => _selected = e.key),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: sel ? HireIQTheme.primaryTeal : HireIQTheme.borderLight, width: sel ? 2 : 1)),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        Expanded(child: Text(i.company, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: tc.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(i.type, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: tc))),
                      ]),
                      const SizedBox(height: 4),
                      Text(i.role, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                      const SizedBox(height: 6),
                      Row(children: [const Icon(Icons.calendar_today_rounded, size: 11, color: HireIQTheme.textMuted), const SizedBox(width: 4), Text(i.dateTime, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))]),
                      if (i.isVideo) ...[
                        const SizedBox(height: 10),
                        ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.videocam_rounded, size: 14), label: Text('Join Meeting', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.info, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
                      ],
                    ]),
                  ),
                );
              }),
            ])),
            const SizedBox(width: 24),
            // Right: prep panel
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(gradient: LinearGradient(colors: [HireIQTheme.primaryNavy, const Color(0xFF243659)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
                child: Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Preparing for:', style: GoogleFonts.inter(fontSize: 12, color: Colors.white60)),
                    Text(iv.company, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                    Text(iv.role, style: GoogleFonts.inter(fontSize: 14, color: Colors.white70)),
                    const SizedBox(height: 4),
                    Text(iv.dateTime, style: GoogleFonts.inter(fontSize: 12, color: Colors.white60)),
                  ])),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: typeColor, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(iv.type, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white))),
                ]),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [const Icon(Icons.help_rounded, color: HireIQTheme.primaryTeal, size: 18), const SizedBox(width: 8), Text('Common Interview Questions', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))]),
                  const SizedBox(height: 14),
                  ..._questions.asMap().entries.map((e) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(width: 22, height: 22, decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), shape: BoxShape.circle), child: Center(child: Text('${e.key + 1}', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal)))),
                    const SizedBox(width: 10),
                    Expanded(child: Text(e.value, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textPrimary, height: 1.4))),
                  ]))),
                ]),
              ),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.2))),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [const Icon(Icons.auto_awesome_rounded, color: HireIQTheme.primaryTeal, size: 15), const SizedBox(width: 6), Text('UpliftIQ Tips', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))]),
                    const SizedBox(height: 8),
                    Text('Prepare STAR-format answers. Research ${iv.company}\'s latest product releases. Have your portfolio open.', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.5)),
                  ]),
                )),
                const SizedBox(width: 14),
                ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.videocam_rounded, size: 16), label: Text('Video Practice', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
              ]),
            ])),
          ]),
        ]),
      ),
    );
  }
}

class _IV {
  const _IV(this.company, this.role, this.dateTime, this.type, this.isVideo);
  final String company, role, dateTime, type;
  final bool isVideo;
}
