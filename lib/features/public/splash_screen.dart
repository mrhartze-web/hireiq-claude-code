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

  // Progress bar (2.5 s)
  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _logoFade =
        CurvedAnimation(parent: _logoController, curve: Curves.easeOut);
    _logoScale = Tween<double>(begin: 0.80, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _runSequence();
  }

  Future<void> _runSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _logoController.forward();
    _progressController.forward();

    await Future.delayed(const Duration(milliseconds: 3000));
    if (mounted) context.go('/onboarding');
  }

  @override
  void dispose() {
    _logoController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.primaryNavy,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              HireIQTheme.primaryNavy,
              Color(0xFF0D9488),
            ],
          ),
        ),
        child: Stack(
          children: [
            // ── Centre logo + wordmark + tagline ────────────────────────────
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Neural-network logo mark
                  FadeTransition(
                    opacity: _logoFade,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: const SizedBox(
                        width: 80,
                        height: 80,
                        child: CustomPaint(painter: _NeuralNetPainter()),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Wordmark — all white, no colour split
                  FadeTransition(
                    opacity: _logoFade,
                    child: Text(
                      'HireIQ',
                      style: GoogleFonts.inter(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Tagline
                  FadeTransition(
                    opacity: _logoFade,
                    child: Text(
                      'Intelligence that finds talent others miss.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Progress bar at ~75% down ────────────────────────────────────
            Positioned(
              top: MediaQuery.of(context).size.height * 0.75,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 120,
                  height: 2,
                  child: AnimatedBuilder(
                    animation: _progressController,
                    builder: (_, __) => Stack(
                      children: [
                        // Track
                        Container(
                          width: 120,
                          height: 2,
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
                        // Animated fill
                        Container(
                          width: 120 * _progressController.value,
                          height: 2,
                          color:
                              const Color(0xFF0D9488).withValues(alpha: 0.7),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ── Version label ────────────────────────────────────────────────
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Text(
                'v1.0.0',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Neural-network custom painter ─────────────────────────────────────────────

class _NeuralNetPainter extends CustomPainter {
  const _NeuralNetPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF0D9488)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Left column (x ≈ 35%) — three rows at 35 %, 50 %, 65 % of height
    final tl = Offset(size.width * 0.35, size.height * 0.35);
    final ml = Offset(size.width * 0.35, size.height * 0.50);
    final bl = Offset(size.width * 0.35, size.height * 0.65);

    // Right column (x ≈ 65%)
    final tr = Offset(size.width * 0.65, size.height * 0.35);
    final mr = Offset(size.width * 0.65, size.height * 0.50);
    final br = Offset(size.width * 0.65, size.height * 0.65);

    // Fully-connected bipartite graph — 9 cross-connections.
    // The diagonals (tl→br, bl→tr) cross through the centre, producing
    // the hourglass/diamond network pattern described in the design spec.
    for (final left in [tl, ml, bl]) {
      for (final right in [tr, mr, br]) {
        canvas.drawLine(left, right, linePaint);
      }
    }

    // Draw dots on top of lines so they are always visible
    for (final dot in [tl, ml, bl, tr, mr, br]) {
      canvas.drawCircle(dot, 4.0, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
