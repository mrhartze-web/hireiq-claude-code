import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class CareerRoadmap extends StatelessWidget {
  const CareerRoadmap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Career Roadmap'),
        backgroundColor: HireIQTheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRoadmapHeader(),
            const SizedBox(height: 30),
            _buildSkillsSection(),
            const SizedBox(height: 30),
            _buildRecommendationCard(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildRoadmapHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.map_outlined, color: HireIQTheme.primary),
              const SizedBox(width: 10),
              Text('Your Career Roadmap', style: HireIQTheme.subtitleStyle),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Based on your profile and Johannesburg market data',
            style: HireIQTheme.bodyStyle
                .copyWith(color: HireIQTheme.textSecondary, fontSize: 12),
          ),
          const SizedBox(height: 30),
          _buildPathStep('Current', 'Mid Flutter Dev', isCurrent: true),
          _buildPathConnector(),
          _buildPathStep('Target', 'Lead Mobile Engineer', isTarget: true),
        ],
      ),
    );
  }

  Widget _buildPathStep(String label, String title,
      {bool isCurrent = false, bool isTarget = false}) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: isCurrent
                ? HireIQTheme.primary
                : (isTarget ? HireIQTheme.accent : HireIQTheme.border),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.textSecondary)),
            Text(title,
                style: HireIQTheme.bodyStyle
                    .copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildPathConnector() {
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 2, bottom: 2),
      width: 2,
      height: 30,
      color: HireIQTheme.border,
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Skills to develop', style: HireIQTheme.subtitleStyle),
        const SizedBox(height: 15),
        _buildSkillChip('Clean Architecture'),
        _buildSkillChip('System Design'),
        _buildSkillChip('CI/CD Pipelines'),
        _buildSkillChip('Team Leadership'),
      ],
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: HireIQTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: HireIQTheme.bodyStyle),
          const Icon(Icons.chevron_right,
              size: 18, color: HireIQTheme.textSecondary),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [HireIQTheme.primary, HireIQTheme.primary.withAlpha(204)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recommended this week',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Complete the Flutter Architecture course to boost your skill score by +15 points.',
            style: TextStyle(color: Colors.white, height: 1.4),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: HireIQTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Start Now →'),
          ),
        ],
      ),
    );
  }
}
