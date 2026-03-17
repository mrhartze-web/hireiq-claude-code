import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';
import '../mobile_screens.dart';

class AssessmentResultsScreen extends StatelessWidget {
  const AssessmentResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Assessment Result',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.check_circle,
                color: HireIQTheme.primaryTeal, size: 80),
            const SizedBox(height: 24),
            const Text(
              'Flutter Development — Intermediate',
              style: TextStyle(fontSize: 18, color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 8),
            const Text(
              'Assessment Completed!',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 32),
            _buildWildcardUpdate(),
            const SizedBox(height: 32),
            _buildBadgeSection(),
            const SizedBox(height: 40),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWildcardUpdate() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.primaryNavy,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.trending_up, color: HireIQTheme.primaryTeal, size: 32),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WildcardIQ score updated',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  'Your profile ranking increased by 12 positions',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeSection() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('Your breakdown',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: HireIQTheme.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: HireIQTheme.borderLight),
          ),
          child: const Column(
            children: [
              Icon(Icons.verified, color: HireIQTheme.primaryTeal, size: 48),
              SizedBox(height: 12),
              Text(
                'Flutter Proficient badge earned',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Added to your PassportIQ\nVisible to employers',
                textAlign: TextAlign.center,
                style: TextStyle(color: HireIQTheme.textMuted, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => context.push(MobileRoutes.candidateProfile),
          style: ElevatedButton.styleFrom(
            backgroundColor: HireIQTheme.primaryTeal,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 55),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Back to Profile',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => context.push(MobileRoutes.candidateRoadmap),
          child: const Text('View Career Roadmap'),
        ),
      ],
    );
  }
}
