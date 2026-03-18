import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero heading
            Text(
              'About HireIQ',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Redefining recruitment in Africa with AI-powered matching.',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: HireIQTheme.textMuted,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),

            // Mission card
            _buildCard(
              icon: Icons.flag_outlined,
              iconColor: HireIQTheme.primaryTeal,
              title: 'Our Mission',
              body:
                  'HireIQ exists to eliminate bias, reduce time-to-hire, and surface talent that traditional CV screening misses. We combine AI matching, verified credentials, and market intelligence into a single platform built for the African job market.',
            ),
            const SizedBox(height: 16),

            // Story card
            _buildCard(
              icon: Icons.lightbulb_outline,
              iconColor: HireIQTheme.amber,
              title: 'Our Story',
              body:
                  'Founded in South Africa, HireIQ was born from frustration with opaque hiring processes and a belief that great talent is evenly distributed — opportunity is not. Our team of engineers, recruiters, and data scientists set out to fix that with tools like MatchIQ, PassportIQ, and WildcardIQ.',
            ),
            const SizedBox(height: 16),

            // Values row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildValueCard(
                    icon: Icons.balance_outlined,
                    label: 'Fairness',
                    body: 'Unbiased scoring via WildcardIQ removes demographic identifiers before recruiters see profiles.',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildValueCard(
                    icon: Icons.verified_outlined,
                    label: 'Trust',
                    body: 'PassportIQ verifies identity and credentials so every profile on HireIQ can be trusted.',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildValueCard(
                    icon: Icons.speed_outlined,
                    label: 'Speed',
                    body: 'MatchIQ surfaces the right candidate within seconds, not weeks.',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Coming soon banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.construction_outlined,
                      color: HireIQTheme.primaryTeal, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Full about page — team profiles and company milestones — coming soon.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: HireIQTheme.primaryTeal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String body,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  body,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: HireIQTheme.textMuted,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard({
    required IconData icon,
    required String label,
    required String body,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: HireIQTheme.primaryNavy.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
            ),
            child: Icon(icon, color: HireIQTheme.primaryNavy, size: 18),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: HireIQTheme.textMuted,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
