import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';
import '../mobile_screens.dart';

// ── Slide data ────────────────────────────────────────────────────────────────

class _Slide {
  const _Slide({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.iconPainter,
  });

  final String title;
  final String subtitle;
  final Color accent;
  final CustomPainter iconPainter;
}

const _slides = <_Slide>[
  _Slide(
    title: 'Find Your\nPerfect Match',
    subtitle:
        'AI-powered job matching that understands your skills, experience, and ambitions.',
    accent: HireIQTheme.primaryTeal,
    iconPainter: _PersonStarPainter(color: HireIQTheme.primaryTeal),
  ),
  _Slide(
    title: 'Hire With\nIntelligence',
    subtitle:
        'MatchIQ and WildcardIQ find candidates others miss. Reduce bias, improve retention.',
    accent: HireIQTheme.primaryNavy,
    iconPainter: _BriefcaseLightningPainter(color: HireIQTheme.primaryNavy),
  ),
  _Slide(
    title: 'Place With\nConfidence',
    subtitle:
        'SignalIQ gives recruiters real market intelligence. Know salary benchmarks before you pitch.',
    accent: HireIQTheme.recruiterAccent,
    iconPainter: _HandshakePainter(color: HireIQTheme.recruiterAccent),
  ),
];

// ── Screen ────────────────────────────────────────────────────────────────────

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final _pageController = PageController();
  int _page = 0;

  // Per-page content entrance
  late AnimationController _enterCtrl;
  late Animation<double> _enterFade;
  late Animation<Offset> _enterSlide;
  late Animation<double> _iconEnter;

  // Accent cross-fade between pages
  late AnimationController _accentCtrl;
  late Animation<double> _accentT;
  Color _fromAccent = _slides[0].accent;
  Color _toAccent = _slides[0].accent;

  // Button press scale
  late AnimationController _btnCtrl;
  late Animation<double> _btnScale;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    _enterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    _enterFade = CurvedAnimation(
      parent: _enterCtrl,
      curve: const Interval(0.1, 1.0, curve: Curves.easeOut),
    );
    _enterSlide = Tween<Offset>(
      begin: const Offset(0.0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _enterCtrl,
      curve: const Interval(0.0, 0.85, curve: Curves.easeOutCubic),
    ));
    _iconEnter = Tween<double>(begin: 0.55, end: 1.0).animate(
      CurvedAnimation(
        parent: _enterCtrl,
        curve: const Interval(0.0, 0.75, curve: Curves.easeOutBack),
      ),
    );

    _accentCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _accentT = CurvedAnimation(parent: _accentCtrl, curve: Curves.easeInOut);

    _btnCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 90),
      reverseDuration: const Duration(milliseconds: 220),
    );
    _btnScale = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _btnCtrl, curve: Curves.easeOut),
    );

    _enterCtrl.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _enterCtrl.dispose();
    _accentCtrl.dispose();
    _btnCtrl.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    if (index < 0 || index >= _slides.length) return;
    _fromAccent = _slides[_page].accent;
    _toAccent = _slides[index].accent;
    _accentCtrl.forward(from: 0);
    _enterCtrl.forward(from: 0);
    setState(() => _page = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 480),
      curve: Curves.easeInOutCubic,
    );
  }

  void _next() {
    if (_page < _slides.length - 1) {
      _goTo(_page + 1);
    } else {
      context.go(MobileRoutes.roleSelection);
    }
  }

  void _skip() => context.go(MobileRoutes.login);

  Color get _currentAccent => Color.lerp(
        _fromAccent,
        _toAccent,
        _accentT.value,
      )!;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isLast = _page == _slides.length - 1;

    return AnimatedBuilder(
      animation: _accentT,
      builder: (context, _) {
        final accent = _currentAccent;
        return Scaffold(
          backgroundColor: const Color(0xFF0F1A2E),
          body: Stack(
            children: [
              // ── Ambient background ───────────────────────────────────
              Positioned.fill(
                child: CustomPaint(
                  painter: _BackgroundPainter(accent: accent),
                ),
              ),

              // ── Pages ────────────────────────────────────────────────
              PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _slides.length,
                itemBuilder: (_, i) => _SlidePage(
                  slide: _slides[i],
                  enterFade: _enterFade,
                  enterSlide: _enterSlide,
                  iconEnter: _iconEnter,
                  accent: accent,
                  screenSize: size,
                ),
              ),

              // ── Top bar ──────────────────────────────────────────────
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Wordmark
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Hire',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: 'IQ',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: accent,
                            ),
                          ),
                        ]),
                      ),

                      // Skip — hidden on last slide
                      AnimatedOpacity(
                        opacity: isLast ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 250),
                        child: TextButton(
                          onPressed: isLast ? null : _skip,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            foregroundColor:
                                Colors.white.withValues(alpha: 0.5),
                          ),
                          child: Text(
                            'Skip',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Bottom controls ──────────────────────────────────────
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(28, 0, 28, 28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Dot indicator
                        _DotIndicator(
                          count: _slides.length,
                          current: _page,
                          accent: accent,
                        ),

                        // Next / Get Started button
                        ScaleTransition(
                          scale: _btnScale,
                          child: GestureDetector(
                            onTapDown: (_) => _btnCtrl.forward(),
                            onTapUp: (_) {
                              _btnCtrl.reverse();
                              _next();
                            },
                            onTapCancel: () => _btnCtrl.reverse(),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              height: 52,
                              padding: EdgeInsets.symmetric(
                                horizontal: isLast ? 28 : 20,
                              ),
                              decoration: BoxDecoration(
                                color: accent,
                                borderRadius: BorderRadius.circular(26),
                                boxShadow: [
                                  BoxShadow(
                                    color: accent.withValues(alpha: 0.45),
                                    blurRadius: 20,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AnimatedSwitcher(
                                    duration:
                                        const Duration(milliseconds: 200),
                                    child: Text(
                                      isLast ? 'Get Started' : 'Next',
                                      key: ValueKey(isLast),
                                      style: GoogleFonts.inter(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
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
      },
    );
  }
}

// ── Slide page ─────────────────────────────────────────────────────────────────

class _SlidePage extends StatelessWidget {
  const _SlidePage({
    required this.slide,
    required this.enterFade,
    required this.enterSlide,
    required this.iconEnter,
    required this.accent,
    required this.screenSize,
  });

  final _Slide slide;
  final Animation<double> enterFade;
  final Animation<Offset> enterSlide;
  final Animation<double> iconEnter;
  final Color accent;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    final iconSize = (screenSize.width * 0.52).clamp(180.0, 260.0);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top-bar spacer (wordmark + skip sit above SafeArea)
            const SizedBox(height: 64),

            // Illustrated icon circle
            FadeTransition(
              opacity: enterFade,
              child: ScaleTransition(
                scale: iconEnter,
                child: Center(
                  child: _IconCircle(
                    size: iconSize,
                    accent: accent,
                    painter: slide.iconPainter,
                  ),
                ),
              ),
            ),

            SizedBox(height: screenSize.height * 0.055),

            // Title + subtitle
            SlideTransition(
              position: enterSlide,
              child: FadeTransition(
                opacity: enterFade,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      slide.title,
                      style: GoogleFonts.inter(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.15,
                        letterSpacing: -1.0,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      slide.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withValues(alpha: 0.6),
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Icon circle ───────────────────────────────────────────────────────────────

class _IconCircle extends StatelessWidget {
  const _IconCircle({
    required this.size,
    required this.accent,
    required this.painter,
  });

  final double size;
  final Color accent;
  final CustomPainter painter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer diffuse ring
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.withValues(alpha: 0.08),
            ),
          ),
          // Mid ring
          Container(
            width: size * 0.78,
            height: size * 0.78,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.withValues(alpha: 0.12),
              border: Border.all(
                color: accent.withValues(alpha: 0.2),
                width: 1.5,
              ),
            ),
          ),
          // Inner filled circle
          Container(
            width: size * 0.56,
            height: size * 0.56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  accent.withValues(alpha: 0.9),
                  accent.withValues(alpha: 0.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: 0.5),
                  blurRadius: 32,
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
          // Custom icon
          SizedBox(
            width: size * 0.38,
            height: size * 0.38,
            child: CustomPaint(painter: painter),
          ),
        ],
      ),
    );
  }
}

// ── Dot indicator ─────────────────────────────────────────────────────────────

class _DotIndicator extends StatelessWidget {
  const _DotIndicator({
    required this.count,
    required this.current,
    required this.accent,
  });

  final int count;
  final int current;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 24 : 7,
          height: 7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: active
                ? accent
                : Colors.white.withValues(alpha: 0.25),
          ),
        );
      }),
    );
  }
}

