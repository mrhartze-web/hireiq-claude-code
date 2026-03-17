import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/components/web_layout.dart';
import '../../shared/theme.dart';

// ── Page ──────────────────────────────────────────────────────────────────────

class Error404Page extends StatefulWidget {
  const Error404Page({super.key});

  @override
  State<Error404Page> createState() => _Error404PageState();
}

class _Error404PageState extends State<Error404Page>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceCtrl;
  late final Animation<double> _numberFade;
  late final Animation<Offset> _numberSlide;
  late final Animation<double> _contentFade;
  late final Animation<Offset> _contentSlide;

  @override
  void initState() {
    super.initState();

    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _numberFade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
    );
    _numberSlide = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
    ));

    _contentFade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    );
    _contentSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));

    _entranceCtrl.forward();
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── 404 number ────────────────────────────────────────────
                SlideTransition(
                  position: _numberSlide,
                  child: FadeTransition(
                    opacity: _numberFade,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Background glow
                        Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
                          ),
                        ),
                        // 404 text
                        Text(
                          '404',
                          style: GoogleFonts.inter(
                            fontSize: 120,
                            fontWeight: FontWeight.w900,
                            color: HireIQTheme.primaryNavy,
                            letterSpacing: -6,
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // ── Heading + subtitle + button ───────────────────────────
                SlideTransition(
                  position: _contentSlide,
                  child: FadeTransition(
                    opacity: _contentFade,
                    child: Column(
                      children: [
                        Text(
                          'Page not found',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: HireIQTheme.textPrimary,
                            letterSpacing: -0.8,
                            height: 1.15,
                          ),
                        ),

                        const SizedBox(height: 14),

                        Text(
                          'The page you are looking for does not exist\nor has been moved.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: HireIQTheme.textMuted,
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 40),

                        // ── Back to Home button ───────────────────────────
                        _BackToHomeButton(onTap: () => context.go('/landing')),

                        const SizedBox(height: 24),

                        // ── Help link ─────────────────────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Need help? ',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: HireIQTheme.textMuted,
                              ),
                            ),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () => context.go('/contact'),
                                child: Text(
                                  'Contact support',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: HireIQTheme.primaryTeal,
                                  ),
                                ),
                              ),
                            ),
                          ],
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

// ── Back to Home button ───────────────────────────────────────────────────────

class _BackToHomeButton extends StatefulWidget {
  const _BackToHomeButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_BackToHomeButton> createState() => _BackToHomeButtonState();
}

class _BackToHomeButtonState extends State<_BackToHomeButton>
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => _pressCtrl.forward(),
        onTapUp: (_) {
          _pressCtrl.reverse();
          widget.onTap();
        },
        onTapCancel: () => _pressCtrl.reverse(),
        child: ScaleTransition(
          scale: _pressScale,
          child: Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  HireIQTheme.primaryTeal,
                  Color(0xFF0F766E),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 10),
                Text(
                  'Back to Home',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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
