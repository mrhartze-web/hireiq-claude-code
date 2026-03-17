import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';
import '../mobile_screens.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: HireIQTheme.textPrimary),
          onPressed: () => context.go(MobileRoutes.login),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: HireIQTheme.primary.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.mark_email_unread_outlined,
                  color: HireIQTheme.primary, size: 60),
            ),
            const SizedBox(height: 40),
            Text('Check your inbox', style: HireIQTheme.titleStyle),
            const SizedBox(height: 15),
            Text(
              "We've sent a verification link to your email. Click the link in the email to activate your account. If you don't see it, check your spam folder.",
              textAlign: TextAlign.center,
              style: HireIQTheme.bodyStyle
                  .copyWith(color: HireIQTheme.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Open Email App'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: const Text("Didn't get it? Resend Email"),
            ),
            const Spacer(),
            _buildHelpSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.help_outline,
                  color: HireIQTheme.textSecondary, size: 20),
              const SizedBox(width: 10),
              Text('Common Issues',
                  style: HireIQTheme.bodyStyle
                      .copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 15),
          _buildHelpItem('Check if your email address is correct.'),
          _buildHelpItem('Look in your spam or junk folder.'),
          _buildHelpItem('Wait a few minutes for the email to arrive.'),
        ],
      ),
    );
  }

  Widget _buildHelpItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
                color: HireIQTheme.textSecondary, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 12, color: HireIQTheme.textSecondary))),
        ],
      ),
    );
  }
}
