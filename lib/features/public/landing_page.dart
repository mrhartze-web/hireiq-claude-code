import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/footer/web_footer.dart';
import '../../shared/navigation/web_nav_bar.dart';
import '../../shared/theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Landing page
// Note: WebNavBar and WebFooter are used directly here rather than through
// WebLayout, because WebLayout constrains its child to 1440px — which would
// prevent full-bleed section backgrounds on wider displays.
// ─────────────────────────────────────────────────────────────────────────────

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  final _howItWorksKey = GlobalKey();

  late final AnimationController _heroCtrl;
  late final Animation<double> _heroFade;
  late final Animation<Offset> _heroSlide;

  @override
  void initState() {
    super.initState();
    _heroCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _heroFade = CurvedAnimation(
      parent: _heroCtrl,
      curve: const Interval(0.0, 0.75, curve: Curves.easeOut),
    );
    _heroSlide = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _heroCtrl,
      curve: const Interval(0.0, 0.75, curve: Curves.easeOut),
    ));
    _heroCtrl.forward();
  }

  @override
  void dispose() {
    _heroCtrl.dispose();
    super.dispose();
  }

  void _scrollToHowItWorks() {
    final ctx = _howItWorksKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WebNavBar(),
      backgroundColor: HireIQTheme.surfaceWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _HeroSection(
              heroFade: _heroFade,
              heroSlide: _heroSlide,
              onScrollToHowItWorks: _scrollToHowItWorks,
            ),
            const _StatsBar(),
            _HowItWorksSection(sectionKey: _howItWorksKey),
            const _AIEnginesSection(),
            const _PricingPreviewSection(),
            const _CTASection(),
            const WebFooter(),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section 1 — Hero
// ─────────────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.heroFade,
    required this.heroSlide,
    required this.onScrollToHowItWorks,
  });

  final Animation<double> heroFade;
  final Animation<Offset> heroSlide;
  final VoidCallback onScrollToHowItWorks;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 860;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0B1628), HireIQTheme.primaryNavy, Color(0xFF1C3557)],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Ambient background blobs
          Positioned.fill(child: CustomPaint(painter: _HeroBgPainter())),

          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 60 : 24,
                  vertical: isWide ? 110 : 72,
                ),
                child: FadeTransition(
                  opacity: heroFade,
                  child: SlideTransition(
                    position: heroSlide,
                    child: Column(
                      children: [
                        // Badge pill
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: HireIQTheme.primaryTeal
                                .withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: HireIQTheme.primaryTeal
                                  .withValues(alpha: 0.4),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: HireIQTheme.primaryTeal,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'South Africa\'s first AI recruitment platform',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: HireIQTheme.primaryTeal,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Main heading
                        Text(
                          'Hire Smarter.\nWork Better.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: isWide ? 72 : 44,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.08,
                            letterSpacing: -2.0,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Subheading
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 680),
                          child: Text(
                            'South Africa\'s first AI-powered recruitment platform '
                            'connecting candidates, employers, and recruiters '
                            'with intelligent matching.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: isWide ? 19 : 16,
                              color: Colors.white.withValues(alpha: 0.65),
                              height: 1.65,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),

                        const SizedBox(height: 44),

                        // CTA buttons
                        Wrap(
                          spacing: 16,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children: [
                            _HeroCTA(
                              label: 'Get Started Free',
                              filled: true,
                              onTap: () => context.go('/signup'),
                            ),
                            _HeroCTA(
                              label: 'See How It Works',
                              filled: false,
                              onTap: onScrollToHowItWorks,
                            ),
                          ],
                        ),

                        const SizedBox(height: 52),

                        // Social proof chips
                        const Wrap(
                          spacing: 24,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children: [
                            _TrustChip(
                                icon: Icons.verified_rounded,
                                label: 'B-BBEE Compliant'),
                            _TrustChip(
                                icon: Icons.lock_outline_rounded,
                                label: 'POPIA Compliant'),
                            _TrustChip(
                                icon: Icons.star_rounded,
                                label: '4.9 / 5 Rating'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCTA extends StatefulWidget {
  const _HeroCTA({
    required this.label,
    required this.filled,
    required this.onTap,
  });

  final String label;
  final bool filled;
  final VoidCallback onTap;

  @override
  State<_HeroCTA> createState() => _HeroCTAState();
}

class _HeroCTAState extends State<_HeroCTA>
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
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => _press.forward(),
        onTapUp: (_) {
          _press.reverse();
          widget.onTap();
        },
        onTapCancel: () => _press.reverse(),
        child: ScaleTransition(
          scale: _scale,
          child: Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: widget.filled ? HireIQTheme.primaryTeal : Colors.transparent,
              border: widget.filled
                  ? null
                  : Border.all(
                      color: Colors.white.withValues(alpha: 0.55), width: 1.5),
              boxShadow: widget.filled
                  ? [
                      BoxShadow(
                        color: HireIQTheme.primaryTeal.withValues(alpha: 0.45),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      )
                    ]
                  : [],
            ),
            child: Center(
              child: Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TrustChip extends StatelessWidget {
  const _TrustChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: Colors.white.withValues(alpha: 0.4)),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.4),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section 2 — Stats bar
// ─────────────────────────────────────────────────────────────────────────────

class _StatsBar extends StatelessWidget {
  const _StatsBar();

  static const _stats = [
    ('10,000+', 'Candidates'),
    ('500+', 'Employers'),
    ('200+', 'Recruiters'),
    ('R50M+', 'Placed'),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 640;

    return Container(
      width: double.infinity,
      color: HireIQTheme.surfaceWhite,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 60 : 24,
              vertical: isWide ? 56 : 40,
            ),
            child: isWide
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _stats
                        .map((s) => _StatItem(value: s.$1, label: s.$2))
                        .toList(),
                  )
                : GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 2.2,
                    children: _stats
                        .map((s) => _StatItem(value: s.$1, label: s.$2))
                        .toList(),
                  ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 38,
            fontWeight: FontWeight.w800,
            color: HireIQTheme.primaryNavy,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: HireIQTheme.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section 3 — How It Works
// ─────────────────────────────────────────────────────────────────────────────

class _HowItWorksSection extends StatelessWidget {
  const _HowItWorksSection({required this.sectionKey});

  final GlobalKey sectionKey;

  static const _steps = [
    (
      1,
      Icons.person_add_outlined,
      'Create your profile',
      'Upload your CV, complete your skills profile, and let PassportIQ verify your credentials in minutes.',
    ),
    (
      2,
      Icons.bolt_rounded,
      'Get matched by AI',
      'MatchIQ scores every job against your profile in real time — surfacing the roles most likely to convert.',
    ),
    (
      3,
      Icons.handshake_outlined,
      'Connect and hire',
      'Interview, offer, and onboard — all tracked in one platform. Employers see only your verified skills.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 860;

    return Container(
      key: sectionKey,
      width: double.infinity,
      color: HireIQTheme.backgroundLight,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 60 : 24,
              vertical: 80,
            ),
            child: Column(
              children: [
                const _SectionLabel(
                    label: 'How It Works', accent: HireIQTheme.primaryTeal),
                const SizedBox(height: 14),
                Text(
                  'Intelligent hiring in three steps',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: isWide ? 40 : 28,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.textPrimary,
                    letterSpacing: -0.8,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'From sign-up to placement in days, not weeks.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: HireIQTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 56),
                isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _steps.asMap().entries.map((e) {
                          final last = e.key == _steps.length - 1;
                          return Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _StepCard(
                                    number: e.value.$1,
                                    icon: e.value.$2,
                                    title: e.value.$3,
                                    description: e.value.$4,
                                  ),
                                ),
                                if (!last)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 36),
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      color: HireIQTheme.primaryTeal
                                          .withValues(alpha: 0.4),
                                      size: 22,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    : Column(
                        children: _steps
                            .map((s) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: _StepCard(
                                    number: s.$1,
                                    icon: s.$2,
                                    title: s.$3,
                                    description: s.$4,
                                  ),
                                ))
                            .toList(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.number,
    required this.icon,
    required this.title,
    required this.description,
  });

  final int number;
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
              // Number badge
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: HireIQTheme.primaryTeal,
                ),
                child: Center(
                  child: Text(
                    '$number',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                ),
                child: Icon(icon,
                    size: 20, color: HireIQTheme.primaryTeal),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: HireIQTheme.textMuted,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section 4 — AI Engines
// ─────────────────────────────────────────────────────────────────────────────

class _AIEnginesSection extends StatelessWidget {
  const _AIEnginesSection();

  static const _engines = [
    (
      'MatchIQ',
      Icons.auto_awesome_rounded,
      'AI matching that scores candidates against every job requirement in real time.',
    ),
    (
      'PassportIQ',
      Icons.verified_rounded,
      'Instant credential verification — ID, qualifications, and references.',
    ),
    (
      'ForgeIQ',
      Icons.description_outlined,
      'AI CV builder that optimises your profile for every application.',
    ),
    (
      'WildcardIQ',
      Icons.shuffle_rounded,
      'Blind screening that removes bias and surfaces unexpected top performers.',
    ),
    (
      'SignalIQ',
      Icons.insights_rounded,
      'Live market intelligence — salary benchmarks and talent availability data.',
    ),
    (
      'UpliftIQ',
      Icons.trending_up_rounded,
      'Personalised learning paths that close your skills gap with market-aligned courses.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 860;
    final crossAxisCount = width >= 860 ? 3 : (width >= 580 ? 2 : 1);

    return Container(
      width: double.infinity,
      color: HireIQTheme.primaryNavy,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _NavyBgPainter()),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 60 : 24,
                  vertical: 80,
                ),
                child: Column(
                  children: [
                    const _SectionLabel(
                        label: 'AI-Powered',
                        accent: HireIQTheme.primaryTeal,
                        dark: true),
                    const SizedBox(height: 14),
                    Text(
                      'Powered by six AI engines',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: isWide ? 40 : 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.8,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Every decision on HireIQ is backed by purpose-built AI.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.55),
                      ),
                    ),
                    const SizedBox(height: 52),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: isWide ? 1.6 : 1.5,
                      ),
                      itemCount: _engines.length,
                      itemBuilder: (_, i) => _EngineCard(
                        name: _engines[i].$1,
                        icon: _engines[i].$2,
                        description: _engines[i].$3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EngineCard extends StatefulWidget {
  const _EngineCard({
    required this.name,
    required this.icon,
    required this.description,
  });

  final String name;
  final IconData icon;
  final String description;

  @override
  State<_EngineCard> createState() => _EngineCardState();
}

class _EngineCardState extends State<_EngineCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _hovered
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.05),
          border: Border.all(
            color: _hovered
                ? HireIQTheme.primaryTeal.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.1),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.15),
                  ),
                  child: Icon(widget.icon,
                      size: 18, color: HireIQTheme.primaryTeal),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.name,
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: HireIQTheme.primaryTeal,
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.description,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.white.withValues(alpha: 0.6),
                height: 1.55,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section 5 — Pricing preview
// ─────────────────────────────────────────────────────────────────────────────

class _PricingPreviewSection extends StatelessWidget {
  const _PricingPreviewSection();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 860;

    return Container(
      width: double.infinity,
      color: HireIQTheme.surfaceWhite,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? 60 : 24,
              vertical: 80,
            ),
            child: Column(
              children: [
                const _SectionLabel(
                    label: 'Pricing', accent: HireIQTheme.primaryNavy),
                const SizedBox(height: 14),
                Text(
                  'Transparent pricing for everyone',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: isWide ? 40 : 28,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.textPrimary,
                    letterSpacing: -0.8,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'No hidden fees. No lock-in contracts.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: HireIQTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 52),
                isWide
                    ? const IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: _PreviewPriceCard(
                                role: 'Candidate',
                                price: 'R49',
                                period: '/mo',
                                tagline: 'For job seekers',
                                badge: 'Most Popular',
                                accent: HireIQTheme.primaryTeal,
                                features: [
                                  'Unlimited applications',
                                  'PassportIQ verification',
                                  'ForgeIQ CV builder',
                                  'UpliftIQ learning path',
                                  'Priority job matching',
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _PreviewPriceCard(
                                role: 'Employer',
                                price: 'R4,999',
                                period: '/mo',
                                tagline: 'For companies hiring',
                                badge: 'Best Value',
                                accent: HireIQTheme.primaryNavy,
                                features: [
                                  'Unlimited job postings',
                                  'WildcardIQ blind screening',
                                  'SignalIQ market data',
                                  '5 team seats',
                                  'Priority support',
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _PreviewPriceCard(
                                role: 'Recruiter',
                                price: '0%',
                                period: ' monthly fee',
                                tagline: 'Commission-based only',
                                accent: HireIQTheme.recruiterAccent,
                                features: [
                                  '10% junior placements',
                                  '12% mid-level placements',
                                  '15% senior placements',
                                  'Full pipeline tools',
                                  'SignalIQ salary intel',
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : const Column(
                        children: [
                          _PreviewPriceCard(
                            role: 'Candidate',
                            price: 'R49',
                            period: '/mo',
                            tagline: 'For job seekers',
                            badge: 'Most Popular',
                            accent: HireIQTheme.primaryTeal,
                            features: [
                              'Unlimited applications',
                              'PassportIQ verification',
                              'ForgeIQ CV builder',
                              'UpliftIQ learning path',
                            ],
                          ),
                          SizedBox(height: 16),
                          _PreviewPriceCard(
                            role: 'Employer',
                            price: 'R4,999',
                            period: '/mo',
                            tagline: 'For companies hiring',
                            badge: 'Best Value',
                            accent: HireIQTheme.primaryNavy,
                            features: [
                              'Unlimited job postings',
                              'WildcardIQ blind screening',
                              'SignalIQ market data',
                              '5 team seats',
                            ],
                          ),
                          SizedBox(height: 16),
                          _PreviewPriceCard(
                            role: 'Recruiter',
                            price: '0%',
                            period: ' monthly fee',
                            tagline: 'Commission-based only',
                            accent: HireIQTheme.recruiterAccent,
                            features: [
                              '10–15% placement fee',
                              'Full pipeline tools',
                              'SignalIQ salary intel',
                            ],
                          ),
                        ],
                      ),
                const SizedBox(height: 32),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => context.go('/pricing'),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View full pricing details',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: HireIQTheme.primaryTeal,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 16,
                          color: HireIQTheme.primaryTeal,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PreviewPriceCard extends StatelessWidget {
  const _PreviewPriceCard({
    required this.role,
    required this.price,
    required this.period,
    required this.tagline,
    required this.accent,
    required this.features,
    this.badge,
  });

  final String role;
  final String price;
  final String period;
  final String tagline;
  final Color accent;
  final List<String> features;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final featured = badge != null;

    return Container(
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(18),
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
          // Badge
          if (featured)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(17),
                  topRight: Radius.circular(17),
                ),
              ),
              child: Text(
                badge!,
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
                  role,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: accent,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      price,
                      style: GoogleFonts.inter(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: HireIQTheme.textPrimary,
                        letterSpacing: -1.0,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      period,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: HireIQTheme.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  tagline,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: HireIQTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: HireIQTheme.borderLight, thickness: 1),
                const SizedBox(height: 14),
                ...features.map(
                  (f) => Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Row(
                      children: [
                        Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accent.withValues(alpha: 0.12),
                          ),
                          child: Icon(Icons.check_rounded,
                              size: 10, color: accent),
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            f,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: HireIQTheme.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // CTA
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => context.go('/signup'),
                    child: Container(
                      width: double.infinity,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: featured ? accent : Colors.transparent,
                        border: featured
                            ? null
                            : Border.all(color: accent, width: 1.5),
                      ),
                      child: Center(
                        child: Text(
                          'Get Started',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: featured ? Colors.white : accent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section 6 — CTA banner
// ─────────────────────────────────────────────────────────────────────────────

class _CTASection extends StatelessWidget {
  const _CTASection();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 640;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A7A70), HireIQTheme.primaryTeal, Color(0xFF14B8AA)],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _TealBgPainter())),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 60 : 24,
                  vertical: 80,
                ),
                child: Column(
                  children: [
                    Text(
                      'Ready to hire smarter?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: isWide ? 44 : 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.8,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Join 10,000+ candidates, 500+ employers, and 200+ recruiters '
                      'already using HireIQ to build South Africa\'s future workforce.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.75),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 40),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => context.go('/signup'),
                        child: Container(
                          height: 54,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.18),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Get Started Free',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: HireIQTheme.primaryTeal,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                color: HireIQTheme.primaryTeal,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No credit card required · Free plan available',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared section label
// ─────────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({
    required this.label,
    required this.accent,
    this.dark = false,
  });

  final String label;
  final Color accent;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: dark ? 0.15 : 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: accent,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Background painters
// ─────────────────────────────────────────────────────────────────────────────

class _HeroBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.15),
      size.width * 0.35,
      Paint()
        ..shader = RadialGradient(colors: [
          HireIQTheme.primaryTeal.withValues(alpha: 0.15),
          Colors.transparent,
        ]).createShader(Rect.fromCircle(
          center: Offset(size.width * 0.85, size.height * 0.15),
          radius: size.width * 0.35,
        )),
    );
    canvas.drawCircle(
      Offset(size.width * 0.08, size.height * 0.85),
      size.width * 0.25,
      Paint()
        ..shader = RadialGradient(colors: [
          HireIQTheme.primaryTeal.withValues(alpha: 0.08),
          Colors.transparent,
        ]).createShader(Rect.fromCircle(
          center: Offset(size.width * 0.08, size.height * 0.85),
          radius: size.width * 0.25,
        )),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _NavyBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(size.width * 0.92, size.height * 0.1),
      size.width * 0.3,
      Paint()
        ..shader = RadialGradient(colors: [
          HireIQTheme.primaryTeal.withValues(alpha: 0.1),
          Colors.transparent,
        ]).createShader(Rect.fromCircle(
          center: Offset(size.width * 0.92, size.height * 0.1),
          radius: size.width * 0.3,
        )),
    );
    canvas.drawCircle(
      Offset(size.width * 0.05, size.height * 0.9),
      size.width * 0.25,
      Paint()
        ..shader = RadialGradient(colors: [
          HireIQTheme.primaryTeal.withValues(alpha: 0.07),
          Colors.transparent,
        ]).createShader(Rect.fromCircle(
          center: Offset(size.width * 0.05, size.height * 0.9),
          radius: size.width * 0.25,
        )),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _TealBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.2),
      size.width * 0.2,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.06),
    );
    canvas.drawCircle(
      Offset(size.width * 0.1, size.height * 0.8),
      size.width * 0.15,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.04),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
