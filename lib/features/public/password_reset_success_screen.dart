import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';
import '../mobile_screens.dart';

class PasswordResetSuccessScreen extends StatelessWidget {
  const PasswordResetSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_outline_rounded,
                  color: Colors.green, size: 80),
            ),
            const SizedBox(height: 30),
            Text('Password reset!', style: HireIQTheme.titleStyle),
            const SizedBox(height: 15),
            Text(
              'Your password has been successfully updated. You can now use your new password to log in to your account.',
              textAlign: TextAlign.center,
              style: HireIQTheme.bodyStyle
                  .copyWith(color: HireIQTheme.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: HireIQTheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: HireIQTheme.border),
              ),
              child: Column(
                children: [
                  const Text('Security Log',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: HireIQTheme.textSecondary)),
                  const SizedBox(height: 10),
                  Text('Account: hireiq_user',
                      style: HireIQTheme.bodyStyle.copyWith(fontSize: 13)),
                  Text('Timestamp: Oct 24, 2023, 14:30',
                      style: HireIQTheme.bodyStyle.copyWith(
                          fontSize: 13, color: HireIQTheme.textSecondary)),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => context.go(MobileRoutes.login),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Back to Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: const Text('Need help? support@hireiq.com'),
            ),
          ],
        ),
      ),
    );
  }
}