// ── Background painter ────────────────────────────────────────────────────────

class _BackgroundPainter extends CustomPainter {
  const _BackgroundPainter({required this.accent});
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    // Top-right glow
    canvas.drawCircle(
      Offset(size.width * 0.88, size.height * 0.12),
      size.width * 0.7,
      Paint()
        ..shader = RadialGradient(
          colors: [accent.withValues(alpha: 0.22), Colors.transparent],
        ).createShader(Rect.fromCircle(
          center: Offset(size.width * 0.88, size.height * 0.12),
          radius: size.width * 0.7,
        )),
    );
    // Bottom-left glow
    canvas.drawCircle(
      Offset(size.width * 0.05, size.height * 0.9),
      size.width * 0.55,
      Paint()
        ..shader = RadialGradient(
          colors: [accent.withValues(alpha: 0.12), Colors.transparent],
        ).createShader(Rect.fromCircle(
          center: Offset(size.width * 0.05, size.height * 0.9),
          radius: size.width * 0.55,
        )),
    );
  }

  @override
  bool shouldRepaint(_BackgroundPainter old) => old.accent != accent;
}

// ── Icon painters ─────────────────────────────────────────────────────────────

/// Slide 1 — person silhouette with a star above
class _PersonStarPainter extends CustomPainter {
  const _PersonStarPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Head
    canvas.drawCircle(
      Offset(cx, cy * 0.42),
      size.width * 0.14,
      paint,
    );

