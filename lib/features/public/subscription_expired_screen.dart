import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';

class SubscriptionExpiredScreen extends ConsumerWidget {
  const SubscriptionExpiredScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.surfaceWhite,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        title: Text(
          'Subscription Expired',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HireIQTheme.amber.withValues(alpha: 0.1),
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  size: 40,
                  color: HireIQTheme.amber,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Your subscription has expired',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Your Pro plan expired on 28 February 2026.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: HireIQTheme.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Features now locked:',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy,
              ),
            ),
            const SizedBox(height: 12),
            _LockedFeatureItem(label: 'Unlimited applications'),
            const SizedBox(height: 8),
            _LockedFeatureItem(label: 'PassportIQ verification'),
            const SizedBox(height: 8),
            _LockedFeatureItem(label: 'ForgeIQ CV builder'),
            const SizedBox(height: 8),
            _LockedFeatureItem(label: 'UpliftIQ learning'),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go('/pricing-plans'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.amber,
                  foregroundColor: HireIQTheme.primaryNavy,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                ),
                child: Text(
                  'Renew subscription',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Downgrade to free',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: HireIQTheme.primaryTeal,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Contact support',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: HireIQTheme.textMuted,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LockedFeatureItem extends StatelessWidget {
  const _LockedFeatureItem({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.lock_outline_rounded,
          size: 18,
          color: HireIQTheme.textLight,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: HireIQTheme.textMuted,
          ),
        ),
      ],
    );
  }
}
