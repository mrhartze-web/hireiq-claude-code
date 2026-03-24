import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/web_layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _HeroSection(),
          _MissionSection(),
          _ValuesSection(),
          _StatsBar(),
          _FounderSection(),
          _CtaSection(),
        ],
      ),
    );
  }
}

// ── Hero ──────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.primaryNavy,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 100),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            children: [
              Text(
                'We built HireIQ because\nwe lived the problem.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 44,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.15,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: 56,
                height: 4,
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryTeal,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Mission ───────────────────────────────────────────────────────────────────

class _MissionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.surfaceWhite,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            children: [
              Text(
                'Our Mission',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.primaryTeal,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'South Africa has a 32% unemployment rate. Its recruitment industry is expensive, slow, and built on guesswork. We built HireIQ to fix that — with AI that actually works, verification that employers trust, and pricing that does not exclude the people who need it most.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  color: HireIQTheme.textSecondary,
                  height: 1.75,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Values ────────────────────────────────────────────────────────────────────

class _ValuesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const values = [
      (
        icon: Icons.verified_user_outlined,
        title: 'Verified Truth',
        body:
            'Every candidate on HireIQ is who they say they are. PassportIQ integrates with the Department of Home Affairs so employers never waste time on misrepresented profiles.',
      ),
      (
        icon: Icons.auto_awesome_outlined,
        title: 'Intelligent Matching',
        body:
            'MatchIQ scores candidate-job fit across 80+ data points. Not keywords. Not guesswork. Real compatibility.',
      ),
      (
        icon: Icons.trending_up_outlined,
        title: 'Accessible Growth',
        body:
            'UpliftIQ and our accreditation partnerships mean a candidate who cannot afford a R2,500 certification gets it for R149. The credential belongs to them forever.',
      ),
    ];

    return Container(
      color: HireIQTheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
      child: Column(
        children: [
          Text(
            'What We Stand For',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.primaryTeal,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Three principles that guide every decision.',
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: HireIQTheme.primaryNavy,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(builder: (context, constraints) {
            final isWide = constraints.maxWidth > 800;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: values
                    .map((v) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: _ValueCard(
                                icon: v.icon,
                                title: v.title,
                                body: v.body),
                          ),
                        ))
                    .toList(),
              );
            }
            return Column(
              children: values
                  .map((v) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: _ValueCard(
                            icon: v.icon, title: v.title, body: v.body),
                      ))
                  .toList(),
            );
          }),
        ],
      ),
    );
  }
}

class _ValueCard extends StatelessWidget {
  const _ValueCard(
      {required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
            ),
            child: Icon(icon, color: HireIQTheme.primaryTeal, size: 26),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.primaryNavy,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: HireIQTheme.textSecondary,
              height: 1.75,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stats bar ─────────────────────────────────────────────────────────────────

class _StatsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const stats = [
      ('7', 'AI Engines'),
      ('All', 'Industries'),
      ('3', 'User Types'),
      ('1', 'Mission — Reduce Unemployment'),
    ];

    return Container(
      color: HireIQTheme.primaryNavy,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 48),
      child: LayoutBuilder(builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        if (isWide) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: stats
                .map((s) => Expanded(child: _StatItem(number: s.$1, label: s.$2)))
                .toList(),
          );
        }
        return Column(
          children: stats
              .map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _StatItem(number: s.$1, label: s.$2),
                  ))
              .toList(),
        );
      }),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.number, required this.label});

  final String number;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.inter(
            fontSize: 40,
            fontWeight: FontWeight.w800,
            color: HireIQTheme.primaryTeal,
            letterSpacing: -1.0,
            height: 1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.65),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ── Founder ───────────────────────────────────────────────────────────────────

class _FounderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.surfaceWhite,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 880),
          child: LayoutBuilder(builder: (context, constraints) {
            final isWide = constraints.maxWidth > 640;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FounderAvatar(),
                  const SizedBox(width: 56),
                  Expanded(child: _FounderText()),
                ],
              );
            }
            return Column(
              children: [
                _FounderAvatar(),
                const SizedBox(height: 32),
                _FounderText(),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _FounderAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: HireIQTheme.primaryNavy,
            border: Border.all(color: HireIQTheme.primaryTeal, width: 3),
          ),
          child: Center(
            child: Text(
              'DH',
              style: GoogleFonts.inter(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Dwayne Hartze',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: HireIQTheme.primaryNavy,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Founder and CEO',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: HireIQTheme.textMuted,
          ),
        ),
      ],
    );
  }
}

class _FounderText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(Icons.format_quote_rounded,
              color: HireIQTheme.primaryTeal, size: 20),
        ),
        const SizedBox(height: 16),
        Text(
          '"The foundation is built. The numbers make sense. The timing is right."',
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: HireIQTheme.primaryNavy,
            height: 1.4,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'HireIQ was built by a single founder who believed that South Africa\'s talent deserved better than keyword filtering and overpriced agencies. Every feature, every AI engine, and every pricing decision was made with one question in mind — does this genuinely help the person using it?',
          style: GoogleFonts.inter(
            fontSize: 15,
            color: HireIQTheme.textSecondary,
            height: 1.75,
          ),
        ),
      ],
    );
  }
}

// ── CTA ───────────────────────────────────────────────────────────────────────

class _CtaSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HireIQTheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
      child: Center(
        child: Column(
          children: [
            Text(
              'Ready to experience smarter hiring?',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: HireIQTheme.primaryNavy,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 36),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => context.go('/signup'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HireIQTheme.primaryTeal,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusFull)),
                  ),
                  child: Text('Get Started Free',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700, fontSize: 15)),
                ),
                OutlinedButton(
                  onPressed: () => context.go('/contact'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: HireIQTheme.primaryNavy,
                    side: const BorderSide(
                        color: HireIQTheme.primaryNavy, width: 1.5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusFull)),
                  ),
                  child: Text('Contact Us',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700, fontSize: 15)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
