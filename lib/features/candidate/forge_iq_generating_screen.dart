import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class ForgeIQGeneratingScreen extends ConsumerStatefulWidget {
  const ForgeIQGeneratingScreen({super.key});

  @override
  ConsumerState<ForgeIQGeneratingScreen> createState() =>
      _ForgeIQGeneratingScreenState();
}

class _ForgeIQGeneratingScreenState extends ConsumerState<ForgeIQGeneratingScreen>
    with TickerProviderStateMixin {
  late AnimationController _shimmerController;
  late AnimationController _progressController;
  int _stepIndex = 0;
  Timer? _stepTimer;
  Timer? _navTimer;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    )..forward();

    _stepTimer = Timer.periodic(const Duration(milliseconds: 1100), (timer) {
      if (_stepIndex < 2) {
        setState(() => _stepIndex++);
      } else {
        timer.cancel();
      }
    });

    _navTimer = Timer(const Duration(milliseconds: 3700), () {
      if (mounted) context.go('/candidate/cv-preview');
    });
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _progressController.dispose();
    _stepTimer?.cancel();
    _navTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const steps = [
      'Analysing the job requirements',
      'Matching your experience',
      'Optimising for ATS systems',
    ];

    return Scaffold(
      backgroundColor: HireIQTheme.primaryNavy,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Top graphic
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _shimmerController,
                        builder: (context, _) {
                          return Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: HireIQTheme.primaryTeal.withValues(
                                  alpha: 0.1 + _shimmerController.value * 0.15),
                            ),
                          );
                        },
                      ),
                      const Icon(
                        Icons.description_outlined,
                        size: 56,
                        color: Colors.white,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: AnimatedBuilder(
                          animation: _shimmerController,
                          builder: (context, _) {
                            return Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.amber
                                    .withValues(alpha: _shimmerController.value),
                              ),
                              child: const Icon(
                                Icons.auto_awesome,
                                size: 12,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 36),

                Text(
                  'ForgeIQ is building your CV',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                Text(
                  'AI is crafting a role-specific CV that highlights your most relevant experience.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.65),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // Animated steps
                ...List.generate(steps.length, (index) {
                  final show = _stepIndex >= index;
                  final completed = _stepIndex > index;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: AnimatedOpacity(
                      opacity: show ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 400),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: completed
                                  ? HireIQTheme.primaryTeal
                                  : Colors.white.withValues(alpha: 0.2),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            steps[index],
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 36),

                // Progress bar
                AnimatedBuilder(
                  animation: _progressController,
                  builder: (context, _) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Stack(
                          children: [
                            FractionallySizedBox(
                              widthFactor: _progressController.value,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: HireIQTheme.primaryTeal,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ],
                        ),
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
