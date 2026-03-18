import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';

// ── Mobile Pricing Screen ──────────────────────────────────────────────────────

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  int? _expandedFaq;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: HireIQTheme.textPrimary,
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'Pricing',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: HireIQTheme.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Intro ────────────────────────────────────────────────────────
            Text(
              'Choose your plan',
              style: GoogleFonts.inter(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: HireIQTheme.primaryNavy,
                letterSpacing: -0.5,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Simple, transparent pricing. Start free and scale as you grow.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: HireIQTheme.textMuted,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 28),

            // ── Candidate section ─────────────────────────────────────────────
            const _SectionHeader(
              label: 'For Candidates',
              icon: Icons.person_outline_rounded,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 290,
              child: ListView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                children: const [
                  _CandidateCard(
                    name: 'Free',
                    price: 'R0',
                    period: '/month',
                    subtitle: 'Get started with AI job matching',
                    features: [
                      'Up to 5 job applications/month',
                      'MatchIQ score visibility',
                      'Basic candidate profile',
                      'Job alert notifications',
                    ],
                    isHighlighted: false,
                  ),
                  SizedBox(width: 12),
                  _CandidateCard(
                    name: 'Pro',
                    price: 'R99',
                    period: '/month',
                    subtitle: 'Unlock the full HireIQ edge',
                    features: [
                      'Unlimited job applications',
                      'PassportIQ identity verification',
                      'ForgeIQ AI CV builder',
                      'UpliftIQ learning modules',
                      'Priority matching score',
                    ],
                    isHighlighted: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Employer section ──────────────────────────────────────────────
            const _SectionHeader(
              label: 'For Employers',
              icon: Icons.business_outlined,
            ),
            const SizedBox(height: 12),
            const _EmployerCard(
              name: 'Starter',
              price: 'R999',
              period: '/month',
              subtitle: 'Small teams getting started with smart hiring',
              features: [
                '3 active job posts',
                'MatchIQ candidate scoring',
                'Basic pipeline view',
                'Email support',
              ],
              variant: _EmployerVariant.standard,
            ),
            const SizedBox(height: 10),
            const _EmployerCard(
              name: 'Growth',
              price: 'R2,499',
              period: '/month',
              subtitle: 'Scale your hiring with the full AI suite',
              features: [
                '15 active job posts',
                'SignalIQ market intelligence',
                'WildcardIQ unbiased scoring',
                'Full pipeline + ATS integration',
                'Priority support',
              ],
              variant: _EmployerVariant.navy,
            ),
            const SizedBox(height: 10),
            const _EmployerCard(
              name: 'Enterprise',
              price: 'Custom',
              period: '',
              subtitle: 'Tailored solutions for large organisations',
              features: [
                'Unlimited job posts',
                'Dedicated account manager',
                'Custom API integrations',
                'SLA performance guarantee',
                'Onboarding & team training',
              ],
              variant: _EmployerVariant.amber,
            ),

            const SizedBox(height: 28),

            // ── Recruiter section ─────────────────────────────────────────────
            const _SectionHeader(
              label: 'For Recruiters',
              icon: Icons.work_outline_rounded,
            ),
            const SizedBox(height: 12),
            const _RecruiterCard(),

            const SizedBox(height: 28),

            // ── FAQ ───────────────────────────────────────────────────────────
            const _SectionHeader(
              label: 'Frequently Asked Questions',
              icon: Icons.help_outline_rounded,
            ),
            const SizedBox(height: 12),
            _FaqAccordion(
              expandedIndex: _expandedFaq,
              onToggle: (i) =>
                  setState(() => _expandedFaq = _expandedFaq == i ? null : i),
            ),

            const SizedBox(height: 24),

            // ── VAT footer note ───────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: HireIQTheme.primaryTeal,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'All prices are exclusive of VAT (15%). Billed monthly or annually. Cancel anytime with no penalty.',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: HireIQTheme.primaryTeal,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Section header ─────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: HireIQTheme.primaryNavy),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: HireIQTheme.primaryNavy,
          ),
        ),
      ],
    );
  }
}

// ── Candidate cards (horizontal scroll) ───────────────────────────────────────

class _CandidateCard extends StatelessWidget {
  const _CandidateCard({
    required this.name,
    required this.price,
    required this.period,
    required this.subtitle,
    required this.features,
    required this.isHighlighted,
  });

