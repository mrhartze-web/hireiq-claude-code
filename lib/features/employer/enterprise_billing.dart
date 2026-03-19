import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EnterpriseBillingScreen extends ConsumerWidget {
  const EnterpriseBillingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('Enterprise Billing',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
      body: Column(
        children: [
          const _ComingSoonBanner(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: HireIQTheme.primaryNavy,
                      borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Current Plan',
                            style: GoogleFonts.inter(color: Colors.white70, fontSize: 13)),
                        const SizedBox(height: 4),
                        Text('Enterprise License',
                            style: GoogleFonts.inter(
                                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('R49,999 / month',
                            style: GoogleFonts.inter(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('Payment History',
                      style: GoogleFonts.inter(
                          fontSize: 16, fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 12),
                  _buildRow('Mar 2026', 'R49,999.00'),
                  _buildRow('Feb 2026', 'R49,999.00'),
                  _buildRow('Jan 2026', 'R49,999.00'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String date, String amount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        children: [
          Expanded(
              child: Text(date,
                  style: GoogleFonts.inter(
                      fontSize: 14, fontWeight: FontWeight.w500, color: HireIQTheme.primaryNavy))),
          Text(amount,
              style: GoogleFonts.inter(
                  fontSize: 14, fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
            ),
            child: Text('Paid',
                style: GoogleFonts.inter(
                    fontSize: 11, fontWeight: FontWeight.w600, color: HireIQTheme.primaryTeal)),
          ),
        ],
      ),
    );
  }
}

class _ComingSoonBanner extends StatelessWidget {
  const _ComingSoonBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: HireIQTheme.primaryNavy,
      child: Row(
        children: [
          Expanded(
            child: Text('Enterprise — Available Soon',
                style: GoogleFonts.inter(
                    fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: HireIQTheme.amber,
              borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
            ),
            child: Text('Soon',
                style: GoogleFonts.inter(
                    fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('You will be notified when Enterprise launches.'))),
            child: Text('Join Waitlist',
                style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.amber)),
          ),
        ],
      ),
    );
  }
}
