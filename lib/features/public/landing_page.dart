import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Landing Page — HireIQ Web
// Sections: accent bar → nav → hero → stats → journey cards → AI ecosystem →
//           pricing tabs → founder quote → CTA banner → footer
// ─────────────────────────────────────────────────────────────────────────────

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _pricingTab = 0; // 0 = Candidates, 1 = Employers, 2 = Recruiters

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _TopAccentBar(),
            const _LandingNav(),
            const _HeroSection(),
            const _StatsBar(),
            const _UserJourneySection(),
            const _EcosystemSection(),
            _PricingSection(
              selectedTab: _pricingTab,
              onTabChanged: (i) => setState(() => _pricingTab = i),
            ),
            const _FounderQuoteSection(),
            const _CtaBanner(),
            const _LandingFooter(),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 1. Top accent bar
// ─────────────────────────────────────────────────────────────────────────────

class _TopAccentBar extends StatelessWidget {
  const _TopAccentBar();

  @override
  Widget build(BuildContext context) =>
      Container(height: 3, color: HireIQTheme.primaryTeal);
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. Navigation bar
// ─────────────────────────────────────────────────────────────────────────────

class _LandingNav extends StatelessWidget {
  const _LandingNav();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 600;
      return Container(
        height: 68,
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 48),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.97),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isMobile ? _MobileNavRow() : _DesktopNavRow(),
      );
    });
  }
}

class _DesktopNavRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _NavLogo(),
        const SizedBox(width: 40),
        Expanded(
          child: Row(
            children: [
              _NavLink(label: 'Find Jobs', route: '/role-selection'),
              const SizedBox(width: 28),
              _NavLink(label: 'Hire Talent', route: '/role-selection'),
              const SizedBox(width: 28),
              _NavLink(label: 'For Recruiters', route: '/role-selection'),
              const SizedBox(width: 28),
              _NavLink(label: 'Pricing', route: '/pricing'),
            ],
          ),
        ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                ),
              ),
              child: Text(
                'Get started',
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MobileNavRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _NavLogo(),
        const Spacer(),
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
        IconButton(
          icon: const Icon(Icons.menu_rounded, color: HireIQTheme.primaryNavy),
          tooltip: 'Menu',
          onPressed: () => _showMobileMenu(context),
        ),
      ],
    );
  }

  void _showMobileMenu(BuildContext outerCtx) {
    showModalBottomSheet(
      context: outerCtx,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: HireIQTheme.borderLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _sheetLink(sheetCtx, outerCtx, 'Find Jobs', '/role-selection'),
              _sheetLink(sheetCtx, outerCtx, 'Hire Talent', '/role-selection'),
              _sheetLink(
                  sheetCtx, outerCtx, 'For Recruiters', '/role-selection'),
              _sheetLink(sheetCtx, outerCtx, 'Pricing', '/pricing'),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(sheetCtx);
                  outerCtx.go('/role-selection');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.primaryTeal,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                ),
                child: Text(
                  'Get started free',
                  style: GoogleFonts.inter(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sheetLink(BuildContext sheetCtx, BuildContext outerCtx, String label,
      String route) {
    return InkWell(
      onTap: () {
        Navigator.pop(sheetCtx);
        outerCtx.go(route);
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: HireIQTheme.primaryNavy,
          ),
        ),
      ),
    );
  }
}

class _NavLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/landing'),
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
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({required this.label, required this.route});
  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: HireIQTheme.textSecondary,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. Hero section
