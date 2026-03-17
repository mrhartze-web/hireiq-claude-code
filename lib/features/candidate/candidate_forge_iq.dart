import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class CandidateForgeIq extends StatelessWidget {
  const CandidateForgeIq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('ForgeIQ CV Builder'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Save & Export'),
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
                  Icon(Icons.build_circle,
                      color: HireIQTheme.primaryTeal, size: 48),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AI CV Optimizer',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Text(
                            'Let ForgeIQ format and optimize your experience for ATS systems.',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSectionHeader('Experience'),
            _buildListItem(
                'Senior Backend Engineer', 'Apex Digital • 2021 - Present'),
            _buildListItem(
                'Software Developer', 'FinTech Startup • 2018 - 2021'),
            Center(
                child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Add Experience'))),
            const SizedBox(height: 24),
            _buildSectionHeader('Education'),
            _buildListItem('BSc Computer Science',
                'University of Cape Town • 2014 - 2017'),
            Center(
                child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Add Education'))),
            const SizedBox(height: 24),
            _buildSectionHeader('Skills'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Flutter', 'Dart', 'Firebase', 'Go', 'AWS']
                  .map((skill) => Chip(
                        label: Text(skill),
                        backgroundColor: HireIQTheme.surfaceWhite,
                        side: const BorderSide(color: HireIQTheme.borderLight),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () {},
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            Center(
                child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Add Skill'))),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: HireIQTheme.primaryNavy),
      ),
    );
  }

  Widget _buildListItem(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: ListTile(
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        subtitle: Text(subtitle,
            style: const TextStyle(color: HireIQTheme.textMuted)),
        trailing:
            IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {}),
      ),
    );
  }
}
