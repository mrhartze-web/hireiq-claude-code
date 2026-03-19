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
              price: 'R1,999',
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
              price: 'R9,999',
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
              price: 'R49,999+',
              period: '/month',
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

// ── Recruiter plan cards ────────────────────────────────────────────────────────

class _RecruiterCard extends StatelessWidget {
  const _RecruiterCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Solo + Agency plans side by side
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _RecruiterPlanCard(
                name: 'Solo',
                price: 'R2,999',
                subtitle: 'Individual recruiter',
                features: const [
                  'CRM pipeline',
                  'CV vault',
                  'Brief upload & management',
                  'ShieldIQ fraud detection',
                  'SignalIQ market intelligence',
                ],
                isHighlighted: false,
                onCta: () => context.go('/signup?role=recruiter'),
                ctaLabel: 'Join as Recruiter',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _RecruiterPlanCard(
                name: 'Agency',
                price: 'R19,999',
                subtitle: 'Multi-seat team plan',
                features: const [
                  'All Solo features',
                  'Multi-seat team management',
                  'Bulk brief processing',
                  'Agency analytics dashboard',
                  'White-label reports',
                ],
                isHighlighted: true,
                badge: 'Most Popular',
                onCta: () => context.go('/contact'),
                ctaLabel: 'Contact Sales',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Credits card
        const _RecruiterCreditsCard(),
      ],
    );
  }
}

class _RecruiterPlanCard extends StatelessWidget {
  const _RecruiterPlanCard({
    required this.name,
    required this.price,
    required this.subtitle,
    required this.features,
    required this.isHighlighted,
    required this.onCta,
    required this.ctaLabel,
    this.badge,
  });

  final String name;
  final String price;
  final String subtitle;
  final List<String> features;
  final bool isHighlighted;
  final VoidCallback onCta;
  final String ctaLabel;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isHighlighted
            ? HireIQTheme.recruiterAccent
            : HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
          color: isHighlighted
              ? HireIQTheme.recruiterAccent
              : HireIQTheme.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.recruiterAccent
                .withValues(alpha: isHighlighted ? 0.2 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (badge != null) ...[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: isHighlighted
                    ? Colors.white.withValues(alpha: 0.25)
                    : HireIQTheme.recruiterAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
              ),
              child: Text(
                badge!,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isHighlighted
                      ? Colors.white
                      : HireIQTheme.recruiterAccent,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color:
                  isHighlighted ? Colors.white : HireIQTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: isHighlighted
                  ? Colors.white.withValues(alpha: 0.75)
                  : HireIQTheme.textMuted,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: GoogleFonts.inter(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color:
                      isHighlighted ? Colors.white : HireIQTheme.recruiterAccent,
                  height: 1.0,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  '/month',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: isHighlighted
                        ? Colors.white.withValues(alpha: 0.7)
                        : HireIQTheme.textMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 16,
                    color: isHighlighted
                        ? Colors.white.withValues(alpha: 0.9)
                        : HireIQTheme.primaryTeal,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      f,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: isHighlighted
                            ? Colors.white.withValues(alpha: 0.9)
                            : HireIQTheme.textPrimary,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onCta,
              style: ElevatedButton.styleFrom(
                backgroundColor: isHighlighted
                    ? Colors.white
                    : HireIQTheme.recruiterAccent,
                foregroundColor: isHighlighted
                    ? HireIQTheme.recruiterAccent
                    : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusMd),
                ),
                elevation: 0,
              ),
              child: Text(
                ctaLabel,
                style: GoogleFonts.inter(
                  fontSize: 14,
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

class _RecruiterCreditsCard extends StatelessWidget {
  const _RecruiterCreditsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: HireIQTheme.recruiterAccent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
            ),
            child: const Icon(
              Icons.bolt_rounded,
              size: 22,
              color: HireIQTheme.recruiterAccent,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Credit Packs',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: HireIQTheme.primaryNavy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'R25 per credit — ad-hoc candidate unlocks, no subscription needed',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: HireIQTheme.textMuted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'R25',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: HireIQTheme.recruiterAccent,
              height: 1.0,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '/credit',
            style: GoogleFonts.inter(
              fontSize: 11,
              color: HireIQTheme.textMuted,
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
    'How does recruiter pricing work?',
    'Recruiters choose a subscription plan: Solo at R2,999/month for individual recruiters, or Agency at R19,999/month for multi-seat teams. Credit packs (R25 per credit) are available for ad-hoc candidate unlocks without a subscription.'
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