// ─────────────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 600;
      return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              HireIQTheme.primaryNavy,
              Color(0xFF0F3460),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Dot grid overlay
            Positioned.fill(
              child: CustomPaint(painter: _DotGridPainter()),
            ),
            // Content
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 48,
                vertical: isMobile ? 64 : 96,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      // AI badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color:
                              HireIQTheme.primaryTeal.withValues(alpha: 0.15),
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusFull),
                          border: Border.all(
                            color:
                                HireIQTheme.primaryTeal.withValues(alpha: 0.35),
                          ),
                        ),
                        child: Text(
                          'Powered by AI  ·  Built for South Africa',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: HireIQTheme.primaryTeal,
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Headline
                      Text(
                        'Hire smarter.\nGrow faster.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: isMobile ? 42 : 60,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.1,
                          letterSpacing: -1.5,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Sub-headline
                      Text(
                        'HireIQ connects top candidates with great employers using AI-powered matching, skills verification, and real-time market intelligence.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: isMobile ? 16 : 18,
                          color: Colors.white.withValues(alpha: 0.75),
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // CTA buttons
                      isMobile
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _HeroPrimaryBtn(),
                                const SizedBox(height: 12),
                                _HeroSecondaryBtn(),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _HeroPrimaryBtn(),
                                const SizedBox(width: 16),
                                _HeroSecondaryBtn(),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _HeroPrimaryBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.go('/role-selection'),
      style: ElevatedButton.styleFrom(
        backgroundColor: HireIQTheme.primaryTeal,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
        ),
      ),
      child: Text(
        'Get started free',
        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _HeroSecondaryBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => context.go('/pricing'),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
        ),
      ),
      child: Text(
        'View pricing',
        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..style = PaintingStyle.fill;
    const spacing = 28.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. Stats bar
// ─────────────────────────────────────────────────────────────────────────────

const _kStats = <(String, String)>[
  ('50,000+', 'Active candidates'),
  ('2,500+', 'Verified employers'),
  ('12,000+', 'Successful placements'),
  ('94%', 'Match satisfaction rate'),
];

class _StatsBar extends StatelessWidget {
  const _StatsBar();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 600;
      return Container(
        color: HireIQTheme.primaryTeal,
        padding:
            EdgeInsets.symmetric(horizontal: isMobile ? 24 : 48, vertical: 28),
        child: isMobile
            ? Wrap(
                spacing: 32,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: _kStats.map(_buildStat).toList(),
              )
            : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _kStats.map(_buildStat).toList(),
                  ),
                ),
              ),
      );
    });
  }

  Widget _buildStat((String, String) s) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          s.$1,
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          s.$2,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 5. User journey cards — Candidates / Employers / Recruiters
// ─────────────────────────────────────────────────────────────────────────────

