import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class SkillAssessmentScreen extends StatelessWidget {
  const SkillAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.go('/candidate-profile'),
            icon: const Icon(Icons.close_rounded)),
        title: const Text('Pre-assessment',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: HireIQColors.navy)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Spacer(),
            const Icon(Icons.timer_outlined,
                color: HireIQColors.teal, size: 80),
            const SizedBox(height: 48),
            const Text(
              'Technical Proficiency Test',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: HireIQColors.navy),
            ),
            const SizedBox(height: 16),
            const Text(
              '20 Questions • 30 Minutes\nProctored by HireIQ AI',
              textAlign: TextAlign.center,
              style: TextStyle(color: HireIQColors.textMuted, fontSize: 16),
            ),
            const SizedBox(height: 48),
            _buildRuleItem(
                Icons.lock_outline_rounded, 'Full-screen mode required'),
            _buildRuleItem(
                Icons.camera_alt_outlined, 'Camera proctoring enabled'),
            _buildRuleItem(
                Icons.warning_amber_rounded, 'No tab switching allowed'),
            const Spacer(),
            ElevatedButton(
              onPressed: () => context.go('/assessment-inprogress'),
              child: const Text('Start Assessment →'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: HireIQColors.textMuted),
          const SizedBox(width: 12),
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: HireIQColors.navy)),
        ],
      ),
    );
  }
}
