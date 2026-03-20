import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateInterviewPrepWeb extends ConsumerWidget {
  const CandidateInterviewPrepWeb({super.key});

  static const _interviews = [
    _Interview('TechFlow Solutions', 'Senior Flutter Developer', '25 Mar 2026 · 10:00', 'Video Call', HireIQTheme.info),
    _Interview('Capitec Bank', 'Lead Mobile Engineer', '28 Mar 2026 · 14:00', 'On-site', HireIQTheme.primaryNavy),
    _Interview('Standard Bank', 'Software Engineer III', '02 Apr 2026 · 09:00', 'Phone', HireIQTheme.primaryTeal),
  ];

  static const _questions = [
    'Tell me about your experience with Flutter state management.',
    'How would you architect a large-scale mobile application?',
    'Describe a challenging bug you\'ve debugged and how you resolved it.',
    'How do you ensure code quality in your teams?',
    'What is your approach to performance optimisation in mobile apps?',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left: upcoming interviews
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Interview Prep', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
            Text('Prepare and manage your upcoming interviews', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            const SizedBox(height: 24),
            Text('Upcoming Interviews', style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 12),
            ..._interviews.map((i) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Container(width: 40, height: 40, decoration: BoxDecoration(color: i.color.withValues(alpha: 0.1), shape: BoxShape.circle), child: Center(child: Text(i.company.substring(0, 2), style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: i.color)))),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(i.role, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                    Text(i.company, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                  ])),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: i.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(i.type, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: i.color))),
                ]),
                const SizedBox(height: 12),
                Row(children: [const Icon(Icons.schedule_rounded, size: 13, color: HireIQTheme.textMuted), const SizedBox(width: 6), Text(i.datetime, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))]),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.note_alt_outlined, size: 14), label: Text('Notes', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)), style: OutlinedButton.styleFrom(foregroundColor: HireIQTheme.primaryNavy, side: const BorderSide(color: HireIQTheme.borderMedium), padding: const EdgeInsets.symmetric(vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))))),
                  const SizedBox(width: 10),
                  Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.videocam_outlined, size: 14), label: Text('Join', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.primaryNavy, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))))),
                ]),
              ]),
            )),
          ])),
          const SizedBox(width: 28),
          // Right: prep materials
          SizedBox(width: 400, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 70),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [const Icon(Icons.auto_awesome_rounded, color: HireIQTheme.primaryTeal, size: 18), const SizedBox(width: 8), Text('AI Interview Coach', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))]),
                const SizedBox(height: 16),
                ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.videocam_rounded, size: 16), label: Text('Start Video Practice', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
              ]),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Common Questions', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 14),
                ..._questions.asMap().entries.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(width: 22, height: 22, margin: const EdgeInsets.only(right: 10, top: 1), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), shape: BoxShape.circle), child: Center(child: Text('${e.key + 1}', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal)))),
                    Expanded(child: Text(e.value, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.5))),
                  ]),
                )),
              ]),
            ),
          ])),
        ]),
      ),
    );
  }
}

class _Interview { const _Interview(this.company, this.role, this.datetime, this.type, this.color); final String company, role, datetime, type; final Color color; }
