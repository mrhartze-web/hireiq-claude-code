import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Data models
// ─────────────────────────────────────────────────────────────────────────────

class _Feature {
  const _Feature(this.label, {this.highlight = false});
  final String label;
  final bool highlight;
}

class _PlanCard {
  const _PlanCard({
    required this.name,
    required this.price,
    required this.period,
    required this.description,
    required this.features,
    required this.accent,
    required this.cta,
    this.badge,
    this.isFeatured = false,
  });

  final String name;
  final String price;
  final String period;
  final String description;
  final List<_Feature> features;
  final Color accent;
  final String cta;
  final String? badge;
  final bool isFeatured;
}

// ─────────────────────────────────────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────────────────────────────────────

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen>
    with SingleTickerProviderStateMixin {
  bool _candidatePro = false; // false = Free, true = Pro

  late final AnimationController _entranceCtrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    ));

    _entranceCtrl.forward();
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    super.dispose();
  }

  // ── Candidate plans ────────────────────────────────────────────────────────

  _PlanCard get _candidateFree => const _PlanCard(
        name: 'Free',
        price: 'R0',
        period: '',
        description: 'Everything you need to start your job search.',
        features: [
          _Feature('CV upload & profile'),
          _Feature('AI job matching'),
          _Feature('5 applications per month'),
          _Feature('Public candidate profile'),
        ],
        accent: HireIQTheme.primaryTeal,
        cta: 'Get Started Free',
      );

  _PlanCard get _proCard => const _PlanCard(
        name: 'Pro',
        price: 'R49',
        period: '/mo',
        description: 'Unlock your full potential with AI-powered tools.',
        features: [
          _Feature('Everything in Free'),
          _Feature('Unlimited applications', highlight: true),
          _Feature('PassportIQ verification', highlight: true),
          _Feature('ForgeIQ CV builder', highlight: true),
          _Feature('UpliftIQ learning path', highlight: true),
          _Feature('Priority job matching', highlight: true),
        ],
        accent: HireIQTheme.primaryTeal,
        cta: 'Start Pro',
        badge: 'Most Popular',
        isFeatured: true,
      );

  // ── Employer plans ─────────────────────────────────────────────────────────

  static const List<_PlanCard> _employerPlans = [
    _PlanCard(
      name: 'Starter',
      price: 'R1,999',
      period: '/mo',
      description: 'For small teams making their first hires.',
      features: [
        _Feature('3 active job postings'),
        _Feature('MatchIQ candidate scoring'),
        _Feature('Basic analytics dashboard'),
        _Feature('Email support'),
      ],
      accent: HireIQTheme.primaryNavy,
      cta: 'Get Started',
    ),
    _PlanCard(
      name: 'Growth',
      price: 'R4,999',
      period: '/mo',
      description: 'For scaling teams that need serious hiring intelligence.',
      features: [
        _Feature('Everything in Starter'),
        _Feature('Unlimited job postings', highlight: true),
        _Feature('WildcardIQ blind screening', highlight: true),
        _Feature('SignalIQ market intelligence', highlight: true),
        _Feature('5 team seats', highlight: true),
        _Feature('Priority support'),
      ],
      accent: HireIQTheme.primaryNavy,
      cta: 'Start Growing',
      badge: 'Best Value',
      isFeatured: true,
    ),
    _PlanCard(
      name: 'Enterprise',
      price: 'Custom',
      period: '',
      description: 'For large organisations with complex hiring needs.',
      features: [
        _Feature('Everything in Growth'),
        _Feature('Dedicated account manager'),
        _Feature('B-BBEE reporting & compliance'),
        _Feature('API access & integrations'),
        _Feature('Custom team seats'),
        _Feature('SLA guarantee'),
      ],
      accent: HireIQTheme.primaryNavy,
      cta: 'Contact Sales',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 800;

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.surfaceWhite,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded,
              color: HireIQTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'Hire',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: HireIQTheme.primaryNavy,
              ),
            ),
            TextSpan(
              text: 'IQ',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: HireIQTheme.primaryTeal,
              ),
            ),
          ]),
        ),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
              height: 1, thickness: 1, color: HireIQTheme.borderLight),
        ),
      ),
      body: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 40 : 20,
              vertical: 36,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── Page heading ─────────────────────────────────────
                Text(
                  'Simple, transparent pricing',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: isWide ? 36 : 28,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.textPrimary,
                    letterSpacing: -0.8,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'No hidden fees. No lock-in contracts. Cancel anytime.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: HireIQTheme.textMuted,
                  ),
                ),

                const SizedBox(height: 48),

                // ═══════════════════════════════════════════════════
                // CANDIDATE TIER
                // ═══════════════════════════════════════════════════
                const _SectionHeader(
                  icon: Icons.person_outline_rounded,
                  label: 'Candidate',
                  accent: HireIQTheme.primaryTeal,
                ),
                const SizedBox(height: 16),

                // Free / Pro toggle
                _PlanToggle(
                  isOn: _candidatePro,
                  onLabel: 'Pro  R49/mo',
                  offLabel: 'Free',
                  accent: HireIQTheme.primaryTeal,
                  onChanged: (v) {
                    HapticFeedback.selectionClick();
                    setState(() => _candidatePro = v);
                  },
                ),
                const SizedBox(height: 20),

                // Single animated candidate card
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, anim) => FadeTransition(
                    opacity: anim,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.04),
                        end: Offset.zero,
                      ).animate(anim),
                      child: child,
                    ),
                  ),
                  child: _PricingCard(
                    key: ValueKey(_candidatePro),
                    plan: _candidatePro ? _proCard : _candidateFree,
                    maxWidth: isWide ? 420 : double.infinity,
                  ),
                ),

                const SizedBox(height: 52),

                // ═══════════════════════════════════════════════════
                // EMPLOYER TIER
                // ═══════════════════════════════════════════════════
                const _SectionHeader(
                  icon: Icons.business_outlined,
                  label: 'Employer',
                  accent: HireIQTheme.primaryNavy,
                ),
                const SizedBox(height: 24),

                isWide
                    ? const _WideCardRow(plans: _employerPlans)
                    : const _StackedCards(plans: _employerPlans),

                const SizedBox(height: 52),

                // ═══════════════════════════════════════════════════
                // RECRUITER TIER
                // ═══════════════════════════════════════════════════
                const _SectionHeader(
                  icon: Icons.handshake_outlined,
                  label: 'Recruiter',
                  accent: HireIQTheme.recruiterAccent,
                ),
                const SizedBox(height: 24),

                _RecruiterCard(maxWidth: isWide ? 560 : double.infinity),

                const SizedBox(height: 48),

                // Bottom note
                Text(
                  'All prices are in South African Rand (ZAR) and exclude VAT.\nEmployer and Recruiter plans billed monthly. Cancel anytime.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: HireIQTheme.textLight,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section header
// ─────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.label,
    required this.accent,
  });

  final IconData icon;
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: accent.withValues(alpha: 0.12),
          ),
          child: Icon(icon, size: 17, color: accent),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: HireIQTheme.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Divider(color: HireIQTheme.borderLight, thickness: 1),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Plan toggle (Free ↔ Pro)
