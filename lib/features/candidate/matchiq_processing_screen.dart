import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class MatchIQProcessingScreen extends ConsumerStatefulWidget {
  const MatchIQProcessingScreen({super.key});

  @override
  ConsumerState<MatchIQProcessingScreen> createState() =>
      _MatchIQProcessingScreenState();
}

class _MatchIQProcessingScreenState extends ConsumerState<MatchIQProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _countController;
  int _bulletIndex = 0;
  Timer? _bulletTimer;
  Timer? _navTimer;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _countController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..forward();

    _bulletTimer = Timer.periodic(const Duration(milliseconds: 900), (timer) {
      if (_bulletIndex < 2) {
        setState(() => _bulletIndex++);
      } else {
        timer.cancel();
      }
    });

    _navTimer = Timer(const Duration(milliseconds: 3200), () {
      if (mounted) context.go('/candidate/wildcard-score');
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _countController.dispose();
    _bulletTimer?.cancel();
    _navTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bullets = [
      'Comparing your skills to role requirements',
      'Weighing your experience level',
      'Calculating your culture fit score',
    ];

    return Scaffold(
      backgroundColor: HireIQTheme.primaryNavy,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated ring
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, _) {
                    return SizedBox(
                      width: 160,
                      height: 160,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer ring
                          Transform.scale(
                            scale: 1.0 + _pulseController.value * 0.4,
                            child: Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: HireIQTheme.primaryTeal.withValues(
                                      alpha: 1 - _pulseController.value),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          // Inner ring
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: HireIQTheme.primaryTeal.withValues(
                                    alpha: _pulseController.value),
                                width: 2,
                              ),
                            ),
                          ),
                          // Centre
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: HireIQTheme.primaryTeal.withValues(alpha: 0.2),
                            ),
                            child: const Icon(
                              Icons.track_changes_outlined,
                              size: 40,
                              color: HireIQTheme.primaryTeal,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                Text(
                  'MatchIQ is scoring your fit',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                Text(
                  'Analysing 47 data points across skills, experience, location, and culture fit.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.65),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // Bullet items
                ...List.generate(bullets.length, (index) {
                  final show = _bulletIndex >= index;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AnimatedOpacity(
                      opacity: show ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 400),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 16,
                            color: HireIQTheme.primaryTeal,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            bullets[index],
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 40),

                // Progress percentage
                AnimatedBuilder(
                  animation: _countController,
                  builder: (context, _) {
                    return Text(
                      '${(_countController.value * 100).toInt()}%',
                      style: GoogleFonts.inter(
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                        color: HireIQTheme.primaryTeal,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
