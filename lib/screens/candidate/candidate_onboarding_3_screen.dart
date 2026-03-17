import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class CandidateOnboarding3Screen extends StatefulWidget {
  const CandidateOnboarding3Screen({super.key});

  @override
  State<CandidateOnboarding3Screen> createState() =>
      _CandidateOnboarding3ScreenState();
}

class _CandidateOnboarding3ScreenState
    extends State<CandidateOnboarding3Screen> {
  final List<String> _selectedSkills = [];
  final List<String> _suggestedSkills = [
    'Flutter',
    'Dart',
    'React',
    'Node.js',
    'Python',
    'UI/UX Design',
    'Project Management',
    'Data Analysis'
  ];

  void _toggleSkill(String skill) {
    setState(() {
      if (_selectedSkills.contains(skill)) {
        _selectedSkills.remove(skill);
      } else {
        _selectedSkills.add(skill);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/candidate-onboarding-2'),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const LinearProgressIndicator(
          value: 0.6, // 3/5
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
                '3/5',
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
                'Your skills',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: HireIQColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Add the skills that highlight your professional expertise to help us find the perfect match.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: HireIQColors.textMuted,
                    ),
              ),
              const SizedBox(height: 32),

              // Search Box
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search skills...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: HireIQColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Text(
                'Suggested for you',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _suggestedSkills.map((skill) {
                  final isSelected = _selectedSkills.contains(skill);
                  return FilterChip(
                    label: Text(skill),
                    selected: isSelected,
                    onSelected: (_) => _toggleSkill(skill),
                    backgroundColor: HireIQColors.surface,
                    selectedColor: HireIQColors.teal.withValues(alpha: 0.1),
                    checkmarkColor: HireIQColors.teal,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? HireIQColors.teal
                          : HireIQColors.textPrimary,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: isSelected
                            ? HireIQColors.teal
                            : HireIQColors.silver,
                      ),
                    ),
                  );
                }).toList(),
              ),
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
          onPressed: () => context.go('/candidate-onboarding-4'),
          child: const Text('Continue'),
        ),
      ),
    );
  }
}
