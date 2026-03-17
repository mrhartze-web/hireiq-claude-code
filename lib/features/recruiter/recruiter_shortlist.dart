import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class RecruiterShortlist extends StatelessWidget {
  const RecruiterShortlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Candidate Shortlist'),
        backgroundColor: HireIQTheme.surface,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildHeader(),
          const SizedBox(height: 25),
          _buildCandidateCard(
            name: 'Thabo Nkosi',
            experience: '5 yrs exp',
            matchIq: '94',
            wildcardIq: '847',
          ),
          _buildCandidateCard(
            name: 'Sipho Khumalo',
            experience: '8 yrs exp',
            matchIq: '89',
            wildcardIq: '912',
          ),
          _buildCandidateCard(
            name: 'Naledi Mokoena',
            experience: '6 yrs exp',
            matchIq: '91',
            wildcardIq: '885',
          ),
          const SizedBox(height: 20),
          _buildInfoFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Head of Engineering — FinCorp SA',
            style: HireIQTheme.subtitleStyle),
        const SizedBox(height: 5),
        Text('6 shortlisted candidates',
            style: HireIQTheme.bodyStyle
                .copyWith(color: HireIQTheme.textSecondary)),
      ],
    );
  }

  Widget _buildCandidateCard({
    required String name,
    required String experience,
    required String matchIq,
    required String wildcardIq,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: HireIQTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: HireIQTheme.primary.withAlpha(25),
                child: Text(name[0],
                    style: const TextStyle(
                        color: HireIQTheme.primary,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style:
                            HireIQTheme.subtitleStyle.copyWith(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(experience,
                        style: HireIQTheme.bodyStyle.copyWith(
                            color: HireIQTheme.textSecondary, fontSize: 13)),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: HireIQTheme.accent.withAlpha(25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('MatchIQ $matchIq',
                    style: const TextStyle(
                        color: HireIQTheme.accent,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              ),
            ],
          ),
          const Divider(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome,
                      color: HireIQTheme.primary, size: 18),
                  const SizedBox(width: 8),
                  Text('WildcardIQ: $wildcardIq',
                      style: HireIQTheme.bodyStyle
                          .copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text('View Profile'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoFooter() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: HireIQTheme.accent.withAlpha(12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.accent.withAlpha(51)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_outline, color: HireIQTheme.accent, size: 20),
              SizedBox(width: 10),
              Text('Placement fee on hire: R14,250–R18,000',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '(15% of first-year salary). 90-day guarantee included.',
            style: HireIQTheme.bodyStyle
                .copyWith(fontSize: 12, color: HireIQTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}