// ─────────────────────────────────────────────────────────────────────────────

class _PlanToggle extends StatelessWidget {
  const _PlanToggle({
    required this.isOn,
    required this.offLabel,
    required this.onLabel,
    required this.accent,
    required this.onChanged,
  });

  final bool isOn;
  final String offLabel;
  final String onLabel;
  final Color accent;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: HireIQTheme.backgroundLight,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _TogglePill(
            label: offLabel,
            active: !isOn,
            accent: accent,
            onTap: () => onChanged(false),
          ),
          const SizedBox(width: 4),
          _TogglePill(
            label: onLabel,
            active: isOn,
            accent: accent,
            onTap: () => onChanged(true),
          ),
        ],
      ),
    );
  }
}

class _TogglePill extends StatelessWidget {
  const _TogglePill({
    required this.label,
    required this.active,
    required this.accent,
    required this.onTap,
  });

  final String label;
  final bool active;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: active ? accent : Colors.transparent,
          borderRadius: BorderRadius.circular(32),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ]
              : [],
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : HireIQTheme.textMuted,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pricing card
// ─────────────────────────────────────────────────────────────────────────────

class _PricingCard extends StatelessWidget {
  const _PricingCard({
    super.key,
    required this.plan,
    this.maxWidth = double.infinity,
  });

