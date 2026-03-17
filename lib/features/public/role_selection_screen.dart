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
  });

  final String key;
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
}

const _roles = <_Role>[
  _Role(
    key: 'candidate',
    icon: Icons.person_outline_rounded,
    title: 'I am looking for work',
    subtitle:
        'Find jobs matched to your skills with AI-powered scoring.',
    accent: HireIQTheme.primaryTeal,
  ),
  _Role(
    key: 'employer',
    icon: Icons.business_outlined,
    title: 'I am hiring talent',
    subtitle:
        'Post jobs and find the best candidates with MatchIQ and WildcardIQ.',
    accent: HireIQTheme.primaryNavy,
  ),
  _Role(
    key: 'recruiter',
    icon: Icons.handshake_outlined,
    title: 'I place candidates',
    subtitle:
        'Build briefs, manage pipelines, and earn with SignalIQ intelligence.',
    accent: HireIQTheme.recruiterAccent,
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
  String? _selectedKey;

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
      statusBarIconBrightness: Brightness.dark,
    ));

    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _headerFade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _cardsFade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    );
    _cardsSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    ));

    _entranceCtrl.forward();
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    super.dispose();
  }

  void _select(String key) {
    if (_selectedKey == key) return;
    HapticFeedback.selectionClick();
    setState(() => _selectedKey = key);
  }

  void _continue() {
    if (_selectedKey == null) return;
    context.go(
      MobileRoutes.signup,
      extra: {'role': _selectedKey},
    );
  }

  Color get _buttonColor {
    if (_selectedKey == null) return HireIQTheme.borderMedium;
    return _roles.firstWhere((r) => r.key == _selectedKey).accent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: Stack(
        children: [
          // Subtle top wash
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 220,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    HireIQTheme.primaryNavy.withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Wordmark ───────────────────────────────────
                        SlideTransition(
                          position: _headerSlide,
                          child: FadeTransition(
                            opacity: _headerFade,
                            child: Center(
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
                          ),
                        ),

                        const SizedBox(height: 36),

                        // ── Heading ────────────────────────────────────
                        SlideTransition(
                          position: _headerSlide,
                          child: FadeTransition(
                            opacity: _headerFade,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'I am joining as',
                                  style: GoogleFonts.inter(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w800,
                                    color: HireIQTheme.textPrimary,
                                    letterSpacing: -0.8,
                                    height: 1.15,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Choose your role to get a tailored experience.',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: HireIQTheme.textMuted,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // ── Role cards ─────────────────────────────────
                        SlideTransition(
                          position: _cardsSlide,
                          child: FadeTransition(
                            opacity: _cardsFade,
                            child: Column(
                              children: _roles.map((role) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 14),
                                  child: _RoleCard(
                                    role: role,
                                    isSelected: _selectedKey == role.key,
                                    onTap: () => _select(role.key),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),

                // ── Continue button ────────────────────────────────────
                FadeTransition(
                  opacity: _cardsFade,
                  child: _ContinueButton(
                    selectedKey: _selectedKey,
                    buttonColor: _buttonColor,
                    onTap: _continue,
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

// ── Role card ─────────────────────────────────────────────────────────────────

class _RoleCard extends StatefulWidget {
  const _RoleCard({
    required this.role,
    required this.isSelected,
    required this.onTap,
  });

  final _Role role;
  final bool isSelected;
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
    final selected = widget.isSelected;

    return GestureDetector(
      onTapDown: (_) => _pressCtrl.forward(),
      onTapUp: (_) {
        _pressCtrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _pressCtrl.reverse(),
      child: ScaleTransition(
        scale: _pressScale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: selected
                ? role.accent.withValues(alpha: 0.05)
                : HireIQTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border(
              left: BorderSide(
                color: selected ? role.accent : Colors.transparent,
                width: 4,
              ),
              top: BorderSide(
                color: selected
                    ? role.accent.withValues(alpha: 0.25)
                    : HireIQTheme.borderLight,
                width: 1,
              ),
              right: BorderSide(
                color: selected
                    ? role.accent.withValues(alpha: 0.25)
                    : HireIQTheme.borderLight,
                width: 1,
              ),
              bottom: BorderSide(
                color: selected
                    ? role.accent.withValues(alpha: 0.25)
                    : HireIQTheme.borderLight,
                width: 1,
              ),
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: role.accent.withValues(alpha: 0.12),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon bubble
              AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected
                      ? role.accent.withValues(alpha: 0.12)
                      : HireIQTheme.backgroundLight,
                ),
                child: Icon(
                  role.icon,
                  size: 26,
                  color: selected ? role.accent : HireIQTheme.textMuted,
                ),
              ),

              const SizedBox(width: 16),

              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role.title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: selected
                            ? role.accent
                            : HireIQTheme.textPrimary,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      role.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: HireIQTheme.textMuted,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Check / chevron
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                transitionBuilder: (child, anim) => ScaleTransition(
                  scale: anim,
                  child: FadeTransition(opacity: anim, child: child),
                ),
                child: selected
                    ? Container(
                        key: const ValueKey('check'),
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: role.accent,
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      )
                    : const Icon(
                        key: ValueKey('chevron'),
                        Icons.chevron_right_rounded,
                        color: HireIQTheme.textLight,
                        size: 22,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Continue button ───────────────────────────────────────────────────────────

class _ContinueButton extends StatefulWidget {
  const _ContinueButton({
    required this.selectedKey,
    required this.buttonColor,
    required this.onTap,
  });

  final String? selectedKey;
  final Color buttonColor;
  final VoidCallback onTap;

  @override
  State<_ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<_ContinueButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressCtrl;
  late final Animation<double> _pressScale;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 220),
    );
    _pressScale = Tween<double>(begin: 1.0, end: 0.97).animate(
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
    final enabled = widget.selectedKey != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
      child: GestureDetector(
        onTapDown: enabled ? (_) => _pressCtrl.forward() : null,
        onTapUp: enabled
            ? (_) {
                _pressCtrl.reverse();
                widget.onTap();
              }
            : null,
        onTapCancel: enabled ? () => _pressCtrl.reverse() : null,
        child: ScaleTransition(
          scale: _pressScale,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: enabled ? null : HireIQTheme.backgroundLight,
              gradient: enabled
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.buttonColor,
                        widget.buttonColor.withValues(alpha: 0.8),
                      ],
                    )
                  : null,
              boxShadow: enabled
                  ? [
                      BoxShadow(
                        color: widget.buttonColor.withValues(alpha: 0.38),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: enabled ? Colors.white : HireIQTheme.textLight,
                  ),
                  child: const Text('Continue'),
                ),
                AnimatedOpacity(
                  opacity: enabled ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 18,
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
