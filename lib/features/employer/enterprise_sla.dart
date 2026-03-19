import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EnterpriseSlaScreen extends ConsumerWidget {
  const EnterpriseSlaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(backgroundColor: HireIQTheme.primaryNavy, foregroundColor: Colors.white, centerTitle: true,
        title: Text('SLA Management', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white))),
      body: Column(children: [
        const _ComingSoonBanner(),
        Expanded(child: ListView(padding: const EdgeInsets.all(24), children: [
          _buildSla('Time-to-Hire', '21 days', '18 days', true),
          const SizedBox(height: 12),
          _buildSla('Candidate Response Rate', '95%', '97%', true),
          const SizedBox(height: 12),
          _buildSla('Shortlist Delivery', '5 days', '7 days', false),
          const SizedBox(height: 12),
          _buildSla('Placement Guarantee', '90 days', '90 days', true),
        ])),
      ]),
    );
  }

  Widget _buildSla(String metric, String target, String current, bool onTrack) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
      child: Row(children: [
        Container(width: 8, height: 8, margin: const EdgeInsets.only(right: 14),
          decoration: BoxDecoration(color: onTrack ? HireIQTheme.success : HireIQTheme.amber, shape: BoxShape.circle)),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(metric, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)),
          Text('Target: $target  ·  Current: $current', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
        ])),
        Text(onTrack ? 'On Track' : 'At Risk', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: onTrack ? HireIQTheme.success : HireIQTheme.amber)),
      ]),
    );
  }
}

class _ComingSoonBanner extends StatelessWidget {
  const _ComingSoonBanner();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), color: HireIQTheme.primaryNavy,
      child: Row(children: [
        Expanded(child: Text('Enterprise — Available Soon', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white))),
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: HireIQTheme.amber, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
          child: Text('Soon', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
        const SizedBox(width: 8),
        TextButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You will be notified when Enterprise launches.'))),
          child: Text('Join Waitlist', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.amber))),
      ]),
    );
  }
}