  final String name;
  final String price;
  final String period;
  final String subtitle;
  final List<String> features;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.72;

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isHighlighted ? HireIQTheme.primaryTeal : HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
          color: isHighlighted ? HireIQTheme.primaryTeal : HireIQTheme.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: isHighlighted
                ? HireIQTheme.primaryTeal.withValues(alpha: 0.18)
                : HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: isHighlighted
                  ? Colors.white.withValues(alpha: 0.2)
                  : HireIQTheme.background,
              borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
            ),
            child: Text(
              isHighlighted ? 'Most Popular' : 'Free forever',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isHighlighted ? Colors.white : HireIQTheme.textMuted,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Plan name
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isHighlighted ? Colors.white : HireIQTheme.primaryNavy,
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
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: isHighlighted ? Colors.white : HireIQTheme.primaryNavy,
                  height: 1.0,
                ),
              ),
              if (period.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4, left: 2),
                  child: Text(
                    period,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: isHighlighted
                          ? Colors.white.withValues(alpha: 0.75)
                          : HireIQTheme.textMuted,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),

          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: isHighlighted
                  ? Colors.white.withValues(alpha: 0.8)
                  : HireIQTheme.textMuted,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 16),

          // Features
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 15,
                    color: isHighlighted
                        ? Colors.white.withValues(alpha: 0.9)
                        : HireIQTheme.primaryTeal,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      f,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: isHighlighted
                            ? Colors.white.withValues(alpha: 0.9)
                            : HireIQTheme.textSecondary,
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

// ── Employer cards (stacked vertical) ─────────────────────────────────────────

enum _EmployerVariant { standard, navy, amber }

class _EmployerCard extends StatelessWidget {
  const _EmployerCard({
    required this.name,
    required this.price,
    required this.period,
    required this.subtitle,
    required this.features,
    required this.variant,
  });

  final String name;
  final String price;
  final String period;
  final String subtitle;
  final List<String> features;
  final _EmployerVariant variant;

