import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class SocialAuthLoadingScreen extends StatelessWidget {
  const SocialAuthLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                    strokeWidth: 3, color: HireIQTheme.primary),
              ),
              const SizedBox(height: 40),
              Text('Signing in with Google', style: HireIQTheme.subtitleStyle),
              const SizedBox(height: 15),
              const Text(
                'Connecting your Google account...',
                style: TextStyle(color: HireIQTheme.textSecondary),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: HireIQTheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: HireIQTheme.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.security, color: Colors.green, size: 30),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        'HireIQ only accesses your name and email. We never post to Google or share your private data.',
                        style: HireIQTheme.bodyStyle
                            .copyWith(fontSize: 12, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
