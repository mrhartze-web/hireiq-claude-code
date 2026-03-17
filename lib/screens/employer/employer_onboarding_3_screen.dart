import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class EmployerOnboarding3Screen extends StatelessWidget {
  const EmployerOnboarding3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/employer-onboarding-2'),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const LinearProgressIndicator(
          value: 1.0, // 3/3
          backgroundColor: HireIQColors.silver,
          valueColor: AlwaysStoppedAnimation<Color>(HireIQColors.teal),
          minHeight: 6,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '3/3',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: HireIQColors.teal,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: HireIQColors.teal.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified_user_outlined,
                  size: 80,
                  color: HireIQColors.teal,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "You're all set!",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: HireIQColors.textPrimary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Your account is ready. You can now start using our outcome-based hiring model to find top talent based on proven skills and performance metrics.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: HireIQColors.textMuted,
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 60),

              // Call to Action Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: HireIQColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: HireIQColors.silver),
                ),
                child: Column(
                  children: [
                    Text(
                      'Post your first role',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Get your open position in front of qualified candidates in minutes.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: HireIQColors.textMuted,
                          ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to Job Posting flow or Dashboard
                        context.go('/post-job');
                      },
                      child: const Text('Create Job Post'),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              TextButton(
                onPressed: () => context.go('/employer-dashboard'),
                child: const Text(
                  'Skip for now, go to Dashboard',
                  style: TextStyle(color: HireIQColors.textMuted),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
