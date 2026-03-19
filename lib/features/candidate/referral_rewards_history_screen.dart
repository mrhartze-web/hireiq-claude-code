import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class ReferralRewardsHistoryScreen extends ConsumerWidget {
  const ReferralRewardsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const events = [
      (
        name: 'Sipho Dlamini signed up',
        date: '12 Mar 2026',
        reward: '+R150 credit',
        status: 'Credited',
      ),
      (
        name: 'Amara Osei converted',
        date: '28 Feb 2026',
        reward: '+R150 credit',
        status: 'Credited',
      ),
      (
        name: 'Kavya Reddy signed up',
        date: '14 Feb 2026',
        reward: '+R150 credit',
        status: 'Pending',
      ),
      (
        name: 'Liam van der Berg signed up',
        date: '01 Feb 2026',
        reward: '+R0',
        status: 'Pending signup',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Rewards History',
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
            // Summary card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
                gradient: const LinearGradient(
                  colors: [HireIQTheme.primaryNavy, Color(0xFF243659)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...[
                    ('R450', 'Total earned'),
                    ('R150', 'Redeemed'),
                    ('R300', 'Available'),
                  ].map(
                    (item) => Column(
                      children: [
                        Text(
                          item.$1,
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: HireIQTheme.primaryTeal,
                          ),
                        ),
                        Text(
                          item.$2,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'History',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy,
              ),
            ),

            const SizedBox(height: 12),

            // Event cards
            ...events.map((event) {
              final isCredited = event.status == 'Credited';
              final statusColor =
                  isCredited ? HireIQTheme.primaryTeal : HireIQTheme.amber;
              final statusBg = isCredited
                  ? HireIQTheme.primaryTeal.withValues(alpha: 0.1)
                  : HireIQTheme.amber.withValues(alpha: 0.1);

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                  border: Border.all(color: HireIQTheme.borderLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.name,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: HireIQTheme.primaryNavy,
                                ),
                              ),
                              Text(
                                event.date,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: HireIQTheme.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius:
                                BorderRadius.circular(HireIQTheme.radiusFull),
                          ),
                          child: Text(
                            event.status,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      event.reward,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: HireIQTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