  @override
  Widget build(BuildContext context) {
    final isNavy = variant == _EmployerVariant.navy;
    final isAmber = variant == _EmployerVariant.amber;

    final bg = isNavy ? HireIQTheme.primaryNavy : HireIQTheme.surfaceWhite;
    final borderColor = isAmber
        ? HireIQTheme.amber
        : isNavy
            ? HireIQTheme.primaryNavy
            : HireIQTheme.borderLight;
    final titleColor = isNavy ? Colors.white : HireIQTheme.primaryNavy;
    final priceColor = isNavy
        ? Colors.white
        : isAmber
            ? HireIQTheme.amber
            : HireIQTheme.primaryNavy;
    final subtitleColor =
        isNavy ? Colors.white.withValues(alpha: 0.7) : HireIQTheme.textMuted;
    final featureColor = isNavy
        ? Colors.white.withValues(alpha: 0.9)
        : HireIQTheme.textSecondary;
    final checkColor = isNavy
        ? Colors.white.withValues(alpha: 0.85)
        : isAmber
            ? HireIQTheme.amber
            : HireIQTheme.primaryTeal;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: borderColor, width: isAmber ? 2 : 1),
        boxShadow: [
          BoxShadow(
            color: isNavy
                ? HireIQTheme.primaryNavy.withValues(alpha: 0.15)
                : HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
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
                      name,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: subtitleColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: priceColor,
                      height: 1.0,
                    ),
                  ),
                  if (period.isNotEmpty)
                    Text(
                      period,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: subtitleColor,
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: isNavy ? 0 : 12),
          if (isNavy)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 1,
              color: Colors.white.withValues(alpha: 0.12),
            ),
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_rounded, size: 14, color: checkColor),
                  const SizedBox(width: 6),
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
          if (isNavy || isAmber) ...[
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isNavy ? HireIQTheme.primaryTeal : HireIQTheme.amber,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                ),
                child: Text(
                  isNavy ? 'Get Started' : 'Contact Sales',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Recruiter card ─────────────────────────────────────────────────────────────

class _RecruiterCard extends StatelessWidget {
  const _RecruiterCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Purple left accent bar
            Container(
              width: 4,
              decoration: const BoxDecoration(
                color: HireIQTheme.recruiterAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(HireIQTheme.radiusLg),
                  bottomLeft: Radius.circular(HireIQTheme.radiusLg),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
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
                                'Recruiter Platform',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: HireIQTheme.primaryNavy,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Manage briefs, build your CV vault, and earn on placements.',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: HireIQTheme.textMuted,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'R499',
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: HireIQTheme.recruiterAccent,
                                height: 1.0,
                              ),
                            ),
                            Text(
                              '/month',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: HireIQTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Fee table header
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: HireIQTheme.recruiterAccent.withValues(alpha: 0.06),
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Level',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: HireIQTheme.recruiterAccent,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Fee %',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: HireIQTheme.recruiterAccent,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Avg. Placement',
                              style: GoogleFonts.inter(
                                fontSize: 11,
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

                    const _FeeTierRow(
                      level: 'Junior',
                      fee: '10%',
                      placement: 'R20,000',
                      isShaded: false,
                    ),
                    const _FeeTierRow(
                      level: 'Mid-level',
                      fee: '12%',
                      placement: 'R36,000',
                      isShaded: true,
                    ),
                    const _FeeTierRow(
                      level: 'Senior',
                      fee: '15%',
                      placement: 'R75,000',
                      isShaded: false,
                    ),

                    const SizedBox(height: 14),

                    // Platform fee disclosure
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 14,
                          color: HireIQTheme.recruiterAccent,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'HireIQ retains 20% of the placement fee as a platform charge. You keep 80%. No monthly fees, no upfront costs.',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: HireIQTheme.textMuted,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    const _EarningsExampleCard(),
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

// ── Earnings example card ──────────────────────────────────────────────────────

class _EarningsExampleCard extends StatelessWidget {
  const _EarningsExampleCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: HireIQTheme.recruiterAccent.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
        border: Border.all(
          color: HireIQTheme.recruiterAccent.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Example placement',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.recruiterAccent,
            ),
          ),
          const SizedBox(height: 10),
          const _ExRow(label: 'Role', value: 'Senior Software Engineer'),
          const _ExRow(label: 'Annual Salary', value: 'R300,000'),
          const _ExRow(label: 'Placement Fee (12%)', value: 'R36,000'),
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
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
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
              fontSize: 12,
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

// ── Fee tier row ───────────────────────────────────────────────────────────────

class _FeeTierRow extends StatelessWidget {
  const _FeeTierRow({
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
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
                fontSize: 13,
                color: HireIQTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              fee,
              style: GoogleFonts.inter(
                fontSize: 13,
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
                fontSize: 13,
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

// ── FAQ accordion ──────────────────────────────────────────────────────────────

const _faqs = <(String, String)>[
  (
    'Can I switch plans at any time?',
    'Yes, you can upgrade or downgrade your plan at any time. Changes take effect at the start of your next billing cycle. There are no penalties for switching.'
  ),
  (
    'Is there a free trial for paid plans?',
    "All paid plans include a 14-day free trial. No credit card required to start. You'll only be billed after your trial period ends."
  ),
  (
    'How do recruiter placement fees work?',
    "Recruiters pay a monthly platform fee of R499. When a successful placement is made, a percentage fee is charged on the candidate's first-month salary based on role level: 10% for Junior, 12% for Mid-level, and 15% for Senior placements."
  ),
  (
    'What payment methods are accepted?',
    'We accept all major credit and debit cards (Visa, Mastercard), EFT, and instant EFT via PayFast. Enterprise customers can arrange invoice-based billing.'
  ),
];

class _FaqAccordion extends StatelessWidget {
  const _FaqAccordion({
    required this.expandedIndex,
    required this.onToggle,
  });

  final int? expandedIndex;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_faqs.length, (i) {
        final isOpen = expandedIndex == i;
        return GestureDetector(
          onTap: () => onToggle(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: HireIQTheme.surfaceWhite,
              borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
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
                        _faqs[i].$1,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: HireIQTheme.primaryNavy,
                          height: 1.4,
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
                        size: 22,
                      ),
                    ),
                  ],
                ),
                if (isOpen) ...[
                  const SizedBox(height: 10),
                  Text(
                    _faqs[i].$2,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: HireIQTheme.textMuted,
                      height: 1.55,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}
