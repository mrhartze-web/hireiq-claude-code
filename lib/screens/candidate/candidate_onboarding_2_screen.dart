import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class CandidateOnboarding2Screen extends StatefulWidget {
  const CandidateOnboarding2Screen({super.key});

  @override
  State<CandidateOnboarding2Screen> createState() =>
      _CandidateOnboarding2ScreenState();
}

class _CandidateOnboarding2ScreenState
    extends State<CandidateOnboarding2Screen> {
  final List<Map<String, String>> _experience = [];

  void _addExperience() {
    setState(() {
      _experience.add({
        'company': '',
        'role': '',
        'duration': '',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/candidate-onboarding-1'),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const LinearProgressIndicator(
          value: 0.4, // 2/5
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
                '2/5',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'Your work history',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: HireIQColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Tell us about your professional journey so we can find the best matches.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: HireIQColors.textMuted,
                    ),
              ),
              const SizedBox(height: 40),
              if (_experience.isEmpty)
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const Icon(
                        Icons.work_history_outlined,
                        size: 64,
                        color: HireIQColors.silver,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No work history added yet',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: HireIQColors.textMuted,
                            ),
                      ),
                    ],
                  ),
                )
              else
                ..._experience.map((exp) => _ExperienceCard(
                      company: exp['company']!,
                      role: exp['role']!,
                      duration: exp['duration']!,
                    )),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: _addExperience,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add Experience'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: HireIQColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () => context.go('/candidate-onboarding-3'),
          child: const Text('Continue'),
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final String company;
  final String role;
  final String duration;

  const _ExperienceCard({
    required this.company,
    required this.role,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQColors.silver),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: HireIQColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.business_rounded, color: HireIQColors.teal),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role.isEmpty ? 'New Role' : role,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  company.isEmpty ? 'Company Name' : company,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined, size: 20),
            color: HireIQColors.textMuted,
          ),
        ],
      ),
    );
  }
}
