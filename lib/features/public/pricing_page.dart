import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';
import '../../shared/components/web_layout.dart';
import '../../shared/footer/web_footer.dart';

// ── Web Pricing Page ───────────────────────────────────────────────────────────

class PricingPage extends StatefulWidget {
  const PricingPage({super.key});

  @override
  State<PricingPage> createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> {
  bool _isAnnual = false;
  int? _expandedFaq;

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      showNavBar: false,
      showFooter: false,
      child: Column(
        children: [
          const _WhiteNavBar(),
          _PricingHero(
            isAnnual: _isAnnual,
            onToggle: (v) => setState(() => _isAnnual = v),
          ),
          _PricingCardsSection(isAnnual: _isAnnual),
          const _WebRecruiterSection(),
          _WebFaqSection(
            expandedIndex: _expandedFaq,
            onToggle: (i) =>
                setState(() => _expandedFaq = _expandedFaq == i ? null : i),
          ),
          const WebFooter(),
        ],
      ),
    );
  }
}

// ── Custom white nav bar ───────────────────────────────────────────────────────

class _WhiteNavBar extends StatelessWidget {
  const _WhiteNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      height: 70,
      child: Row(
        children: [
          // Logo
          GestureDetector(
            onTap: () => context.go('/'),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Hire',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.primaryNavy,
                    letterSpacing: -0.5,
                  ),
                ),
                TextSpan(
                  text: 'IQ',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.primaryTeal,
                    letterSpacing: -0.5,
                  ),
                ),
              ]),
            ),
          ),

          const SizedBox(width: 40),

          // Nav links
          const Expanded(
            child: Row(
              children: [
                _NavLink(label: 'Find Jobs', route: '/jobs'),
                SizedBox(width: 28),
                _NavLink(label: 'Hire Talent', route: '/employer'),
                SizedBox(width: 28),
                _NavLink(label: 'For Recruiters', route: '/recruiter'),
                SizedBox(width: 28),
                _NavLink(label: 'Pricing', route: '/pricing', isActive: true),
              ],
            ),
          ),

          // Right CTAs
          Row(
            children: [
              TextButton(
                onPressed: () => context.go('/login'),
                child: Text(
                  'Sign in',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: HireIQTheme.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => context.go('/role-selection'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.primaryTeal,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                ),
                child: Text(
                  'Get started',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({
    required this.label,
    required this.route,
    this.isActive = false,
  });
  final String label;
  final String route;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          color:
              isActive ? HireIQTheme.primaryNavy : HireIQTheme.textSecondary,
          decoration: isActive ? TextDecoration.underline : TextDecoration.none,
          decorationColor: HireIQTheme.primaryTeal,
        ),
      ),
    );
  }
}

// ── Pricing hero + toggle ──────────────────────────────────────────────────────

class _PricingHero extends StatelessWidget {
  const _PricingHero({required this.isAnnual, required this.onToggle});
  final bool isAnnual;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: HireIQTheme.background,
      padding: const EdgeInsets.fromLTRB(40, 60, 40, 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            children: [
              Text(
                'Simple, transparent pricing',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  color: HireIQTheme.primaryNavy,
                  height: 1.15,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Start free, scale as you hire. No hidden fees, no surprise invoices.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: HireIQTheme.textMuted,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 32),

              // Monthly / Annual toggle
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: HireIQTheme.surfaceWhite,
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                  border: Border.all(color: HireIQTheme.borderLight),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ToggleChip(
                      label: 'Monthly',
                      isSelected: !isAnnual,
                      onTap: () => onToggle(false),
                    ),
                    _ToggleChip(
                      label: 'Annual  (save 20%)',
                      isSelected: isAnnual,
                      onTap: () => onToggle(true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToggleChip extends StatelessWidget {
  const _ToggleChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? HireIQTheme.primaryNavy : Colors.transparent,
          borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : HireIQTheme.textMuted,
          ),
        ),
      ),
    );
  }
}

// ── Pricing cards section ──────────────────────────────────────────────────────

