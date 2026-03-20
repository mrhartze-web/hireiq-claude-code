import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateCompleteProfileWeb extends ConsumerWidget {
  const CandidateCompleteProfileWeb({super.key});

  static const _items = [
    _Item('Upload profile photo', 10, true),
    _Item('Add work experience', 20, true),
    _Item('Add education history', 15, true),
    _Item('List your top skills', 15, false),
    _Item('Write a professional summary', 10, false),
    _Item('Add portfolio projects', 15, false),
    _Item('Complete PassportIQ verification', 15, false),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed = _items.where((i) => i.done).length;
    final total = _items.length;
    final pct = completed / total;
    final points = _items.where((i) => i.done).fold(0, (s, i) => s + i.points);

    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Complete Your Profile', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('A complete profile increases your MatchIQ score and employer visibility', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: checklist
            Expanded(flex: 2, child: Container(
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(children: [
                Padding(padding: const EdgeInsets.fromLTRB(20, 18, 20, 14), child: Text('Profile Checklist', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                ..._items.asMap().entries.map((e) {
                  final item = e.value;
                  final isLast = e.key == _items.length - 1;
                  return Column(children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                      Icon(item.done ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded, color: item.done ? HireIQTheme.success : HireIQTheme.borderMedium, size: 22),
                      const SizedBox(width: 14),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(item.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: item.done ? HireIQTheme.textMuted : HireIQTheme.textPrimary, decoration: item.done ? TextDecoration.lineThrough : null)),
                        Text('+${item.points} MatchIQ points', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.primaryTeal, fontWeight: FontWeight.w600)),
                      ])),
                      if (!item.done) ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Complete', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700))),
                    ])),
                    if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                  ]);
                }),
              ]),
            )),
            const SizedBox(width: 24),
            // Right: ring and tips
            SizedBox(width: 300, child: Column(children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Completion', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 20),
                  Center(child: SizedBox(width: 140, height: 140, child: Stack(alignment: Alignment.center, children: [
                    CircularProgressIndicator(value: pct, strokeWidth: 14, backgroundColor: HireIQTheme.borderLight, valueColor: const AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal)),
                    Column(mainAxisSize: MainAxisSize.min, children: [
                      Text('${(pct * 100).round()}%', style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
                      Text('$completed/$total done', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                    ]),
                  ]))),
                  const SizedBox(height: 20),
                  Center(child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('+$points MatchIQ points earned', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)))),
                ]),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.amber.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.amber.withValues(alpha: 0.2))),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [const Icon(Icons.lightbulb_rounded, color: HireIQTheme.amber, size: 16), const SizedBox(width: 6), Text('Pro tip', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.amber))]),
                  const SizedBox(height: 8),
                  Text('Candidates with complete profiles get 3× more recruiter views and 2× more interview invites.', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.5)),
                ]),
              ),
            ])),
          ]),
        ]),
      ),
    );
  }
}

class _Item {
  const _Item(this.title, this.points, this.done);
  final String title;
  final int points;
  final bool done;
}
