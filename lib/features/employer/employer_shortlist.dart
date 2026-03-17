import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import '../../shared/components/candidate_card.dart';

class EmployerShortlist extends StatelessWidget {
  const EmployerShortlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Saved & Shortlisted'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Compare Shortlisted Candidates',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 8),
                  const Text(
                      'Select multiple candidates to enter comparison view.',
                      style: TextStyle(color: HireIQTheme.textMuted)),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.compare_arrows),
                    label: const Text('Compare Selected (0)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HireIQTheme.primaryNavy,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CandidateCard(
                    name: 'Sarah M.',
                    role: 'Product Designer',
                    matchIqScore: 92,
                    onActionPressed: () {},
                  ),
                  CandidateCard(
                    name: 'James K.',
                    role: 'UX Researcher',
                    matchIqScore: 88,
                    onActionPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
