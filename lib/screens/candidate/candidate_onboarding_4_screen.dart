import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class CandidateOnboarding4Screen extends StatefulWidget {
  const CandidateOnboarding4Screen({super.key});

  @override
  State<CandidateOnboarding4Screen> createState() =>
      _CandidateOnboarding4ScreenState();
}

class _CandidateOnboarding4ScreenState
    extends State<CandidateOnboarding4Screen> {
  final List<Map<String, String>> _education = [];

  void _addEducation() {
    setState(() {
      _education.add({
        'institution': '',
        'degree': '',
        'year': '',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/candidate-onboarding-3'),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const LinearProgressIndicator(
          value: 0.8, // 4/5
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
                '4/5',
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
                'Your education',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: HireIQColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Add your educational background to complete your profile.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: HireIQColors.textMuted,
                    ),
              ),
              const SizedBox(height: 40),
              if (_education.isEmpty)
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const Icon(
                        Icons.school_outlined,
                        size: 64,
                        color: HireIQColors.silver,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No education history added yet',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: HireIQColors.textMuted,
                            ),
                      ),
                    ],
                  ),
                )
              else
                ..._education.map((edu) => _EducationCard(
                      institution: edu['institution']!,
                      degree: edu['degree']!,
                      year: edu['year']!,
                    )),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: _addEducation,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add Education'),
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
          onPressed: () => context.go('/candidate-onboarding-5'),
          child: const Text('Continue'),
        ),
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  final String institution;
  final String degree;
  final String year;

  const _EducationCard({
    required this.institution,
    required this.degree,
    required this.year,
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
            child: const Icon(Icons.school_rounded, color: HireIQColors.teal),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  degree.isEmpty ? 'Degree Name' : degree,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  institution.isEmpty ? 'Institution Name' : institution,
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
