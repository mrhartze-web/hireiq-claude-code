import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/auth_provider.dart';
import '../../providers/subscription_provider.dart';
import '../../shared/theme.dart';

// ── Mobile Pricing Screen ──────────────────────────────────────────────────────

class PricingScreen extends ConsumerStatefulWidget {
  const PricingScreen({super.key});

  @override
  ConsumerState<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends ConsumerState<PricingScreen> {
  int? _expandedFaq;
  String? _loadingPlanId;

  Future<void> _initiatePurchase(
      String planId, String billingRoute) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) {
      context.go('/signup');
      return;
    }
    setState(() => _loadingPlanId = planId);
    try {
      await ref.read(subscriptionServiceProvider).initiateSubscription(
            userId: user.uid,
            planId: planId,
            userEmail: user.email ?? '',
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Redirecting to secure payment — powered by Peach Payments'),
          backgroundColor: HireIQTheme.primaryNavy,
        ),
      );
      context.go(billingRoute);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment error: ${e.toString()}'),
          backgroundColor: HireIQTheme.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _loadingPlanId = null);
    }
  }

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
            // ── Intro ──────────────────────────────────────────────────
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

            // ── Candidate section ───────────────────────────────────────
            const _SectionHeader(
              label: 'For Candidates',
              icon: Icons.person_outline_rounded,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 430,
              child: ListView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                children: [
                  _CandidateCard(
                    name: 'Free',
                    price: 'R0',
                    period: '/month',
                    subtitle: 'Get started with AI job matching',
                    features: const [
                      'Up to 5 job applications/month',
                      'MatchIQ score visibility',
                      'Basic candidate profile',
                      'Job alert notifications',
                    ],
                    isHighlighted: false,
                    ctaLabel: 'Get Started Free',
                    isLoading: false,
                    onCta: () => context.go('/signup'),
                  ),
                  const SizedBox(width: 12),
                  _CandidateCard(
                    name: 'Pro',
                    price: 'R29',
                    period: '/month',
                    subtitle: 'Unlock the full HireIQ edge',
                    features: const [
                      'Unlimited job applications',
                      'PassportIQ identity verification',
                      'ForgeIQ AI CV builder',
                      'UpliftIQ learning modules',
                      'Priority matching score',
                    ],
                    isHighlighted: true,
                    ctaLabel: 'Get Started',
                    isLoading: _loadingPlanId == 'candidate_pro',
                    onCta: () => _initiatePurchase(
                        'candidate_pro',
                        '/candidate/candidate-billing-settings'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Employer section ────────────────────────────────────────
            const _SectionHeader(
              label: 'For Employers',
              icon: Icons.business_outlined,
            ),
            const SizedBox(height: 12),
            _EmployerCard(
              name: 'Starter',
              price: 'R799',
              period: '/month',
              subtitle: 'Small teams getting started with smart hiring',
              features: const [
                '3 active job posts',
                'MatchIQ candidate scoring',
                'Basic pipeline view',
                'Email support',
              ],
              variant: _EmployerVariant.standard,
              isLoading: _loadingPlanId == 'employer_starter',
              onCta: () => _initiatePurchase(
                  'employer_starter', '/employer/employer-billing'),
            ),
            const SizedBox(height: 10),
            _EmployerCard(
              name: 'Growth',
              price: 'R3,999',
              period: '/month',
              subtitle: 'Scale your hiring with the full AI suite',
              features: const [
                '15 active job posts',
                'SignalIQ market intelligence',
                'WildcardIQ unbiased scoring',
                'Full pipeline + ATS integration',
                'Priority support',
              ],
              variant: _EmployerVariant.navy,
              isLoading: _loadingPlanId == 'employer_growth',
              onCta: () => _initiatePurchase(
                  'employer_growth', '/employer/employer-billing'),
            ),
            const SizedBox(height: 10),
            _EmployerCard(
              name: 'Enterprise',
              price: 'R49,999+',
              period: '/month',
              subtitle: 'Tailored solutions for large organisations',
              features: const [
                'Unlimited job posts',
                'Dedicated account manager',
                'Custom API integrations',
                'SLA performance guarantee',
                'Onboarding & team training',
              ],
              variant: _EmployerVariant.amber,
              isLoading: false,
              onCta: () => context.go('/contact'),
            ),

            const SizedBox(height: 28),

            // ── Recruiter section ───────────────────────────────────────
            const _SectionHeader(
              label: 'For Recruiters',
              icon: Icons.work_outline_rounded,
            ),
            const SizedBox(height: 12),
            _RecruiterCard(
              onSoloCta: () => _initiatePurchase(
                  'recruiter_solo', '/recruiter/recruiter-settings'),
              isSoloLoading: _loadingPlanId == 'recruiter_solo',
            ),

            const SizedBox(height: 28),

            // ── FAQ ─────────────────────────────────────────────────────
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

            // ── VAT footer note ─────────────────────────────────────────
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
                      'All prices are exclusive of VAT (15%). Billed monthly. Cancel anytime with no penalty.',
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

// ── Peach trust badge ──────────────────────────────────────────────────────────

class _PeachBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lock, size: 14, color: HireIQTheme.textMuted),
          const SizedBox(width: 4),
          Text(
            'Secured by Peach Payments',
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
    required this.ctaLabel,
    required this.isLoading,
    required this.onCta,
  });

  final String name;
  final String price;
  final String period;
  final String subtitle;
  final List<String> features;
  final bool isHighlighted;
  final String ctaLabel;
  final bool isLoading;
  final VoidCallback onCta;

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

          const Spacer(),

          // CTA button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : onCta,
              style: ElevatedButton.styleFrom(
                backgroundColor: isHighlighted
                    ? Colors.white
                    : HireIQTheme.primaryNavy,
                foregroundColor: isHighlighted
                    ? HireIQTheme.primaryTeal
                    : Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                ),
              ),
              child: isLoading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: isHighlighted
                            ? HireIQTheme.primaryTeal
                            : Colors.white,
                      ),
                    )
                  : Text(
                      ctaLabel,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),

          // Peach badge — paid plans only
          if (isHighlighted) _PeachBadge(),
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
    required this.isLoading,
    required this.onCta,
  });

  final String name;
  final String price;
  final String period;
  final String subtitle;
  final List<String> features;
  final _EmployerVariant variant;
  final bool isLoading;
  final VoidCallback onCta;

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

    final btnBg = isAmber
        ? HireIQTheme.amber
        : HireIQTheme.primaryTeal;
    final btnLabel = isAmber ? 'Contact Sales' : 'Get Started';

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
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : onCta,
              style: ElevatedButton.styleFrom(
                backgroundColor: btnBg,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : Text(
                      btnLabel,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
          // Peach badge for paid plans (not Contact Sales)
          if (!isAmber) _PeachBadge(),
        ],
      ),
    );
  }
}

