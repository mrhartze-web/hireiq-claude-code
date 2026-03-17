import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  // Logo entrance
  late final AnimationController _logoController;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;

  // Tagline entrance
  late final AnimationController _taglineController;
  late final Animation<double> _taglineFade;
  late final Animation<Offset> _taglineSlide;

  // Pulsing ring
  late final AnimationController _pulseController;
  late final Animation<double> _pulseScale;
  late final Animation<double> _pulseOpacity;

  // Dot loader
  late final AnimationController _dotController;

  // Exit fade
  late final AnimationController _exitController;
  late final Animation<double> _exitFade;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    // ── Logo ────────────────────────────────────────────────────────────────
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoFade = CurvedAnimation(parent: _logoController, curve: Curves.easeOut);
    _logoScale = Tween<double>(begin: 0.72, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    // ── Tagline ─────────────────────────────────────────────────────────────
    _taglineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _taglineFade =
        CurvedAnimation(parent: _taglineController, curve: Curves.easeOut);
    _taglineSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _taglineController, curve: Curves.easeOut));

    // ── Pulse ring ──────────────────────────────────────────────────────────
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _pulseScale = Tween<double>(begin: 1.0, end: 1.55).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );
    _pulseOpacity = Tween<double>(begin: 0.55, end: 0.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );

    // ── Dot loader ──────────────────────────────────────────────────────────
    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    // ── Exit ────────────────────────────────────────────────────────────────
    _exitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _exitFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeIn),
    );

    _runSequence();
  }

  Future<void> _runSequence() async {
    await Future.delayed(const Duration(milliseconds: 150));
    _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 450));
    _taglineController.forward();

    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;

    await _exitController.forward();
    if (mounted) context.go('/onboarding');
  }

  @override
  void dispose() {
    _logoController.dispose();
    _taglineController.dispose();
    _pulseController.dispose();
    _dotController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _exitFade,
      child: Scaffold(
        backgroundColor: HireIQTheme.primaryNavy,
        body: Stack(
          children: [
            // ── Background radial glow ─────────────────────────────────────
            Positioned.fill(
              child: CustomPaint(painter: _BackgroundPainter()),
            ),

            // ── Main content ──────────────────────────────────────────────
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo mark with pulse
                  _LogoMark(
                    fadeAnimation: _logoFade,
                    scaleAnimation: _logoScale,
                    pulseScale: _pulseScale,
                    pulseOpacity: _pulseOpacity,
                  ),

                  const SizedBox(height: 28),

                  // Wordmark
                  FadeTransition(
                    opacity: _logoFade,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Hire',
                              style: GoogleFonts.inter(
                                fontSize: 44,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -1.0,
                              ),
                            ),
                            TextSpan(
                              text: 'IQ',
                              style: GoogleFonts.inter(
                                fontSize: 44,
                                fontWeight: FontWeight.w800,
                                color: HireIQTheme.primaryTeal,
                                letterSpacing: -1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Tagline
                  SlideTransition(
                    position: _taglineSlide,
                    child: FadeTransition(
                      opacity: _taglineFade,
                      child: Text(
                        'Hire Smarter. Work Better.',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withValues(alpha: 0.55),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 64),

                  // Dot loader
                  FadeTransition(
                    opacity: _taglineFade,
                    child: _DotLoader(controller: _dotController),
                  ),
                ],
              ),
            ),

            // ── Bottom brand strip ────────────────────────────────────────
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _taglineFade,
                child: Text(
                  'Powered by AI · Built for Africa',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.25),
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Logo mark widget ──────────────────────────────────────────────────────────

class _LogoMark extends StatelessWidget {
  const _LogoMark({
    required this.fadeAnimation,
    required this.scaleAnimation,
    required this.pulseScale,
    required this.pulseOpacity,
  });

  final Animation<double> fadeAnimation;
  final Animation<double> scaleAnimation;
  final Animation<double> pulseScale;
  final Animation<double> pulseOpacity;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer pulse ring
              AnimatedBuilder(
                animation: pulseScale,
                builder: (_, __) => Transform.scale(
                  scale: pulseScale.value,
                  child: Opacity(
                    opacity: pulseOpacity.value,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: HireIQTheme.primaryTeal,
                          width: 2.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Inner glow
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.12),
                  border: Border.all(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.35),
                    width: 1.5,
                  ),
                ),
              ),

              // Icon container
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      HireIQTheme.primaryTeal,
                      HireIQTheme.primaryTeal.withValues(alpha: 0.75),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: HireIQTheme.primaryTeal.withValues(alpha: 0.45),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Three-dot loader ──────────────────────────────────────────────────────────

class _DotLoader extends StatelessWidget {
  const _DotLoader({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        final delay = i / 3;
        final animation = TweenSequence<double>([
          TweenSequenceItem(
              tween: Tween(begin: 0.35, end: 1.0)
                  .chain(CurveTween(curve: Curves.easeOut)),
              weight: 30),
          TweenSequenceItem(
              tween: Tween(begin: 1.0, end: 0.35)
                  .chain(CurveTween(curve: Curves.easeIn)),
              weight: 30),
          TweenSequenceItem(
              tween: ConstantTween(0.35),
              weight: 40),
        ]).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(delay, (delay + 0.6).clamp(0.0, 1.0)),
          ),
        );

        return AnimatedBuilder(
          animation: animation,
          builder: (_, __) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: HireIQTheme.primaryTeal.withValues(alpha: animation.value),
            ),
          ),
        );
      }),
    );
  }
}

// ── Background painter ────────────────────────────────────────────────────────

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Top-centre radial glow
    final topGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF0D9488).withValues(alpha: 0.18),
          Colors.transparent,
        ],
        stops: const [0.0, 1.0],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height * 0.28),
          radius: size.width * 0.72,
        ),
      );
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.28),
      size.width * 0.72,
      topGlow,
    );

    // Bottom-right accent glow
    final bottomGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF0D9488).withValues(alpha: 0.10),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width * 0.85, size.height * 0.82),
          radius: size.width * 0.5,
        ),
      );
    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.82),
      size.width * 0.5,
      bottomGlow,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
