import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class EmployerWildcardIq extends StatelessWidget {
  const EmployerWildcardIq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('WildcardIQ Analysis'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryNavy,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.psychology,
                      color: HireIQTheme.primaryTeal, size: 48),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hidden Potential',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(
                            'We analyzed Sarah\'s profile and found unconventional strong matches for this role.',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                height: 1.4)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildInsightCard(
                'Transferable Skills',
                'Although Sarah lacks direct FinTech experience, her work in highly regulated healthcare data systems demonstrates the exact security compliance knowledge required.',
                Icons.swap_horiz),
            _buildInsightCard(
                'Self-Taught Velocity',
                'Her GitHub activity shows she mastered Go in under 3 months while contributing to complex open-source projects, indicating extremely fast onboarding potential.',
                Icons.speed),
            _buildInsightCard(
                'Leadership Capacity',
                'While strictly an individual contributor by title, semantic analysis of her peer reviews indicates she unofficially mentored 3 junior developers over the past year.',
                Icons.groups),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard(String title, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: HireIQTheme.primaryTeal.withAlpha(25),
                    shape: BoxShape.circle),
                child: Icon(icon, color: HireIQTheme.primaryTeal),
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: HireIQTheme.primaryNavy))),
            ],
          ),
          const SizedBox(height: 12),
          Text(description,
              style:
                  const TextStyle(color: HireIQTheme.textMuted, height: 1.5)),
        ],
      ),
    );
  }
}