  final _PlanCard plan;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final featured = plan.isFeatured;
    final accent = plan.accent;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Container(
          decoration: BoxDecoration(
            color: HireIQTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: featured ? accent : HireIQTheme.borderLight,
              width: featured ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: featured
                    ? accent.withValues(alpha: 0.14)
                    : Colors.black.withValues(alpha: 0.05),
                blurRadius: featured ? 28 : 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Badge strip
              if (plan.badge != null)
                _BadgeStrip(label: plan.badge!, accent: accent),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Plan name
                    Text(
                      plan.name,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: accent,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Price
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          plan.price,
                          style: GoogleFonts.inter(
                            fontSize: 38,
                            fontWeight: FontWeight.w800,
                            color: HireIQTheme.textPrimary,
                            letterSpacing: -1.0,
                            height: 1.0,
                          ),
                        ),
                        if (plan.period.isNotEmpty) ...[
                          const SizedBox(width: 4),
                          Text(
                            plan.period,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: HireIQTheme.textMuted,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Description
                    Text(
                      plan.description,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: HireIQTheme.textMuted,
                        height: 1.5,
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider(
                          color: HireIQTheme.borderLight, thickness: 1),
                    ),

                    // Features
                    ...plan.features.map(
                      (f) => _FeatureRow(feature: f, accent: accent),
                    ),

                    const SizedBox(height: 24),

                    // CTA
                    _CardButton(
                      label: plan.cta,
                      accent: accent,
                      filled: featured,
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

// ─────────────────────────────────────────────────────────────────────────────
// Badge strip
// ─────────────────────────────────────────────────────────────────────────────

class _BadgeStrip extends StatelessWidget {
  const _BadgeStrip({required this.label, required this.accent});
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: accent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(19),
          topRight: Radius.circular(19),
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Feature row
// ─────────────────────────────────────────────────────────────────────────────

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.feature, required this.accent});
  final _Feature feature;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 18,
            height: 18,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.withValues(alpha: feature.highlight ? 0.15 : 0.08),
            ),
            child: Icon(
              Icons.check_rounded,
              size: 11,
              color: accent,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              feature.label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight:
                    feature.highlight ? FontWeight.w600 : FontWeight.w400,
                color: feature.highlight
                    ? HireIQTheme.textPrimary
                    : HireIQTheme.textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Card CTA button
// ─────────────────────────────────────────────────────────────────────────────

class _CardButton extends StatefulWidget {
  const _CardButton({
    required this.label,
    required this.accent,
    required this.filled,
  });

  final String label;
  final Color accent;
  final bool filled;

  @override
  State<_CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<_CardButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _press;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _press = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _press, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _press.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _press.forward(),
      onTapUp: (_) {
        _press.reverse();
        context.go('/signup');
      },
      onTapCancel: () => _press.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: widget.filled ? widget.accent : Colors.transparent,
            border: widget.filled
                ? null
                : Border.all(color: widget.accent, width: 1.5),
            boxShadow: widget.filled
                ? [
                    BoxShadow(
                      color: widget.accent.withValues(alpha: 0.3),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              widget.label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: widget.filled ? Colors.white : widget.accent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Wide three-column row
// ─────────────────────────────────────────────────────────────────────────────

class _WideCardRow extends StatelessWidget {
  const _WideCardRow({required this.plans});
  final List<_PlanCard> plans;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: plans.asMap().entries.map((e) {
          final i = e.key;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: i == 0 ? 0 : 8,
                right: i == plans.length - 1 ? 0 : 8,
              ),
              child: _PricingCard(plan: e.value),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stacked cards (mobile)
// ─────────────────────────────────────────────────────────────────────────────

class _StackedCards extends StatelessWidget {
  const _StackedCards({required this.plans});
  final List<_PlanCard> plans;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: plans
          .map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _PricingCard(plan: p),
              ))
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Recruiter card
// ─────────────────────────────────────────────────────────────────────────────

class _RecruiterCard extends StatelessWidget {
  const _RecruiterCard({this.maxWidth = double.infinity});
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    const accent = HireIQTheme.recruiterAccent;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Container(
          decoration: BoxDecoration(
            color: HireIQTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: accent, width: 2),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.14),
                blurRadius: 28,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header strip
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(19),
                    topRight: Radius.circular(19),
                  ),
                ),
                child: Text(
                  'Commission Based — No Monthly Fee',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recruiter',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: accent,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Zero upfront cost.',
                      style: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: HireIQTheme.textPrimary,
                        letterSpacing: -0.8,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'You earn when you place. We succeed together.',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: HireIQTheme.textMuted,
                        height: 1.5,
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider(
                          color: HireIQTheme.borderLight, thickness: 1),
                    ),

                    // Fee tiers
                    Text(
                      'Fee Structure',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),

                    const _FeeTierRow(
                      level: 'Junior roles',
                      rate: '10%',
                      accent: accent,
                    ),
                    const SizedBox(height: 8),
                    const _FeeTierRow(
                      level: 'Mid-level roles',
                      rate: '12%',
                      accent: accent,
                      highlight: true,
                    ),
                    const SizedBox(height: 8),
                    const _FeeTierRow(
                      level: 'Senior & Specialist',
                      rate: '15%',
                      accent: accent,
                    ),

                    const SizedBox(height: 20),

                    // Example calculation
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: accent.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calculate_outlined,
                                size: 15,
                                color: accent,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Example calculation',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: accent,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const _ExampleRow(
                            label: 'Annual salary',
                            value: 'R300,000',
                          ),
                          const SizedBox(height: 4),
                          const _ExampleRow(
                            label: 'Commission rate',
                            value: '12% (mid-level)',
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Divider(
                                color: accent.withValues(alpha: 0.2),
                                thickness: 1),
                          ),
                          const _ExampleRow(
                            label: 'Your fee',
                            value: 'R36,000',
                            bold: true,
                            valueColor: accent,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),
                    Text(
                      'Calculated on candidate\'s first year annual salary.',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: HireIQTheme.textLight,
                      ),
                    ),

                    const SizedBox(height: 24),

                    const _CardButton(
                      label: 'Get Started',
                      accent: accent,
                      filled: true,
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

// ─────────────────────────────────────────────────────────────────────────────
// Fee tier row
// ─────────────────────────────────────────────────────────────────────────────

class _FeeTierRow extends StatelessWidget {
  const _FeeTierRow({
    required this.level,
    required this.rate,
    required this.accent,
    this.highlight = false,
  });

  final String level;
  final String rate;
  final Color accent;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: highlight
            ? accent.withValues(alpha: 0.08)
            : HireIQTheme.backgroundLight,
        borderRadius: BorderRadius.circular(10),
        border: highlight
            ? Border.all(color: accent.withValues(alpha: 0.25))
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              level,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight:
                    highlight ? FontWeight.w600 : FontWeight.w400,
                color: highlight
                    ? HireIQTheme.textPrimary
                    : HireIQTheme.textSecondary,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: highlight ? 0.15 : 0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              rate,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Example row
// ─────────────────────────────────────────────────────────────────────────────

class _ExampleRow extends StatelessWidget {
  const _ExampleRow({
    required this.label,
    required this.value,
    this.bold = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool bold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: HireIQTheme.textMuted,
            fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
            color: valueColor ?? HireIQTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
