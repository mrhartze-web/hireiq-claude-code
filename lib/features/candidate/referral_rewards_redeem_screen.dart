import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class ReferralRewardsRedeemScreen extends ConsumerWidget {
  const ReferralRewardsRedeemScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const options = [
      (
        title: '1 Month Pro Free',
        desc: 'Extend your Pro subscription by one month — valued at R99',
        enabled: true,
      ),
      (
        title: 'Commission Discount',
        desc: 'Get 10% off your next gig commission fee',
        enabled: true,
      ),
      (
        title: 'Cash to Wallet',
        desc: 'Withdraw to Peach Payments wallet — coming soon',
        enabled: false,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Redeem Rewards',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Balance section
            Center(
              child: Column(
                children: [
                  Text(
                    'Available balance',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: HireIQTheme.textMuted,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'R300',
                    style: GoogleFonts.inter(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryTeal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '3 credits available',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: HireIQTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            Text(
              'Redemption options',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy,
              ),
            ),

            const SizedBox(height: 12),

            // Redemption option cards
            ...options.map((option) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                    border: Border.all(color: HireIQTheme.borderLight),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              option.title,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: HireIQTheme.primaryNavy,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              option.desc,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: HireIQTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: option.enabled
                            ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Redemption requested')),
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: option.enabled
                              ? HireIQTheme.amber
                              : HireIQTheme.borderLight,
                          foregroundColor: option.enabled
                              ? HireIQTheme.primaryNavy
                              : HireIQTheme.textMuted,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(HireIQTheme.radiusMd),
                          ),
                        ),
                        child: const Text('Redeem'),
                      ),
                    ],
                  ),
                )),

            const SizedBox(height: 24),

            // Terms & Conditions
            Center(
              child: TextButton(
                onPressed: () => context.go('/terms'),
                child: Text(
                  'Terms & Conditions',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: HireIQTheme.primaryTeal,
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
