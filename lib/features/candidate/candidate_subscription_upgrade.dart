import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateSubscriptionUpgrade extends StatelessWidget {
  const CandidateSubscriptionUpgrade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.primaryNavy,
      body: SafeArea(
        child: Column(
          children: [
            // ── Close button row ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Upgrade to Pro',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 18,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Scrollable content ─────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
                child: Column(
                  children: [
                    // Crown icon with glow
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: HireIQTheme.amber.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: HireIQTheme.amber.withValues(alpha: 0.3),
                            blurRadius: 24,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.workspace_premium_rounded,
                        color: HireIQTheme.amber,
                        size: 42,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Stand out to top employers',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Get 3x more profile views and priority placement\nwith HireIQ Pro.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: Colors.white.withValues(alpha: 0.65),
                        height: 1.55,
                      ),
                    ),

                    const SizedBox(height: 36),

                    // ── Pricing card ────────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: HireIQTheme.surfaceWhite,
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusXl),
                        boxShadow: [
                          BoxShadow(
                            color:
                                HireIQTheme.primaryNavy.withValues(alpha: 0.3),
                            blurRadius: 32,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Plan label
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: HireIQTheme.amber.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(
                                  HireIQTheme.radiusFull),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.workspace_premium_rounded,
                                  size: 13,
                                  color: HireIQTheme.amber,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Pro Plan',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: HireIQTheme.amber,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  'R',
                                  style: GoogleFonts.inter(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: HireIQTheme.primaryTeal,
                                  ),
                                ),
                              ),
                              Text(
                                '49',
                                style: GoogleFonts.inter(
                                  fontSize: 56,
                                  fontWeight: FontWeight.w800,
                                  color: HireIQTheme.primaryTeal,
                                  letterSpacing: -2,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            'per month',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: HireIQTheme.textMuted,
                            ),
                          ),

                          const SizedBox(height: 24),

                          const Divider(color: HireIQTheme.borderLight),

                          const SizedBox(height: 20),

                          // Feature rows
                          const _FeatureRow(
                            label: 'Priority MatchIQ ranking',
                          ),
                          const _FeatureRow(
                            label: 'Unlimited skill assessments',
                          ),
                          const _FeatureRow(
                            label: 'Detailed salary insights',
                          ),
                          const _FeatureRow(
                            label: 'Direct messaging with recruiters',
                            isLast: true,
                          ),

                          const SizedBox(height: 28),

                          // CTA button
                          GestureDetector(
                            onTap: () {
                              context.pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Successfully upgraded to Pro!'),
                                ),
                              );
                            },
                            child: Container(
                              height: 54,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    HireIQTheme.primaryTeal,
                                    Color(0xFF0A7A70),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(
                                    HireIQTheme.radiusMd),
                                boxShadow: [
                                  BoxShadow(
                                    color: HireIQTheme.primaryTeal
                                        .withValues(alpha: 0.35),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.workspace_premium_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Upgrade Now',
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          Text(
                            'Cancel anytime · No hidden fees',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: HireIQTheme.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Feature row ────────────────────────────────────────────────────────────────

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.label, this.isLast = false});

  final String label;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              size: 14,
              color: HireIQTheme.primaryTeal,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: HireIQTheme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