class _UserJourneySection extends StatelessWidget {
  const _UserJourneySection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 600;
      return Container(
        color: HireIQTheme.surfaceWhite,
        padding:
            EdgeInsets.symmetric(horizontal: isMobile ? 24 : 48, vertical: 80),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              children: [
                Text(
                  'Built for every side of hiring',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.primaryNavy,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Whether you\'re looking for work, filling a role, or placing talent — HireIQ has a plan for you.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: HireIQTheme.textMuted,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 48),
                isMobile
                    ? Column(
                        children: [
                          _JourneyCard(
                            icon: Icons.person_search_outlined,
                            title: 'For Candidates',
                            description:
                                'Land better roles faster with AI that matches your skills to the right opportunities and builds your profile for you.',
                            accentColor: HireIQTheme.primaryTeal,
                            features: const [
                              'MatchIQ smart job matching',
                              'ForgeIQ AI CV builder',
                              'PassportIQ credential verification',
                              'UpliftIQ career coaching',
                              '15 applications per day',
                            ],
                            ctaLabel: 'Find jobs',
                            ctaRoute: '/role-selection',
                          ),
                          const SizedBox(height: 24),
                          _JourneyCard(
                            icon: Icons.business_outlined,
                            title: 'For Employers',
                            description:
                                'Stop sifting through unqualified CVs. HireIQ surfaces verified, scored candidates matched to your exact requirements.',
                            accentColor: HireIQTheme.primaryNavy,
                            features: const [
                              'AI-powered candidate matching',
                              'SignalIQ market intelligence',
                              'WildcardIQ unbiased scoring',
                              'ShieldIQ fraud detection',
                            ],
                            ctaLabel: 'Hire talent',
                            ctaRoute: '/role-selection',
                          ),
                          const SizedBox(height: 24),
                          _JourneyCard(
                            icon: Icons.groups_outlined,
                            title: 'For Recruiters',
                            description:
                                'Run your full desk from one platform. Manage briefs, CV vault, client relationships, and placements — powered by AI.',
                            accentColor: HireIQTheme.recruiterAccent,
                            features: const [
                              'AI brief builder',
                              'CV vault with smart search',
                              'Placement tracker',
                              'SignalIQ market data',
                              'Keep 80% of placement fee',
                            ],
                            ctaLabel: 'Start recruiting',
                            ctaRoute: '/role-selection',
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _JourneyCard(
                              icon: Icons.person_search_outlined,
                              title: 'For Candidates',
                              description:
                                  'Land better roles faster with AI that matches your skills to the right opportunities and builds your profile for you.',
                              accentColor: HireIQTheme.primaryTeal,
                              features: const [
                                'MatchIQ smart job matching',
                                'ForgeIQ AI CV builder',
                                'PassportIQ credential verification',
                                'UpliftIQ career coaching',
                                '15 applications per day',
                              ],
                              ctaLabel: 'Find jobs',
                              ctaRoute: '/role-selection',
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _JourneyCard(
                              icon: Icons.business_outlined,
                              title: 'For Employers',
                              description:
                                  'Stop sifting through unqualified CVs. HireIQ surfaces verified, scored candidates matched to your exact requirements.',
                              accentColor: HireIQTheme.primaryNavy,
                              features: const [
                                'AI-powered candidate matching',
                                'SignalIQ market intelligence',
                                'WildcardIQ unbiased scoring',
                                'ShieldIQ fraud detection',
                              ],
                              ctaLabel: 'Hire talent',
                              ctaRoute: '/role-selection',
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _JourneyCard(
                              icon: Icons.groups_outlined,
                              title: 'For Recruiters',
                              description:
                                  'Run your full desk from one platform. Manage briefs, CV vault, client relationships, and placements — powered by AI.',
                              accentColor: HireIQTheme.recruiterAccent,
                              features: const [
                                'AI brief builder',
                                'CV vault with smart search',
                                'Placement tracker',
                                'SignalIQ market data',
                                'Keep 80% of placement fee',
                              ],
                              ctaLabel: 'Start recruiting',
                              ctaRoute: '/role-selection',
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _JourneyCard extends StatelessWidget {
  const _JourneyCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.accentColor,
    required this.features,
    required this.ctaLabel,
    required this.ctaRoute,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color accentColor;
  final List<String> features;
  final String ctaLabel;
  final String ctaRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: HireIQTheme.background,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
            ),
            child: Icon(icon, size: 26, color: accentColor),
          ),
          const SizedBox(height: 20),

          // Title
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.primaryNavy,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 10),

          // Description
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: HireIQTheme.textMuted,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),

          // Features
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_rounded,
                      size: 16, color: accentColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      f,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: HireIQTheme.primaryNavy,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // CTA
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.go(ctaRoute),
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                ),
              ),
              child: Text(
                ctaLabel,
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 6. AI ecosystem — 7 engine cards in 4-column grid
// ─────────────────────────────────────────────────────────────────────────────

const _kIqCards = <(IconData, String, String, String, Color)>[
  (
    Icons.psychology_outlined,
    'MatchIQ',
    'AI-powered job matching that scores candidates on skills, experience, and culture fit.',
    'Candidates & Employers',
    Color(0xFF0D9488),
  ),
  (
    Icons.verified_user_outlined,
    'PassportIQ',
    'Identity verified directly with South Africa\'s Department of Home Affairs in real time.',
    'Candidates',
    Color(0xFF7C3AED),
  ),
  (
    Icons.trending_up_outlined,
    'SignalIQ',
    'Real-time salary benchmarks and market intelligence to inform every hiring decision.',
    'Employers & Recruiters',
    Color(0xFF2563EB),
  ),
  (
    Icons.auto_fix_high_outlined,
    'ForgeIQ',
    'AI CV builder that transforms your work history into a compelling, ATS-ready profile.',
    'Candidates',
    Color(0xFF059669),
  ),
  (
    Icons.shuffle_outlined,
    'WildcardIQ',
    'Unbiased scoring that surfaces hidden talent regardless of background or pedigree.',
    'Employers',
    Color(0xFFDC2626),
  ),
  (
    Icons.school_outlined,
    'UpliftIQ',
    'Personalised learning paths to help candidates close skill gaps and advance faster.',
    'Candidates',
    Color(0xFFF59E0B),
  ),
  (
    Icons.security_outlined,
    'ShieldIQ',
    'Fraud detection that eliminates fake listings, fake candidates, and misrepresented qualifications.',
    'Recruiters & Admin',
    Color(0xFFEF4444),
  ),
];

class _EcosystemSection extends StatelessWidget {
  const _EcosystemSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 600;
      final isTablet =
          constraints.maxWidth >= 600 && constraints.maxWidth < 900;
      final cols = isMobile ? 1 : (isTablet ? 2 : 4);

      return Container(
        color: HireIQTheme.background,
        padding:
            EdgeInsets.symmetric(horizontal: isMobile ? 24 : 48, vertical: 80),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              children: [
                Text(
                  'The HireIQ Ecosystem',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.primaryNavy,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Seven AI-powered tools working together to transform every step of the hiring journey.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: HireIQTheme.textMuted,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 48),
                LayoutBuilder(builder: (ctx, innerConstraints) {
                  final spacing = 16.0;
                  final totalSpacing = spacing * (cols - 1);
                  final cardWidth =
                      (innerConstraints.maxWidth - totalSpacing) / cols;
                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: _kIqCards.map((card) {
                      return SizedBox(
                        width: cardWidth,
                        child: _IqCard(
                          icon: card.$1,
                          name: card.$2,
                          description: card.$3,
                          target: card.$4,
                          color: card.$5,
                        ),
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _IqCard extends StatelessWidget {
  const _IqCard({
    required this.icon,
    required this.name,
    required this.description,
    required this.target,
    required this.color,
  });

  final IconData icon;
  final String name;
  final String description;
  final String target;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
            ),
            child: Icon(icon, size: 22, color: color),
          ),
          const SizedBox(height: 14),
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: HireIQTheme.textMuted,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
            ),
            child: Text(
              target,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 7. Tabbed pricing section
// ─────────────────────────────────────────────────────────────────────────────

class _PricingSection extends StatelessWidget {
  const _PricingSection({
    required this.selectedTab,
    required this.onTabChanged,
  });

  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 600;
      return Container(
        color: HireIQTheme.surfaceWhite,
        padding:
            EdgeInsets.symmetric(horizontal: isMobile ? 24 : 48, vertical: 80),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              children: [
                Text(
                  'Simple, milestone-based pricing',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.primaryNavy,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Start free. Pay when you see value. Pricing tied to your success, not the calendar.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: HireIQTheme.textMuted,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 36),

                // Tab selector
                Container(
                  decoration: BoxDecoration(
                    color: HireIQTheme.background,
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                    border: Border.all(color: HireIQTheme.borderLight),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _PricingTab(
                          label: 'Candidates',
                          index: 0,
                          selected: selectedTab,
                          onTap: onTabChanged),
                      _PricingTab(
                          label: 'Employers',
                          index: 1,
                          selected: selectedTab,
                          onTap: onTabChanged),
                      _PricingTab(
                          label: 'Recruiters',
                          index: 2,
                          selected: selectedTab,
                          onTap: onTabChanged),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Pricing cards
                if (selectedTab == 0) _CandidatePricing(isMobile: isMobile),
                if (selectedTab == 1) _EmployerPricing(isMobile: isMobile),
                if (selectedTab == 2) _RecruiterPricing(isMobile: isMobile),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _PricingTab extends StatelessWidget {
  const _PricingTab({
    required this.label,
    required this.index,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int index;
  final int selected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selected;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? HireIQTheme.primaryNavy : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : HireIQTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}

// ── Candidate pricing ──────────────────────────────────────────────────────

class _CandidatePricing extends StatelessWidget {
  const _CandidatePricing({required this.isMobile});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _PricingCard(
        name: 'Free',
        price: 'R0',
        period: '/month',
        subtitle: 'Get started with no commitment',
        features: const [
          'Browse all job listings',
          '3 applications per month',
          'Basic MatchIQ score preview',
          'Public profile',
        ],
        ctaLabel: 'Get started free',
        ctaRoute: '/role-selection',
        isHighlighted: false,
        accentColor: HireIQTheme.primaryNavy,
      ),
      _PricingCard(
        name: 'Pro',
        price: 'R29',
        period: '/month',
        subtitle: 'For serious job seekers',
        pricingNote: 'founding price — standard R49 after Milestone 3',
        features: const [
          '15 applications per day',
          'Full MatchIQ match scores',
          'ForgeIQ AI CV builder',
          'PassportIQ verification',
          'UpliftIQ career coaching',
          'Priority application badge',
        ],
        ctaLabel: 'Start Pro',
        ctaRoute: '/role-selection',
        isHighlighted: true,
        highlightLabel: 'Most popular',
        accentColor: HireIQTheme.primaryTeal,
      ),
      _PricingCard(
        name: 'Founding Member',
        price: 'R999',
        period: '/once',
        subtitle: 'Lifetime access — one payment',
        pricingNote: 'founding price — locked for life',
        features: const [
          'Unlimited applications',
          'All Pro features forever',
          'Early access to new features',
          'Founding member badge',
          'Direct feedback channel',
        ],
        ctaLabel: 'Become a founder',
        ctaRoute: '/role-selection',
        isHighlighted: false,
        accentColor: HireIQTheme.primaryNavy,
      ),
    ];

    return isMobile
        ? Column(
            children: cards
                .map((c) => Padding(
                    padding: const EdgeInsets.only(bottom: 20), child: c))
                .toList(),
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cards
                .map((c) => Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: c)))
                .toList(),
          );
  }
}

// ── Employer pricing ───────────────────────────────────────────────────────

class _EmployerPricing extends StatelessWidget {
  const _EmployerPricing({required this.isMobile});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _PricingCard(
        name: 'Starter',
        price: 'R799',
        period: '/month',
        subtitle: 'Launch your first hire',
        pricingNote: 'standard R1,299 at Milestone 1',
        features: const [
          'Up to 3 active job posts',
          'MatchIQ candidate scoring',
          'Basic analytics dashboard',
          'Email support',
        ],
        ctaLabel: 'Start hiring',
        ctaRoute: '/role-selection',
        isHighlighted: false,
        accentColor: HireIQTheme.primaryNavy,
      ),
      _PricingCard(
        name: 'Growth',
        price: 'R3,999',
        period: '/month',
        subtitle: 'Scale your hiring team',
        pricingNote: 'founding price — locked for life',
        features: const [
          'Up to 10 active job posts',
          'SignalIQ market intelligence',
          'WildcardIQ unbiased scoring',
          'ShieldIQ fraud protection',
          'Advanced analytics',
          'Priority support',
        ],
        ctaLabel: 'Start growing',
        ctaRoute: '/role-selection',
        isHighlighted: true,
        highlightLabel: 'Most popular',
        accentColor: HireIQTheme.primaryTeal,
      ),
      _PricingCard(
        name: 'Enterprise',
        price: 'Contact us',
        period: '',
        subtitle: 'For large hiring teams',
        features: const [
          'Unlimited job posts',
          'Full AI engine suite',
          'Dedicated account manager',
          'Custom integrations (ATS/HRIS)',
          'SLA guarantee',
          'White-label options',
        ],
        ctaLabel: 'Contact us',
        ctaRoute: '/contact',
        isHighlighted: false,
        accentColor: HireIQTheme.primaryNavy,
      ),
    ];

    return isMobile
        ? Column(
            children: cards
                .map((c) => Padding(
                    padding: const EdgeInsets.only(bottom: 20), child: c))
                .toList(),
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cards
                .map((c) => Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: c)))
                .toList(),
          );
  }
}

// ── Recruiter pricing ──────────────────────────────────────────────────────

class _RecruiterPricing extends StatelessWidget {
  const _RecruiterPricing({required this.isMobile});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _PricingCard(
        name: 'Solo',
        price: 'R999',
        period: '/month',
        subtitle: 'Individual recruiter',
        pricingNote: 'standard R1,999 at Milestone 1',
        features: const [
          'Full brief builder',
          'CV vault (unlimited candidates)',
          'Placement tracker',
          'SignalIQ salary benchmarks',
          'Keep 80% of placement fee',
        ],
        ctaLabel: 'Start recruiting',
        ctaRoute: '/role-selection',
        isHighlighted: false,
        accentColor: HireIQTheme.recruiterAccent,
      ),
      _PricingCard(
        name: 'Agency',
        price: 'R7,999',
        period: '/month',
        subtitle: 'Multi-seat agency desk',
        pricingNote: 'founding price — locked for life',
        highlightLabel: 'Agency plan',
        features: const [
          'Everything in Solo',
          'Up to 10 recruiter seats',
          'Team performance dashboard',
          'Client management portal',
          'Priority candidate matching',
          'Dedicated account manager',
        ],
        ctaLabel: 'Grow your agency',
        ctaRoute: '/role-selection',
        isHighlighted: true,
        accentColor: HireIQTheme.recruiterAccent,
      ),
    ];

    return isMobile
        ? Column(
            children: cards
                .map((c) => Padding(
                    padding: const EdgeInsets.only(bottom: 20), child: c))
                .toList(),
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: cards
                .map((c) => Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: c)))
                .toList(),
          );
  }
}

// ── Shared pricing card ────────────────────────────────────────────────────

class _PricingCard extends StatelessWidget {
  const _PricingCard({
    required this.name,
    required this.price,
    required this.period,
    required this.subtitle,
    required this.features,
    required this.ctaLabel,
    required this.ctaRoute,
    required this.isHighlighted,
    required this.accentColor,
    this.pricingNote,
    this.highlightLabel,
  });

  final String name;
  final String price;
  final String period;
  final String subtitle;
  final String? pricingNote;
  final List<String> features;
  final String ctaLabel;
  final String ctaRoute;
  final bool isHighlighted;
  final String? highlightLabel;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color:
            isHighlighted ? HireIQTheme.primaryNavy : HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
          color:
              isHighlighted ? HireIQTheme.primaryNavy : HireIQTheme.borderLight,
          width: isHighlighted ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy
                .withValues(alpha: isHighlighted ? 0.12 : 0.04),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Highlight badge
          if (highlightLabel != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
              ),
              child: Text(
                highlightLabel!,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Plan name
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
              fontSize: 13,
              color: isHighlighted
                  ? Colors.white.withValues(alpha: 0.65)
                  : HireIQTheme.textMuted,
            ),
          ),
          const SizedBox(height: 20),

          // Price
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: GoogleFonts.inter(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: isHighlighted ? Colors.white : HireIQTheme.primaryNavy,
                  letterSpacing: -1,
                ),
              ),
              if (period.isNotEmpty) ...[
                const SizedBox(width: 2),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    period,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isHighlighted
                          ? Colors.white.withValues(alpha: 0.65)
                          : HireIQTheme.textMuted,
                    ),
                  ),
                ),
              ],
            ],
          ),

          // Pricing note (milestone-based)
          if (pricingNote != null) ...[
            const SizedBox(height: 4),
            Text(
              pricingNote!,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: isHighlighted
                    ? Colors.white.withValues(alpha: 0.5)
                    : HireIQTheme.textMuted,
              ),
            ),
          ],

