import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';

class MaintenanceScreen extends ConsumerStatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  ConsumerState<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends ConsumerState<MaintenanceScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CustomPaint(
                    painter: _NeuralNetPainter(),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "We'll be right back",
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'HireIQ is undergoing scheduled maintenance.\nWe\'ll be back shortly.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.7),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(3, (index) {
                        final offset = index * 0.33;
                        final t = (_controller.value - offset) % 1.0;
                        final opacity =
                            (math.sin(t * math.pi * 2) * 0.5 + 0.5)
                                .clamp(0.2, 1.0);
                        return Padding(
                          padding: EdgeInsets.only(right: index < 2 ? 8 : 0),
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: HireIQTheme.primaryTeal
                                  .withValues(alpha: opacity),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                    border:
                        Border.all(color: HireIQTheme.amber),
                  ),
                  child: Text(
                    'Back online by 14:00 SAST',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.amber,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => context.go('/status'),
                  child: Text(
                    'Check system status →',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: HireIQTheme.primaryTeal,
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

class _NeuralNetPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = HireIQTheme.primaryTeal
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // 6 nodes: tl, ml, bl (left column), tr, mr, br (right column)
    final nodes = [
      Offset(size.width * 0.2, size.height * 0.1),  // tl
      Offset(size.width * 0.2, size.height * 0.5),  // ml
      Offset(size.width * 0.2, size.height * 0.9),  // bl
      Offset(size.width * 0.8, size.height * 0.1),  // tr
      Offset(size.width * 0.8, size.height * 0.5),  // mr
      Offset(size.width * 0.8, size.height * 0.9),  // br
    ];

    // Draw connections
    final connections = [
      [0, 3], [0, 4], [1, 3], [1, 4], [1, 5], [2, 4], [2, 5],
    ];

    for (final conn in connections) {
      canvas.drawLine(nodes[conn[0]], nodes[conn[1]], linePaint);
    }

    // Draw nodes
    for (final node in nodes) {
      canvas.drawCircle(node, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