// ── Recruiter plan cards ────────────────────────────────────────────────────────

class _RecruiterCard extends StatelessWidget {
  const _RecruiterCard({
    required this.onSoloCta,
    required this.isSoloLoading,
  });

  final VoidCallback onSoloCta;
  final bool isSoloLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _RecruiterPlanCard(
                name: 'Solo',
                price: 'R999',
                subtitle: 'Individual recruiter',
                features: const [
                  'CRM pipeline',
                  'CV vault',
                  'Brief upload & management',
                  'ShieldIQ fraud detection',
                  'SignalIQ market intelligence',
                ],
                isHighlighted: false,
                onCta: onSoloCta,
                ctaLabel: 'Join as Recruiter',
                isLoading: isSoloLoading,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _RecruiterPlanCard(
                name: 'Agency',
                price: 'R7,999',
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
                isLoading: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
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
    required this.isLoading,
    this.badge,
  });

  final String name;
  final String price;
  final String subtitle;
  final List<String> features;
  final bool isHighlighted;
  final VoidCallback onCta;
  final String ctaLabel;
  final bool isLoading;
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
              color: isHighlighted ? Colors.white : HireIQTheme.primaryNavy,
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
                  color: isHighlighted
                      ? Colors.white
                      : HireIQTheme.recruiterAccent,
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
              onPressed: isLoading ? null : onCta,
              style: ElevatedButton.styleFrom(
                backgroundColor: isHighlighted
                    ? Colors.white
                    : HireIQTheme.recruiterAccent,
                foregroundColor: isHighlighted
                    ? HireIQTheme.recruiterAccent
                    : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: isHighlighted
                            ? HireIQTheme.recruiterAccent
                            : Colors.white,
                      ),
                    )
                  : Text(
                      ctaLabel,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
          // Peach badge for Solo (payment plan), not Agency (Contact Sales)
          if (!isHighlighted) _PeachBadge(),
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
    'Recruiters choose a subscription plan: Solo at R999/month for individual recruiters, or Agency at R7,999/month for multi-seat teams. Credit packs (R25 per credit) are available for ad-hoc candidate unlocks without a subscription.'
  ),
  (
    'What payment methods are accepted?',
    'We accept all major credit and debit cards (Visa, Mastercard, Amex), EFT, SnapScan, and Ozow — all secured by Peach Payments.'
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
