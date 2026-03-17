import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class CandidateOnboarding5Screen extends StatelessWidget {
  const CandidateOnboarding5Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/candidate-onboarding-4'),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const LinearProgressIndicator(
          value: 1.0, // 5/5
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
                '5/5',
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
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: HireIQColors.teal.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline_rounded,
                  size: 80,
                  color: HireIQColors.teal,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Almost done!',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: HireIQColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your profile is ready. HireIQ is now finding the best roles for you.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: HireIQColors.textMuted,
                    ),
              ),
              const SizedBox(height: 48),

              // Bio Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: HireIQColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: HireIQColors.silver),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile Summary',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Recruiters value a short, punchy summary of who you are and what you bring to the table.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      maxLines: 4,
                      maxLength: 500,
                      decoration: InputDecoration(
                        hintText: 'I am a passionate Flutter developer with...',
                        fillColor: HireIQColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: HireIQColors.silver),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: () {
                  // Final Action - Go to Dashboard
                  context.go('/job-feed');
                },
                child: const Text('Complete Profile'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
