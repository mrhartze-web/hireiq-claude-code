import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';
import '../mobile_screens.dart';

// ── Role data ─────────────────────────────────────────────────────────────────

class _Role {
  const _Role({
    required this.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.iconBg,
    required this.chips,
  });

  final String key;
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final Color iconBg;  // circle background and chip background
  final List<String> chips;
}

const _roles = <_Role>[
  _Role(
    key: 'candidate',
    icon: Icons.person_outline_rounded,
    title: "I'm looking for work",
    subtitle: 'AI-matched jobs with smart scoring and verified credentials.',
    accent: HireIQTheme.primaryTeal,
    iconBg: Color(0xFFE6F7F5),
    chips: ['MatchIQ', 'PassportIQ'],
  ),
  _Role(
    key: 'employer',
    icon: Icons.business_outlined,
    title: "I'm hiring",
    subtitle: 'Post jobs, screen candidates, and hire smarter with AI.',
    accent: Color(0xFF7C3AED),
    iconBg: Color(0xFFF0EDFF),
    chips: ['SignalIQ', 'ShieldIQ'],
  ),
  _Role(
    key: 'recruiter',
    icon: Icons.work_outline_rounded,
    title: "I'm a recruiter",
    subtitle: 'Manage briefs, build your CV vault, and earn on placements.',
    accent: Color(0xFF2563EB),
    iconBg: Color(0xFFE8F4FF),
    chips: ['CRM Pipeline', 'CV Vault'],
  ),
  _Role(
    key: 'gig',
    icon: Icons.bolt_rounded,
    title: 'I want gig work',
    subtitle: 'Browse short-term contracts with secure escrow payments.',
    accent: Color(0xFF059669),
    iconBg: Color(0xFFE8FFF3),
    chips: ['Gig Marketplace', 'Escrow Payments'],
  ),
];

// ── Screen ────────────────────────────────────────────────────────────────────

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceCtrl;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _cardsFade;
  late final Animation<Offset> _cardsSlide;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 780),
    );

    _headerFade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
    ));

    _cardsFade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.25, 1.0, curve: Curves.easeOut),
    );
    _cardsSlide = Tween<Offset>(
      begin: const Offset(0, 0.07),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.25, 1.0, curve: Curves.easeOut),
    ));

    _entranceCtrl.forward();
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    super.dispose();
  }

  void _selectRole(_Role role) {
    HapticFeedback.selectionClick();
    context.go(MobileRoutes.signup, extra: {'role': role.key});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.primaryNavy,
      body: Stack(
        children: [
          // Background radial glow
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
              ),
            ),
          ),

          Column(
            children: [
              // ── Navy header ───────────────────────────────────────────────
              SafeArea(
                bottom: false,
                child: SlideTransition(
                  position: _headerSlide,
                  child: FadeTransition(
                    opacity: _headerFade,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: RichText(
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
                          ),

                          const SizedBox(height: 32),

                          Text(
                            'How will you use\nHireIQ?',
                            style: GoogleFonts.inter(
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.9,
                              height: 1.15,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            'Choose your role to get a tailored experience.',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Colors.white.withValues(alpha: 0.6),
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 28),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // ── White card sheet ──────────────────────────────────────────
              Expanded(
                child: SlideTransition(
                  position: _cardsSlide,
                  child: FadeTransition(
                    opacity: _cardsFade,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: HireIQTheme.background,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                        child: Column(
                          children: [
                            ..._roles.map(
                              (role) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _RoleCard(
                                  role: role,
                                  onTap: () => _selectRole(role),
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),

                            SafeArea(
                              top: false,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account? ',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: HireIQTheme.textMuted,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          context.go(MobileRoutes.login),
                                      child: Text(
                                        'Sign in',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: HireIQTheme.primaryTeal,
                                        ),
                                      ),
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Role card ─────────────────────────────────────────────────────────────────

class _RoleCard extends StatefulWidget {
  const _RoleCard({required this.role, required this.onTap});

  final _Role role;
  final VoidCallback onTap;

  @override
  State<_RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<_RoleCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressCtrl;
  late final Animation<double> _pressScale;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _pressScale = Tween<double>(begin: 1.0, end: 0.975).animate(
      CurvedAnimation(parent: _pressCtrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _pressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final role = widget.role;

    return GestureDetector(
      onTapDown: (_) => _pressCtrl.forward(),
      onTapUp: (_) {
        _pressCtrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _pressCtrl.reverse(),
      child: ScaleTransition(
        scale: _pressScale,
        child: Container(
          decoration: BoxDecoration(
            color: HireIQTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: HireIQTheme.borderLight),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon bubble — exact background color per spec
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: role.iconBg,
                ),
                child: Icon(role.icon, size: 24, color: role.accent),
              ),

              const SizedBox(width: 14),

              // Text + chips
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role.title,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.textPrimary,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      role.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: HireIQTheme.textMuted,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: role.chips
                          .map((chip) => _FeatureChip(
                                label: chip,
                                accent: role.accent,
                                chipBg: role.iconBg,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Chevron
              const Icon(
                Icons.chevron_right_rounded,
                color: HireIQTheme.textLight,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Feature chip ──────────────────────────────────────────────────────────────

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({
    required this.label,
    required this.accent,
    required this.chipBg,
  });

  final String label;
  final Color accent;
  final Color chipBg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: chipBg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: accent,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}