    // Body (rounded rectangle)
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx, cy * 1.05),
        width: size.width * 0.42,
        height: size.height * 0.35,
      ),
      const Radius.circular(40),
    );
    canvas.drawRRect(bodyRect, paint);

    // Star (top-right)
    _drawStar(
      canvas,
      Offset(cx + size.width * 0.28, cy * 0.18),
      size.width * 0.11,
      Paint()..color = Colors.white.withValues(alpha: 0.95),
    );
  }

  void _drawStar(Canvas canvas, Offset center, double r, Paint paint) {
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final outer = Offset(
        center.dx + r * math.cos((i * 72 - 90) * math.pi / 180),
        center.dy + r * math.sin((i * 72 - 90) * math.pi / 180),
      );
      final inner = Offset(
        center.dx +
            (r * 0.42) *
                math.cos(((i * 72) + 36 - 90) * math.pi / 180),
        center.dy +
            (r * 0.42) *
                math.sin(((i * 72) + 36 - 90) * math.pi / 180),
      );
      if (i == 0) {
        path.moveTo(outer.dx, outer.dy);
      } else {
        path.lineTo(outer.dx, outer.dy);
      }
      path.lineTo(inner.dx, inner.dy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

/// Slide 2 — briefcase with a lightning bolt
class _BriefcaseLightningPainter extends CustomPainter {
  const _BriefcaseLightningPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Briefcase body
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx, cy + size.height * 0.06),
        width: size.width * 0.7,
        height: size.height * 0.46,
      ),
      const Radius.circular(10),
    );
    canvas.drawRRect(bodyRect, paint);

    // Briefcase handle
    final handlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.07
      ..strokeCap = StrokeCap.round;
    final handleRect = Rect.fromCenter(
      center: Offset(cx, cy - size.height * 0.16),
      width: size.width * 0.32,
      height: size.height * 0.18,
    );
    canvas.drawArc(handleRect, math.pi, math.pi, false, handlePaint);

    // Lightning bolt (overlay)
    final boltPaint = Paint()
      ..color = color.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;
    final bolt = Path()
      ..moveTo(cx + size.width * 0.04, cy - size.height * 0.04)
      ..lineTo(cx - size.width * 0.08, cy + size.height * 0.08)
      ..lineTo(cx + size.width * 0.01, cy + size.height * 0.05)
      ..lineTo(cx - size.width * 0.04, cy + size.height * 0.2)
      ..lineTo(cx + size.width * 0.1, cy + size.height * 0.04)
      ..lineTo(cx + size.width * 0.02, cy + size.height * 0.07)
      ..close();
    canvas.drawPath(bolt, boltPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

/// Slide 3 — two hands meeting in a handshake
class _HandshakePainter extends CustomPainter {
  const _HandshakePainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.075
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Left arm
    final leftArm = Path()
      ..moveTo(size.width * 0.05, cy + size.height * 0.22)
      ..cubicTo(
        size.width * 0.12, cy,
        size.width * 0.22, cy - size.height * 0.08,
        cx - size.width * 0.04, cy - size.height * 0.02,
      );
    canvas.drawPath(leftArm, paint);

    // Right arm
    final rightArm = Path()
      ..moveTo(size.width * 0.95, cy + size.height * 0.22)
      ..cubicTo(
        size.width * 0.88, cy,
        size.width * 0.78, cy - size.height * 0.08,
        cx + size.width * 0.04, cy - size.height * 0.02,
      );
    canvas.drawPath(rightArm, paint);

    // Clasped hands — filled oval in centre
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy - size.height * 0.02),
        width: size.width * 0.26,
        height: size.height * 0.2,
      ),
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );

    // Finger lines on the clasped oval
    final fingerPaint = Paint()
      ..color = color.withValues(alpha: 0.6)
      ..strokeWidth = size.width * 0.04
      ..strokeCap = StrokeCap.round;
    for (int i = -1; i <= 1; i++) {
      canvas.drawLine(
        Offset(cx + i * size.width * 0.06, cy - size.height * 0.09),
        Offset(cx + i * size.width * 0.06, cy + size.height * 0.05),
        fingerPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
