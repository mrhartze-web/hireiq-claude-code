import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const Spacer(flex: 2),

                // ── Logo mark ─────────────────────────────────────────────────
                const SizedBox(
                  width: 96,
                  height: 96,
                  child: CustomPaint(painter: _NeuralNetPainter()),
                ),

                const SizedBox(height: 24),

                // ── Wordmark ──────────────────────────────────────────────────
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Hire',
                      style: GoogleFonts.inter(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -1.0,
                      ),
                    ),
                    TextSpan(
                      text: 'IQ',
                      style: GoogleFonts.inter(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: HireIQTheme.primaryTeal,
                        letterSpacing: -1.0,
                      ),
                    ),
                  ]),
                ),

                const SizedBox(height: 16),

                // ── Tagline ───────────────────────────────────────────────────
                Text(
                  'Intelligence that finds talent others miss.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.75),
                    height: 1.5,
                  ),
                ),

                const Spacer(flex: 3),

                // ── Get Started button ────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => context.go('/role-selection'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HireIQTheme.primaryTeal,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ── Sign in link ──────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: Colors.white.withValues(alpha: 0.65),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go('/login'),
                      child: Text(
                        'Sign in',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
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
