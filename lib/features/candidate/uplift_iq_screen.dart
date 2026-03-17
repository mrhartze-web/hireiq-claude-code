import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class UpliftIQScreen extends StatelessWidget {
  const UpliftIQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('UpliftIQ'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your career roadmap',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 8),
            const Text(
              'Based on your profile and SA market data',
              style: TextStyle(color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 32),
            _buildPathCard(),
            const SizedBox(height: 40),
            _buildSectionTitle('Skills to develop'),
            const SizedBox(height: 16),
            _buildSkillProgress(
                'Advanced State Management (BLoC/Riverpod)', 0.7),
            _buildSkillProgress(
                'CI/CD for Mobile (GitHub Actions/Codemagic)', 0.4),
            _buildSkillProgress('Unit & Integration Testing', 0.2),
            _buildSkillProgress('System Design & Architecture', 0.1),
            const SizedBox(height: 40),
            _buildRecommendedCard(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPathCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('Current',
                  style: TextStyle(fontSize: 12, color: HireIQTheme.textMuted)),
              SizedBox(height: 8),
              Text('Mid Flutter Dev',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy)),
            ],
          ),
          Icon(Icons.arrow_forward, color: HireIQTheme.primaryTeal),
          Column(
            children: [
              Text('Target',
                  style: TextStyle(fontSize: 12, color: HireIQTheme.textMuted)),
              SizedBox(height: 8),
              Text('Lead Mobile Engineer',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryTeal)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: HireIQTheme.primaryNavy),
    );
  }

  Widget _buildSkillProgress(String skill, double progress) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(skill,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14)),
              Text('${(progress * 100).toInt()}%',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryTeal)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: HireIQTheme.borderLight,
            valueColor: const AlwaysStoppedAnimation(HireIQTheme.primaryTeal),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [HireIQTheme.primaryTeal, Color(0xFF0F766E)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recommended this week',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text(
            'Complete the Flutter Architecture course to boost your "System Design" skill.',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.4),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: HireIQTheme.primaryTeal,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Start now →',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
