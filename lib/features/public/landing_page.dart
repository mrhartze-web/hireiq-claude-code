import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';
import '../../shared/components/web_layout.dart';
import '../../shared/footer/web_footer.dart';

// ── Web Landing Page ───────────────────────────────────────────────────────────

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return const WebLayout(
      showNavBar: false,
      showFooter: false,
      child: Column(
        children: [
          _WhiteNavBar(),
          _HeroSection(),
          _StatsBar(),
          _EcosystemSection(),
          _RecruiterSection(),
          _HowItWorksSection(),
          _CtaBanner(),
          WebFooter(),
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
                _NavLink(label: 'Pricing', route: '/pricing'),
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

// ── Hero section ───────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            HireIQTheme.primaryNavy,
            Color(0xFF0F3460),
            Color(0xFF1A4A6B),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 96),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.15),
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                  border: Border.all(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.3),
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
                  fontSize: 60,
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
                  fontSize: 18,
                  color: Colors.white.withValues(alpha: 0.75),
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 40),

              // CTA buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => context.go('/role-selection'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HireIQTheme.primaryTeal,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd),
                      ),
                    ),
                    child: Text(
                      'Get started free',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () => context.go('/pricing'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.3)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd),
                      ),
                    ),
                    child: Text(
                      'View pricing',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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

// ── Stats bar ──────────────────────────────────────────────────────────────────

const _stats = <(String, String)>[
  ('50,000+', 'Active candidates'),
  ('2,500+', 'Verified employers'),
  ('12,000+', 'Successful placements'),
  ('94%', 'Match satisfaction rate'),
];

class _StatsBar extends StatelessWidget {
  const _StatsBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.primaryTeal,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _stats.map((s) {
              return Column(
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
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ── Ecosystem section ──────────────────────────────────────────────────────────

const _iqCards = <(IconData, String, String, String, Color)>[
  (
    Icons.psychology_outlined,
    'MatchIQ',
    'AI-powered job matching that scores candidates on skills, experience, and culture fit.',
    'Candidates & Employers',
    Color(0xFF0D9488),
  ),
  (
    Icons.verified_outlined,
    'PassportIQ',
    'Secure identity and qualification verification using blockchain-backed credentials.',
    'Candidates',
    Color(0xFF7C3AED),
  ),
  (
    Icons.trending_up_outlined,
    'SignalIQ',
    'Real-time salary benchmarks and market intelligence to inform hiring decisions.',
    'Employers',
    Color(0xFF2563EB),
  ),
  (
    Icons.construction_outlined,
    'ForgeIQ',
    'AI CV builder that transforms your work history into a compelling, ATS-ready profile.',
    'Candidates',
    Color(0xFF059669),
  ),
  (
    Icons.casino_outlined,
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
];

class _EcosystemSection extends StatelessWidget {
  const _EcosystemSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              Text(
                'The HireIQ Ecosystem',
                style: GoogleFonts.inter(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: HireIQTheme.primaryNavy,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Six AI-powered tools working together to transform every step of the hiring journey.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: HireIQTheme.textMuted,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 48),

              LayoutBuilder(builder: (ctx, constraints) {
                final cardWidth = (constraints.maxWidth - 32) / 3;
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: _iqCards.map((card) {
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
      padding: const EdgeInsets.all(24),
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
          const SizedBox(height: 16),
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: HireIQTheme.textMuted,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
            ),
            child: Text(
              target,
              style: GoogleFonts.inter(
                fontSize: 11,
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

// ── Recruiter section ──────────────────────────────────────────────────────────

class _RecruiterSection extends StatelessWidget {
  const _RecruiterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F3FF),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading with purple accent bar
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 40,
                    decoration: BoxDecoration(
                      color: HireIQTheme.recruiterAccent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'For Recruiters',
                    style: GoogleFonts.inter(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: HireIQTheme.primaryNavy,
                      letterSpacing: -0.8,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Text(
                  'Keep 80% of every placement fee. HireIQ charges no monthly fees — you only pay when you place. SignalIQ tells you exactly what the market is paying before you pitch.',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: HireIQTheme.textMuted,
                    height: 1.6,
                  ),
                ),
              ),

              const SizedBox(height: 48),

              const Row(
                children: [
                  Expanded(
                    child: _RecruiterStatCard(
                      value: '80% of fees',
                      label: 'yours to keep',
                    ),
                  ),
                  SizedBox(width: 24),
                  Expanded(
                    child: _RecruiterStatCard(
                      value: '12% average',
                      label: 'mid-level placement fee',
                    ),
                  ),
                  SizedBox(width: 24),
                  Expanded(
                    child: _RecruiterStatCard(
                      value: 'R28,800',
                      label: 'average recruiter earn per placement',
                    ),
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

class _RecruiterStatCard extends StatelessWidget {
  const _RecruiterStatCard({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

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
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: HireIQTheme.recruiterAccent,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: HireIQTheme.textMuted,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ── How it works section ───────────────────────────────────────────────────────

const _steps = <(String, String, String)>[
  (
    '1',
    'Create your profile',
    "Sign up in minutes and complete your profile with skills, experience, and what you're looking for."
  ),
  (
    '2',
    'Get AI-matched',
    'MatchIQ analyses thousands of opportunities and ranks the best matches for you in real time.'
  ),
  (
    '3',
    'Apply with confidence',
    "See your match score before you apply. Know why you're a fit before you hit send."
  ),
  (
    '4',
    'Get hired faster',
    'Verified profiles and AI scoring means employers trust HireIQ candidates — and respond faster.'
  ),
];

class _HowItWorksSection extends StatelessWidget {
  const _HowItWorksSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.surfaceWhite,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: Column(
            children: [
              Text(
                'How it works',
                style: GoogleFonts.inter(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: HireIQTheme.primaryNavy,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'From sign-up to hired in four steps.',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: HireIQTheme.textMuted,
                ),
              ),
              const SizedBox(height: 56),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _steps.map((step) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              color: HireIQTheme.primaryNavy,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                step.$1,
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            step.$2,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: HireIQTheme.primaryNavy,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            step.$3,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: HireIQTheme.textMuted,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── CTA banner ─────────────────────────────────────────────────────────────────

class _CtaBanner extends StatelessWidget {
  const _CtaBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [HireIQTheme.primaryNavy, Color(0xFF0F3460)],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 72),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            children: [
              Text(
                'Ready to hire smarter?',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 36,
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
                  color: Colors.white.withValues(alpha: 0.75),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 36),
              ElevatedButton(
                onPressed: () => context.go('/role-selection'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.primaryTeal,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                ),
                child: Text(
                  'Create your free account',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
