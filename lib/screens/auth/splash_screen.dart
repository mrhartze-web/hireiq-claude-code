import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../theme/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/role-selection');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.navy,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Placeholder - Using a stylized Icon for now
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.psychology_outlined,
                size: 80,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'HireIQ',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Hiring Intelligence',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                    letterSpacing: 4,
                    fontWeight: FontWeight.w300,
                  ),
            ),
            const SizedBox(height: 64),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(HireIQColors.tealLight),
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