          const SizedBox(height: 24),
          Divider(
            color: isHighlighted
                ? Colors.white.withValues(alpha: 0.15)
                : HireIQTheme.borderLight,
            height: 1,
          ),
          const SizedBox(height: 20),

          // Features
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_rounded,
                    size: 16,
                    color:
                        isHighlighted ? HireIQTheme.primaryTeal : accentColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      f,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: isHighlighted
                            ? Colors.white.withValues(alpha: 0.85)
                            : HireIQTheme.primaryNavy,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // CTA
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.go(ctaRoute),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isHighlighted ? accentColor : HireIQTheme.primaryNavy,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                ),
              ),
              child: Text(
                ctaLabel,
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 8. Founder quote section
// ─────────────────────────────────────────────────────────────────────────────

class _FounderQuoteSection extends StatelessWidget {
  const _FounderQuoteSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 600;
      return Container(
        color: HireIQTheme.primaryNavy,
        padding:
            EdgeInsets.symmetric(horizontal: isMobile ? 24 : 48, vertical: 80),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              children: [
                // DH avatar — navy circle, white initials
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF243B5E),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: HireIQTheme.primaryTeal.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'DH',
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Quote mark
                Text(
                  '\u201C',
                  style: GoogleFonts.inter(
                    fontSize: 64,
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.4),
                    height: 0.6,
                  ),
                ),
                const SizedBox(height: 16),

                // Quote text
                Text(
                  'South Africa doesn\'t have a talent shortage. It has a matching problem. HireIQ exists to fix that — using AI that sees the full picture of who someone is, not just where they went to school.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 17 : 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 1.65,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 28),

                // Attribution
                Text(
                  'Dwayne Hartze',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: HireIQTheme.primaryTeal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Founder & CEO, HireIQ',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 9. CTA banner — teal background
// ─────────────────────────────────────────────────────────────────────────────

class _CtaBanner extends StatelessWidget {
  const _CtaBanner();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 600;
      return Container(
        width: double.infinity,
        color: HireIQTheme.primaryTeal,
        padding:
            EdgeInsets.symmetric(horizontal: isMobile ? 24 : 48, vertical: 72),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              children: [
                Text(
                  'Ready to hire smarter?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Join thousands of candidates and employers who have transformed their hiring with HireIQ.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.85),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 36),
                ElevatedButton(
                  onPressed: () => context.go('/role-selection'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: HireIQTheme.primaryTeal,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                    ),
                  ),
                  child: Text(
                    'Create your free account',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryTeal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 10. Footer — dark navy, 4 columns
// ─────────────────────────────────────────────────────────────────────────────

class _LandingFooter extends StatelessWidget {
  const _LandingFooter();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 600;
      return Container(
        color: const Color(0xFF0F1E33),
        padding:
            EdgeInsets.symmetric(horizontal: isMobile ? 24 : 64, vertical: 64),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column grid
                isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _FooterBrand(),
                          const SizedBox(height: 36),
                          _FooterCol(
                              heading: 'Platform', links: _kPlatformLinks),
                          const SizedBox(height: 28),
                          _FooterCol(heading: 'Company', links: _kCompanyLinks),
                          const SizedBox(height: 28),
                          _FooterCol(heading: 'Legal', links: _kLegalLinks),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 3, child: _FooterBrand()),
                          const SizedBox(width: 48),
                          Expanded(
                              flex: 2,
                              child: _FooterCol(
                                  heading: 'Platform', links: _kPlatformLinks)),
                          const SizedBox(width: 32),
                          Expanded(
                              flex: 2,
                              child: _FooterCol(
                                  heading: 'Company', links: _kCompanyLinks)),
                          const SizedBox(width: 32),
                          Expanded(
                              flex: 2,
                              child: _FooterCol(
                                  heading: 'Legal', links: _kLegalLinks)),
                        ],
                      ),

                const SizedBox(height: 48),
                Container(
                    height: 1, color: Colors.white.withValues(alpha: 0.08)),
                const SizedBox(height: 24),

                // Bottom bar
                isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _footerCopy(),
                          const SizedBox(height: 8),
                          _footerTagline(),
                        ],
                      )
                    : Row(
                        children: [
                          _footerCopy(),
                          const Spacer(),
                          _footerTagline(),
                        ],
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _footerCopy() {
    // Correction 4: © 2026 HireIQ Technologies (Pty) Ltd
    return Text(
      '© 2026 HireIQ Technologies (Pty) Ltd · All rights reserved',
      style: GoogleFonts.inter(
        fontSize: 12,
        color: Colors.white.withValues(alpha: 0.35),
      ),
    );
  }

  Widget _footerTagline() {
    return Text(
      'Trust and matching infrastructure for work.',
      style: GoogleFonts.inter(
        fontSize: 12,
        color: Colors.white.withValues(alpha: 0.35),
      ),
    );
  }
}

class _FooterBrand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'Hire',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
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
        const SizedBox(height: 12),
        Text(
          'Intelligence that finds\ntalent others miss.',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.5),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),
        // Social / contact row
        Row(
          children: [
            _SocialBtn(icon: Icons.language, tooltip: 'Website'),
            const SizedBox(width: 8),
            _SocialBtn(icon: Icons.alternate_email, tooltip: 'Email'),
            const SizedBox(width: 8),
            _SocialBtn(icon: Icons.work_outline, tooltip: 'LinkedIn'),
          ],
        ),
      ],
    );
  }
}

class _SocialBtn extends StatelessWidget {
  const _SocialBtn({required this.icon, required this.tooltip});
  final IconData icon;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child:
            Icon(icon, size: 16, color: Colors.white.withValues(alpha: 0.55)),
      ),
    );
  }
}

class _FooterCol extends StatelessWidget {
  const _FooterCol({required this.heading, required this.links});
  final String heading;
  final List<(String, String)> links;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white.withValues(alpha: 0.45),
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 14),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () => context.go(link.$2),
              child: Text(
                link.$1,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.65),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

const _kPlatformLinks = <(String, String)>[
  ('Find Jobs', '/role-selection'),
  ('Hire Talent', '/role-selection'),
  ('For Recruiters', '/role-selection'),
  ('Gig Marketplace', '/role-selection'),
  ('Pricing', '/pricing'),
];

const _kCompanyLinks = <(String, String)>[
  ('About HireIQ', '/about'),
  ('Blog', '/blog'),
  ('Careers', '/careers'),
  ('Contact us', '/contact'),
  ('System status', '/status'),
];

const _kLegalLinks = <(String, String)>[
  ('Privacy Policy', '/privacy'),
  ('Terms of Service', '/terms'),
  ('POPIA Compliance', '/privacy'),
  ('Cookie Policy', '/privacy'),
];
