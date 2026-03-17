import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class AssessmentResultScreen extends StatelessWidget {
  const AssessmentResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => context.go('/candidate-profile'),
            icon: const Icon(Icons.close_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Column(
            children: [
              const Spacer(),
              _buildScoreOrb(),
              const SizedBox(height: 48),
              const Text('Excellent Result!',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: HireIQColors.navy)),
              const SizedBox(height: 8),
              const Text('You scored 1120/1200 points',
                  style: TextStyle(color: HireIQColors.textMuted)),
              const SizedBox(height: 48),
              _buildMetricItem(
                  'Speed Score', '94th percentile', Icons.speed_rounded),
              _buildMetricItem('Accuracy', '98%', Icons.check_circle_rounded),
              _buildMetricItem(
                  'Match Rank', 'Silver Tier', Icons.workspace_premium_rounded),
              const Spacer(),
              ElevatedButton(
                onPressed: () => context.go('/candidate-profile'),
                child: const Text('Add to Passport'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go('/skill-assessment'),
                child: const Text('Retake Assessment'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreOrb() {
    return Container(
      width: 200,
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQColors.teal.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: HireIQColors.teal, width: 4),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('92%',
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: HireIQColors.teal)),
            Text('RANKING',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: HireIQColors.teal,
                    letterSpacing: 2)),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Icon(icon, color: HireIQColors.navy, size: 24),
          const SizedBox(width: 20),
          Expanded(
              child: Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: HireIQColors.navy))),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w900, color: HireIQColors.teal)),
        ],
      ),
    );
  }
}