class _PricingCardsSection extends StatelessWidget {
  const _PricingCardsSection({required this.isAnnual});
  final bool isAnnual;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.background,
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(builder: (ctx, constraints) {
            final cardWidth = (constraints.maxWidth - 64) / 5;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: _WebPricingCard(
                    name: 'Free',
                    price: 'R0',
                    period: '/month',
                    subtitle: 'For candidates just getting started',
                    features: const [
                      '5 applications/month',
                      'MatchIQ score',
                      'Basic profile',
                      'Job alerts',
                    ],
                    ctaLabel: 'Start free',
                    variant: _WebCardVariant.standard,
                    onCta: () => context.go('/role-selection'),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: cardWidth,
                  child: _WebPricingCard(
                    name: 'Pro',
                    price: isAnnual ? 'R79' : 'R99',
                    period: '/month',
                    subtitle: 'Unlock the full candidate edge',
                    features: const [
                      'Unlimited applications',
                      'PassportIQ verification',
                      'ForgeIQ CV builder',
                      'UpliftIQ learning',
                      'Priority matching',
                    ],
                    ctaLabel: 'Get Pro',
                    variant: _WebCardVariant.teal,
                    badge: 'Most Popular',
                    onCta: () => context.go('/role-selection'),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: cardWidth,
                  child: _WebPricingCard(
                    name: 'Founding Member',
                    price: isAnnual ? 'R49' : 'R59',
                    period: '/month',
                    subtitle: 'Early adopter lifetime deal',
                    features: const [
                      'All Pro features',
                      'Locked-in price forever',
                      'Founding badge on profile',
                      'Beta feature access',
                      'Direct founder support',
                    ],
                    ctaLabel: 'Claim now',
                    variant: _WebCardVariant.amber,
                    badge: 'Limited',
                    onCta: () => context.go('/thundafund'),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: cardWidth,
                  child: _WebPricingCard(
                    name: 'Growth',
                    price: isAnnual ? 'R1,999' : 'R2,499',
                    period: '/month',
                    subtitle: 'Scale your hiring with AI',
                    features: const [
                      '15 active job posts',
                      'SignalIQ market data',
                      'WildcardIQ scoring',
                      'Full pipeline + ATS',
                      'Priority support',
                    ],
                    ctaLabel: 'Get Growth',
                    variant: _WebCardVariant.navy,
                    badge: 'For Employers',
                    onCta: () => context.go('/role-selection'),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: cardWidth,
                  child: _WebPricingCard(
                    name: 'Enterprise',
                    price: 'Custom',
                    period: '',
                    subtitle: 'Tailored for large organisations',
                    features: const [
                      'Unlimited job posts',
                      'Dedicated account manager',
                      'Custom integrations',
                      'SLA guarantee',
                      'Onboarding & training',
                    ],
                    ctaLabel: 'Contact sales',
                    variant: _WebCardVariant.standard,
                    onCta: () => context.go('/contact'),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

enum _WebCardVariant { standard, teal, navy, amber }

class _WebPricingCard extends StatelessWidget {
  const _WebPricingCard({
    required this.name,
    required this.price,
    required this.period,
    required this.subtitle,
    required this.features,
    required this.ctaLabel,
    required this.variant,
    required this.onCta,
    this.badge,
  });

  final String name;
  final String price;
  final String period;
  final String subtitle;
  final List<String> features;
  final String ctaLabel;
  final _WebCardVariant variant;
  final VoidCallback onCta;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final isNavy = variant == _WebCardVariant.navy;
    final isTeal = variant == _WebCardVariant.teal;
    final isAmber = variant == _WebCardVariant.amber;

    final bg = isNavy
        ? HireIQTheme.primaryNavy
        : isTeal
            ? HireIQTheme.primaryTeal
            : HireIQTheme.surfaceWhite;

    final borderColor = isAmber
        ? HireIQTheme.amber
        : (isNavy || isTeal)
            ? Colors.transparent
            : HireIQTheme.borderLight;

    final titleColor =
        (isNavy || isTeal) ? Colors.white : HireIQTheme.primaryNavy;
    final priceColor = isAmber
        ? HireIQTheme.amber
        : (isNavy || isTeal)
            ? Colors.white
            : HireIQTheme.primaryNavy;

    final subtitleColor = (isNavy || isTeal)
        ? Colors.white.withValues(alpha: 0.7)
        : HireIQTheme.textMuted;

    final featureColor = (isNavy || isTeal)
        ? Colors.white.withValues(alpha: 0.9)
        : HireIQTheme.textSecondary;

    final checkColor = isAmber
        ? HireIQTheme.amber
        : (isNavy || isTeal)
            ? Colors.white.withValues(alpha: 0.85)
            : HireIQTheme.primaryTeal;

    final ctaBg = isNavy
        ? HireIQTheme.primaryTeal
        : isTeal
            ? Colors.white
            : isAmber
                ? HireIQTheme.amber
                : HireIQTheme.primaryNavy;

    final ctaFg = isTeal ? HireIQTheme.primaryTeal : Colors.white;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: borderColor, width: isAmber ? 2 : 1),
        boxShadow: [
          BoxShadow(
            color: (isNavy || isTeal)
                ? Colors.black.withValues(alpha: 0.12)
                : HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge
          if (badge != null) ...[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: (isNavy || isTeal)
                    ? Colors.white.withValues(alpha: 0.15)
                    : isAmber
                        ? HireIQTheme.amber.withValues(alpha: 0.12)
                        : HireIQTheme.primaryNavy.withValues(alpha: 0.08),
                borderRadius:
                    BorderRadius.circular(HireIQTheme.radiusFull),
              ),
              child: Text(
                badge!,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: (isNavy || isTeal)
                      ? Colors.white
                      : isAmber
                          ? HireIQTheme.amber
                          : HireIQTheme.primaryNavy,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ] else
            const SizedBox(height: 6),

          // Plan name
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 4),

          // Price
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: priceColor,
                  height: 1.0,
                ),
              ),
              if (period.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 3, left: 2),
                  child: Text(
                    period,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: subtitleColor,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),

          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: subtitleColor,
              height: 1.45,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              color: (isNavy || isTeal)
                  ? Colors.white.withValues(alpha: 0.12)
                  : HireIQTheme.borderLight,
              height: 1,
            ),
          ),

          // Features
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_rounded, size: 14, color: checkColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      f,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: featureColor,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // CTA button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onCta,
              style: ElevatedButton.styleFrom(
                backgroundColor: ctaBg,
                foregroundColor: ctaFg,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusMd),
                ),
              ),
              child: Text(
                ctaLabel,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Web recruiter section ──────────────────────────────────────────────────────

class _WebRecruiterSection extends StatelessWidget {
  const _WebRecruiterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.background,
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section header
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 36,
                    decoration: BoxDecoration(
                      color: HireIQTheme.recruiterAccent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'For Recruiters',
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: HireIQTheme.primaryNavy,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: HireIQTheme.recruiterAccent
                          .withValues(alpha: 0.1),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusFull),
                    ),
                    child: Text(
                      'Commission-based · No monthly fee',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: HireIQTheme.recruiterAccent,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: fee table + disclosure
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: HireIQTheme.surfaceWhite,
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusLg),
                        border: const Border(
                          left: BorderSide(
                              color: HireIQTheme.recruiterAccent, width: 4),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: HireIQTheme.primaryNavy
                                .withValues(alpha: 0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Fee table header
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: HireIQTheme.recruiterAccent
                                  .withValues(alpha: 0.06),
                              borderRadius: BorderRadius.circular(
                                  HireIQTheme.radiusMd),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Level',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: HireIQTheme.recruiterAccent,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Fee %',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: HireIQTheme.recruiterAccent,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Total Placement Fee',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: HireIQTheme.recruiterAccent,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          const _WebFeeTierRow(
                            level: 'Junior',
                            fee: '10%',
                            placement: 'R20,000',
                            isShaded: false,
                          ),
                          const _WebFeeTierRow(
                            level: 'Mid-level',
                            fee: '12%',
                            placement: 'R36,000',
                            isShaded: true,
                          ),
                          const _WebFeeTierRow(
                            level: 'Senior',
                            fee: '15%',
                            placement: 'R75,000',
                            isShaded: false,
                          ),
                          const SizedBox(height: 16),
                          // Disclosure
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.info_outline_rounded,
                                size: 15,
                                color: HireIQTheme.recruiterAccent,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'HireIQ retains 20% of the placement fee as a platform charge. You keep 80%. No monthly fees, no upfront costs.',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                    color: HireIQTheme.textMuted,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 32),

                  // Right: earnings example
                  const Expanded(
                    flex: 2,
                    child: _EarningsExampleCard(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WebFeeTierRow extends StatelessWidget {
  const _WebFeeTierRow({
    required this.level,
    required this.fee,
    required this.placement,
    required this.isShaded,
  });

  final String level;
  final String fee;
  final String placement;
  final bool isShaded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isShaded ? HireIQTheme.background : HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              level,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: HireIQTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              fee,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: HireIQTheme.recruiterAccent,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              placement,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: HireIQTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Earnings example card (web) ────────────────────────────────────────────────

class _EarningsExampleCard extends StatelessWidget {
  const _EarningsExampleCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
          color: HireIQTheme.recruiterAccent.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.recruiterAccent.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color:
                      HireIQTheme.recruiterAccent.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calculate_outlined,
                  size: 16,
                  color: HireIQTheme.recruiterAccent,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Example placement',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.recruiterAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const _ExRow(label: 'Role', value: 'Senior Software Engineer'),
          const _ExRow(label: 'Annual Salary', value: 'R300,000'),
          const _ExRow(label: 'Placement Fee (12%)', value: 'R36,000'),
          const Divider(height: 20, color: HireIQTheme.borderLight),
          const _ExRow(label: 'HireIQ Platform Cut (20%)', value: 'R7,200'),
          const _ExRow(
            label: 'Your Earnings (80%)',
            value: 'R28,800',
            isHighlighted: true,
          ),
        ],
      ),
    );
  }
}

class _ExRow extends StatelessWidget {
  const _ExRow({
    required this.label,
    required this.value,
    this.isHighlighted = false,
  });

  final String label;
  final String value;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: isHighlighted
                  ? HireIQTheme.primaryTeal
                  : HireIQTheme.textMuted,
              fontWeight:
                  isHighlighted ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight:
                  isHighlighted ? FontWeight.w700 : FontWeight.w500,
              color: isHighlighted
                  ? HireIQTheme.primaryTeal
                  : HireIQTheme.primaryNavy,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Web FAQ section ────────────────────────────────────────────────────────────

const _webFaqs = <(String, String)>[
  (
    'Can I switch plans at any time?',
    'Yes, you can upgrade or downgrade your plan at any time from your account settings. Changes take effect at the start of your next billing cycle with no penalties.'
  ),
  (
    'Is there a free trial for paid plans?',
    "All paid plans include a 14-day free trial. No credit card required to start — you'll only be billed if you choose to continue after the trial period ends."
  ),
  (
    'What is the Founding Member plan?',
    "The Founding Member plan is a limited early adopter offer. Members lock in a discounted rate forever, plus get a special badge, beta access, and direct founder support. Available while our Thundafund campaign is live."
  ),
  (
    'How does annual billing work?',
    "Choosing annual billing gives you a 20% discount versus the monthly price. You're billed for a full year upfront. If you cancel, unused months are refunded pro-rata."
  ),
  (
    'What payment methods are accepted?',
    'We accept all major credit and debit cards (Visa, Mastercard), instant EFT via PayFast, and traditional EFT. Enterprise customers can arrange monthly invoice billing.'
  ),
  (
    'Are prices inclusive of VAT?',
    'All displayed prices are exclusive of VAT (15%). VAT is added at checkout. Enterprise pricing is negotiated directly and may vary based on contract structure.'
  ),
];

class _WebFaqSection extends StatelessWidget {
  const _WebFaqSection({
    required this.expandedIndex,
    required this.onToggle,
  });
  final int? expandedIndex;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.surfaceWhite,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            children: [
              Text(
                'Frequently Asked Questions',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: HireIQTheme.primaryNavy,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 40),
              ...List.generate(_webFaqs.length, (i) {
                final isOpen = expandedIndex == i;
                return GestureDetector(
                  onTap: () => onToggle(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg),
                      border: Border.all(
                        color: isOpen
                            ? HireIQTheme.primaryTeal.withValues(alpha: 0.4)
                            : HireIQTheme.borderLight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                _webFaqs[i].$1,
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: HireIQTheme.primaryNavy,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            AnimatedRotation(
                              turns: isOpen ? 0.5 : 0,
                              duration: const Duration(milliseconds: 220),
                              child: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: HireIQTheme.textMuted,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                        if (isOpen) ...[
                          const SizedBox(height: 12),
                          Text(
                            _webFaqs[i].$2,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: HireIQTheme.textMuted,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
