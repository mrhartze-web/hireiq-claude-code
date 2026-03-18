import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class ThundafundRewards extends StatelessWidget {
  const ThundafundRewards({super.key});

  static const List<_RewardTier> _tiers = [
    _RewardTier(
      label: 'Supporter',
      amount: 'R100',
      perks: [
        'HireIQ Supporter badge on profile',
        'Early access to beta features',
        'Monthly backer newsletter',
      ],
      highlight: false,
    ),
    _RewardTier(
      label: 'Champion',
      amount: 'R500',
      perks: [
        'Everything in Supporter',
        '3 months HireIQ Pro free',
        'Name in the app credits',
        'Private Discord channel access',
      ],
      highlight: true,
    ),
    _RewardTier(
      label: 'Founder',
      amount: 'R2,000',
      perks: [
        'Everything in Champion',
        '12 months HireIQ Pro free',
        'Founding member certificate',
        'Quarterly product roadmap calls',
        'Direct feedback line to our team',
      ],
      highlight: false,
    ),
    _RewardTier(
      label: 'Patron',
      amount: 'R10,000',
      perks: [
        'Everything in Founder',
        'Lifetime HireIQ Pro subscription',
        'Co-design session with founding team',
        'Advisory board invitation',
        'Company logo on our website',
      ],
      highlight: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Backer Rewards',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose a tier that fits your belief in fair hiring.',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: HireIQTheme.textMuted,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            ..._tiers.map((tier) => _buildTierCard(tier)),
            const SizedBox(height: 16),
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
                      'Pledge checkout integration coming soon.',
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

  Widget _buildTierCard(_RewardTier tier) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: tier.highlight
            ? HireIQTheme.primaryNavy
            : HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
          color: tier.highlight
              ? HireIQTheme.primaryNavy
              : HireIQTheme.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy
                .withValues(alpha: tier.highlight ? 0.12 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tier.label,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:
                      tier.highlight ? Colors.white : HireIQTheme.primaryNavy,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: tier.highlight
                      ? Colors.white.withValues(alpha: 0.15)
                      : HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  tier.amount,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: tier.highlight
                        ? Colors.white
                        : HireIQTheme.primaryTeal,
                  ),
                ),
              ),
            ],
          ),
          if (tier.highlight) ...[
            const SizedBox(height: 4),
            Text(
              'Most popular',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: HireIQTheme.primaryTeal,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          const SizedBox(height: 16),
          ...tier.perks.map(
            (perk) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: tier.highlight
                        ? HireIQTheme.primaryTeal
                        : HireIQTheme.primaryTeal,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      perk,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: tier.highlight
                            ? Colors.white.withValues(alpha: 0.85)
                            : HireIQTheme.textMuted,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardTier {
  const _RewardTier({
    required this.label,
    required this.amount,
    required this.perks,
    required this.highlight,
  });
  final String label;
  final String amount;
  final List<String> perks;
  final bool highlight;
}
