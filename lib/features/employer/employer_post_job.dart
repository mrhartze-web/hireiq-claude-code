import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/theme.dart';

class EmployerPostJob extends ConsumerStatefulWidget {
  const EmployerPostJob({super.key});

  @override
  ConsumerState<EmployerPostJob> createState() => _EmployerPostJobState();
}

class _EmployerPostJobState extends ConsumerState<EmployerPostJob> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a New Job'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() => _currentStep++);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          }
        },
        steps: [
          Step(
            title: const Text('Title'),
            content: _buildBasicInfoStep(),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text('Details'),
            content: _buildDetailsStep(),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text('Review'),
            content: _buildReviewStep(),
            isActive: _currentStep >= 2,
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoStep() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Job Title',
              hintText: 'e.g. Senior Flutter Developer'),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Location', hintText: 'e.g. Cape Town (Remote)'),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Employment Type'),
          items: ['Full-time', 'Contract', 'Part-time', 'Freelance']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (val) {},
        ),
      ],
    );
  }

  Widget _buildDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Job Description',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.auto_awesome, size: 16),
              label: const Text('AI Generate'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: 8,
          decoration: const InputDecoration(
            hintText:
                'Describe the role, responsibilities, and requirements...',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
              labelText: 'Salary Range (Optional)',
              hintText: 'e.g. R60k - R80k'),
        ),
      ],
    );
  }

  Widget _buildReviewStep() {
    return Column(
      children: [
        const Icon(Icons.check_circle_outline,
            size: 64, color: HireIQTheme.primaryTeal),
        const SizedBox(height: 16),
        const Text('Ready to Publish?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text(
            'Review your posting details before making it live to candidates.',
            textAlign: TextAlign.center),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: HireIQTheme.primaryTeal,
              foregroundColor: Colors.white,
            ),
            child: const Text('Publish Listing'),
          ),
        ),
      ],
    );
  }
}
