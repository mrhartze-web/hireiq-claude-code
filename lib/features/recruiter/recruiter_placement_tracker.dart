import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class RecruiterPlacementTracker extends ConsumerWidget {
  const RecruiterPlacementTracker({super.key});

  static const _placements = [
    _TrackerPlacement(
      candidate: 'Sipho van Rooyen',
      client: 'TechFlow Solutions',
      role: 'Senior Flutter Developer',
      startDate: '01 Mar 2026',
      warrantyEnd: '01 Jun 2026',
      commission: 'R36,500',
      health: 'On Track',
    ),
    _TrackerPlacement(
      candidate: 'Zanele Mokoena',
      client: 'OUTsurance',
      role: 'UX Designer',
      startDate: '01 Feb 2026',
      warrantyEnd: '01 May 2026',
      commission: 'R27,000',
      health: 'At Risk',
    ),
    _TrackerPlacement(
      candidate: 'Thabo Nkosi',
      client: 'Shoprite Holdings',
      role: 'Data Scientist',
      startDate: '01 Jan 2026',
      warrantyEnd: '01 Apr 2026',
      commission: 'R42,000',
      health: 'Protected',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('Placement Tracker',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: HireIQTheme.primaryNavy,
            child: Row(
              children: [
                const Icon(Icons.shield_rounded, color: HireIQTheme.primaryTeal, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'ShieldIQ protects all placements for 90 days. Dispute within this window for a free replacement.',
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.white.withValues(alpha: 0.7), height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _placements.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) => _PlacementCard(placement: _placements[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackerPlacement {
  const _TrackerPlacement({required this.candidate, required this.client, required this.role, required this.startDate, required this.warrantyEnd, required this.commission, required this.health});
  final String candidate;
  final String client;
  final String role;
  final String startDate;
  final String warrantyEnd;
  final String commission;
  final String health;
}

class _PlacementCard extends StatelessWidget {
  const _PlacementCard({required this.placement});
  final _TrackerPlacement placement;

  Color get _healthColor {
    switch (placement.health) {
      case 'On Track': return HireIQTheme.success;
      case 'At Risk': return HireIQTheme.warning;
      case 'Protected': return HireIQTheme.primaryTeal;
      default: return HireIQTheme.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [BoxShadow(color: HireIQTheme.primaryNavy.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                child: Text(placement.candidate.split(' ').map((w) => w[0]).take(2).join(),
                    style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(placement.candidate, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                    Text('${placement.client} — ${placement.role}', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: _healthColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
                child: Text(placement.health, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: _healthColor)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: HireIQTheme.borderLight),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _TRow('Start Date', placement.startDate)),
              Expanded(child: _TRow('Warranty Ends', placement.warrantyEnd)),
              Expanded(child: _TRow('Commission', placement.commission)),
            ],
          ),
          if (placement.health == 'At Risk') ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: HireIQTheme.warning.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, size: 14, color: HireIQTheme.warning),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text('Candidate has flagged dissatisfaction. Consider follow-up.',
                        style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.warning, height: 1.4)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Dispute', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

Widget _TRow(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: GoogleFonts.inter(fontSize: 10, color: HireIQTheme.textMuted)),
      const SizedBox(height: 2),
      Text(value, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
    ],
  );
}
