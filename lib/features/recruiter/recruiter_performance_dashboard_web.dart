import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class RecruiterPerformanceDashboardWeb extends ConsumerWidget {
  const RecruiterPerformanceDashboardWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Performance Dashboard', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Your KPIs and benchmarks vs. platform averages', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          // KPI cards
          Row(children: [
            _PKpi('Placements', '8', '↑ 33%', HireIQTheme.success, Icons.handshake_rounded),
            const SizedBox(width: 16),
            _PKpi('Offer Acceptance', '78%', '↑ 5%', HireIQTheme.primaryTeal, Icons.thumb_up_rounded),
            const SizedBox(width: 16),
            _PKpi('Avg Time to Place', '22d', '↓ 4d', HireIQTheme.primaryNavy, Icons.speed_rounded),
            const SizedBox(width: 16),
            _PKpi('Client Satisfaction', '4.8/5', '↑ 0.3', HireIQTheme.amber, Icons.star_rounded),
          ]),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Funnel
            Expanded(child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Your Funnel vs Platform Avg', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 20),
                ...[
                  ('CVs Submitted', 0.85, 0.70),
                  ('Shortlisted', 0.62, 0.50),
                  ('Interviewed', 0.45, 0.38),
                  ('Offer Made', 0.22, 0.18),
                  ('Placed', 0.78, 0.68),
                ].map((r) => Padding(padding: const EdgeInsets.only(bottom: 16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [Expanded(child: Text(r.$1, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))), Text('You: ${(r.$2 * 100).round()}%  Avg: ${(r.$3 * 100).round()}%', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))]),
                  const SizedBox(height: 6),
                  Stack(children: [
                    ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: LinearProgressIndicator(value: r.$3, minHeight: 10, backgroundColor: HireIQTheme.borderLight, valueColor: const AlwaysStoppedAnimation<Color>(HireIQTheme.borderMedium))),
                    ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: LinearProgressIndicator(value: r.$2, minHeight: 10, backgroundColor: Colors.transparent, valueColor: const AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal))),
                  ]),
                ]))),
              ]),
            )),
            const SizedBox(width: 24),
            // Leaderboard and ratings
            Expanded(child: Column(children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Agency Leaderboard', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 14),
                  ...[
                    ('🥇', 'Talent Force', '12 placements'),
                    ('🥈', 'Lindiwe (You)', '8 placements'),
                    ('🥉', 'Pro Search', '7 placements'),
                    ('4th', 'HireEdge', '5 placements'),
                  ].map((r) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(children: [
                    SizedBox(width: 30, child: Text(r.$1, style: const TextStyle(fontSize: 16))),
                    Expanded(child: Text(r.$2, style: GoogleFonts.inter(fontSize: 13, fontWeight: r.$2.contains('You') ? FontWeight.w800 : FontWeight.w500, color: r.$2.contains('You') ? HireIQTheme.primaryTeal : HireIQTheme.textPrimary))),
                    Text(r.$3, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                  ]))),
                ]),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: HireIQTheme.primaryNavy, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('🏆 Achievement Unlocked', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.amber)),
                  const SizedBox(height: 6),
                  Text('"Top 20% Recruiter"\nNational ranking — Q1 2026', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white, height: 1.5)),
                ]),
              ),
            ])),
          ]),
        ]),
      ),
    );
  }
}

Widget _PKpi(String l, String v, String ch, Color c, IconData icon) => Expanded(child: Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: c, size: 18), const SizedBox(height: 8), Text(v, style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w800, color: c)), Text(l, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textPrimary)), Text(ch, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))])));
