import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_provider.dart';
import '../../shared/theme.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  // Phase 1 — logo mark fades and scales in
  late final AnimationController _logoController;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;

  // Phase 2 — wordmark + tagline slide up
  late final AnimationController _taglineController;
  late final Animation<double> _taglineFade;
  late final Animation<Offset> _taglineSlide;

  // Phase 3 — progress bar fills over 2.5 s
  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    // ── Phase 1: logo entrance (800 ms) ──────────────────────────────────────
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );
    _logoScale = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    // ── Phase 2: tagline slide (600 ms) ───────────────────────────────────────
    _taglineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _taglineFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _taglineController, curve: Curves.easeOut),
    );
    _taglineSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _taglineController, curve: Curves.easeOutCubic),
    );

    // ── Phase 3: progress bar (2.5 s) ─────────────────────────────────────────
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // Start after first frame to guarantee controllers are attached
    WidgetsBinding.instance.addPostFrameCallback((_) => _runSequence());
  }

  Future<void> _runSequence() async {
    if (!mounted) return;

    // Logo mark fades and scales in
    await Future.delayed(const Duration(milliseconds: 150));
    if (!mounted) return;
    _logoController.forward();
    _progressController.forward();

    // Wordmark + tagline slides up after logo is mostly visible
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    _taglineController.forward();

    // Wait out the rest of the 3-second splash
    await Future.delayed(const Duration(milliseconds: 2700));
    if (!mounted) return;

    // ── Synchronous auth check ──────────────────────────────────────────────
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      context.go('/welcome');
      return;
    }

    // Returning user — fetch role from Firestore and navigate
    final role =
        await ref.read(authServiceProvider).getUserRole(currentUser.uid);
    if (!mounted) return;

    ref.read(cachedRoleProvider.notifier).state = role;

    switch (role) {
      case 'employer':
        context.go('/employer');
      case 'recruiter':
        context.go('/recruiter');
      case 'admin':
        context.go('/admin');
      default:
        context.go('/candidate');
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _taglineController.dispose();
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
            // ── Centre logo + wordmark + tagline ──────────────────────────────
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Neural-network logo mark — phase 1
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

                  // Wordmark + tagline — phase 2 (slide up)
                  SlideTransition(
                    position: _taglineSlide,
                    child: FadeTransition(
                      opacity: _taglineFade,
                      child: Column(
                        children: [
                          Text(
                            'HireIQ',
                            style: GoogleFonts.inter(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Intelligence that finds talent others miss.',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Progress bar at ~75% down ──────────────────────────────────────
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
                        Container(
                          width: 120,
                          height: 2,
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
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

            // ── Version label ──────────────────────────────────────────────────
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

    final tl = Offset(size.width * 0.35, size.height * 0.35);
    final ml = Offset(size.width * 0.35, size.height * 0.50);
    final bl = Offset(size.width * 0.35, size.height * 0.65);
    final tr = Offset(size.width * 0.65, size.height * 0.35);
    final mr = Offset(size.width * 0.65, size.height * 0.50);
    final br = Offset(size.width * 0.65, size.height * 0.65);

    for (final left in [tl, ml, bl]) {
      for (final right in [tr, mr, br]) {
        canvas.drawLine(left, right, linePaint);
      }
    }

    for (final dot in [tl, ml, bl, tr, mr, br]) {
      canvas.drawCircle(dot, 4.0, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
