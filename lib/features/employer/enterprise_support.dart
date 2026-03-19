import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EnterpriseSupportScreen extends ConsumerWidget {
  const EnterpriseSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('Dedicated Support',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
      body: Column(
        children: [
          const _ComingSoonBanner(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryNavy,
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your CSM',
                          style: GoogleFonts.inter(color: Colors.white70, fontSize: 12)),
                      const SizedBox(height: 6),
                      Text('Lerato Molefe',
                          style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Customer Success Manager',
                          style: GoogleFonts.inter(color: Colors.white70, fontSize: 13)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.circle, color: Color(0xFF22C55E), size: 8),
                          const SizedBox(width: 6),
                          Text('Available: Response under 2 hours',
                              style: GoogleFonts.inter(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildOption(Icons.chat_outlined, 'Live Chat', 'Chat with your CSM directly'),
                const SizedBox(height: 12),
                _buildOption(Icons.video_call_outlined, 'Schedule a Call', 'Book a 30-min session'),
                const SizedBox(height: 12),
                _buildOption(Icons.email_outlined, 'Email Support', 'enterprise@hireiq.co.za'),
                const SizedBox(height: 12),
                _buildOption(Icons.help_outline_rounded, 'Knowledge Base', 'Browse Enterprise docs'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        children: [
          Icon(icon, color: HireIQTheme.primaryTeal, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        fontSize: 14, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)),
                Text(subtitle,
                    style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: HireIQTheme.textLight, size: 20),
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
