import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerSignalIqWeb extends ConsumerWidget {
  const EmployerSignalIqWeb({super.key});

  static const _alerts = [
    _Alert('🔥', 'Hot Candidate Alert', 'Thabo Mokoena (94% match) updated his profile and is now "Actively Seeking". He has 3 other interview requests.', '2m ago', true),
    _Alert('⭐', 'New Top Match', 'Sipho Dlamini just completed PassportIQ verification — his match for your Flutter role jumped to 91%.', '18m ago', true),
    _Alert('📈', 'Market Insight', 'Senior Flutter Developer salaries increased 8% YoY in Cape Town. Adjust your range to stay competitive.', '2h ago', false),
    _Alert('🎯', 'Passive Candidate', 'Anele Khumalo (88% match) is passively searching. Contact within 48h for best response rate.', '5h ago', false),
    _Alert('🏆', 'Recommendation', 'Nomvula Sithole finished an advanced Flutter course on Coursera, improving her fit for your role.', '1d ago', false),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left: alerts
          Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const Icon(Icons.auto_awesome_rounded, color: HireIQTheme.primaryTeal, size: 28),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('SignalIQ', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
                Text('Real-time talent intelligence alerts', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
              ]),
              const Spacer(),
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Row(children: [Container(width: 8, height: 8, margin: const EdgeInsets.only(right: 6), decoration: const BoxDecoration(color: HireIQTheme.primaryTeal, shape: BoxShape.circle)), Text('Live', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))])),
            ]),
            const SizedBox(height: 28),
            ..._alerts.map((a) => Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: a.isNew ? HireIQTheme.primaryTeal.withValues(alpha: 0.3) : HireIQTheme.borderLight)),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(a.emoji, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Text(a.title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary))),
                    if (a.isNew) Container(width: 8, height: 8, decoration: const BoxDecoration(color: HireIQTheme.primaryTeal, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Text(a.time, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                  ]),
                  const SizedBox(height: 6),
                  Text(a.body, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.55)),
                  const SizedBox(height: 10),
                  OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(foregroundColor: HireIQTheme.primaryNavy, side: const BorderSide(color: HireIQTheme.borderMedium), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Take Action', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600))),
                ])),
              ]),
            )),
          ])),
          const SizedBox(width: 28),
          // Right: settings
          SizedBox(width: 280, child: Column(children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Alert Settings', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 14),
                ...['Hot candidate alerts', 'Market salary insights', 'Profile update signals', 'Passive candidate alerts'].map((t) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(children: [Expanded(child: Text(t, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textPrimary))), Switch(value: true, onChanged: (_) {}, activeTrackColor: HireIQTheme.primaryTeal)]))),
              ]),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.2))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [const Icon(Icons.insights_rounded, color: HireIQTheme.primaryTeal, size: 18), const SizedBox(width: 8), Text('This Week', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))]),
                const SizedBox(height: 12),
                _SIQ('Alerts generated', '14'),
                _SIQ('Actions taken', '5'),
                _SIQ('Hires influenced', '1'),
              ]),
            ),
          ])),
        ]),
      ),
    );
  }
}

class _Alert { const _Alert(this.emoji, this.title, this.body, this.time, this.isNew); final String emoji, title, body, time; final bool isNew; }
Widget _SIQ(String l, String v) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(children: [Expanded(child: Text(l, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))), Text(v, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))]));
