import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class RecruiterBriefBuilder extends StatelessWidget {
  const RecruiterBriefBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Brief Builder (AI)'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Save Draft'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryNavy,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.auto_awesome,
                      color: HireIQTheme.primaryTeal, size: 48),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AI Brief Generation',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Text(
                            'Paste the client requirements and let AI structure the perfect brief for candidate matching.',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Input Client Requirements',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 8,
              decoration: InputDecoration(
                hintText:
                    'Paste raw job description, client notes, or requirements here...',
                hintStyle: const TextStyle(color: HireIQTheme.textMuted),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: HireIQTheme.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: HireIQTheme.borderLight),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.bolt),
              label: const Text('Generate Structured Brief'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: HireIQTheme.primaryTeal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Structured Keywords (Preview)',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['ReactJS', 'Node.js', 'AWS', 'Agile', '5+ Years']
                  .map((skill) => Chip(
                        label: Text(skill),
                        backgroundColor: HireIQTheme.surfaceWhite,
                        labelStyle:
                            const TextStyle(color: HireIQTheme.textMuted),
                        side: const BorderSide(color: HireIQTheme.borderLight),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
