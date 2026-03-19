import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EnterpriseContractsScreen extends ConsumerWidget {
  const EnterpriseContractsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(backgroundColor: HireIQTheme.primaryNavy, foregroundColor: Colors.white, centerTitle: true,
        title: Text('Contract Management', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white))),
      body: Column(children: [
        const _ComingSoonBanner(),
        Expanded(child: ListView(padding: const EdgeInsets.all(24), children: [
          _buildRow('FinCorp SA — MSA', 'Master Services Agreement', 'Active', HireIQTheme.primaryTeal),
          const SizedBox(height: 12),
          _buildRow('DataScale Ltd — NDA', 'Non-Disclosure Agreement', 'Active', HireIQTheme.primaryTeal),
          const SizedBox(height: 12),
          _buildRow('TechFlow — SoW #3', 'Statement of Work', 'Pending Signature', HireIQTheme.amber),
          const SizedBox(height: 12),
          _buildRow('Creative Labs — MSA', 'Master Services Agreement', 'Expired', HireIQTheme.textMuted),
        ])),
      ]),
    );
  }

  Widget _buildRow(String title, String type, String status, Color statusColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
      child: Row(children: [
        const Icon(Icons.description_outlined, color: HireIQTheme.primaryNavy, size: 22), const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)),
          Text(type, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
        ])),
        Text(status, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: statusColor)),
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
