import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EnterpriseJobApprovalScreen extends ConsumerWidget {
  const EnterpriseJobApprovalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(backgroundColor: HireIQTheme.primaryNavy, foregroundColor: Colors.white, centerTitle: true,
        title: Text('Job Approval Workflow', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white))),
      body: Column(children: [
        const _ComingSoonBanner(),
        Expanded(child: ListView(padding: const EdgeInsets.all(24), children: [
          Text('Pending Approvals', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 12),
          _buildCard('Senior Data Engineer', 'Cape Town · R85,000/mo', 'Pending HOD Sign-off', false),
          const SizedBox(height: 12),
          _buildCard('Head of Marketing', 'Remote · R110,000/mo', 'Pending Finance Review', false),
          const SizedBox(height: 24),
          Text('Recently Approved', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 12),
          _buildCard('Flutter Developer', 'Johannesburg · R65,000/mo', 'Approved', true),
        ])),
      ]),
    );
  }

  Widget _buildCard(String title, String subtitle, String status, bool approved) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 2),
          Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: (approved ? HireIQTheme.primaryTeal : HireIQTheme.amber).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
          child: Text(status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: approved ? HireIQTheme.primaryTeal : HireIQTheme.amber)),
        ),
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
