import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:go_router/go_router.dart';
import '../../shared/components/candidate_card.dart';

class EmployerCandidates extends StatelessWidget {
  const EmployerCandidates({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Candidate Pool'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => context.push('/employer/candidate-search'),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Top MatchIQ Fits',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 8),
                  const Text(
                      'Candidates sorted by their relevance to your active briefs.',
                      style: TextStyle(color: HireIQTheme.textMuted)),
                  const SizedBox(height: 24),
                  CandidateCard(
                    name: 'Alex T.',
                    role: 'Backend Developer',
                    matchIqScore: 94,
                    onActionPressed: () {},
                  ),
                  CandidateCard(
                    name: 'Samantha J.',
                    role: 'Flutter Developer',
                    matchIqScore: 89,
                    onActionPressed: () {},
                  ),
                  CandidateCard(
                    name: 'Michael B.',
                    role: 'Tech Lead',
                    matchIqScore: 85,
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
