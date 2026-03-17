import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class SmartApplyModal extends StatelessWidget {
  const SmartApplyModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      body: Container(
        decoration: const BoxDecoration(
          color: HireIQColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => context.go('/job-detail'),
                  icon: const Icon(Icons.close, color: HireIQColors.navy),
                ),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: HireIQColors.silver,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 48), // Spacer for balance
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Smart Apply',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: HireIQColors.navy,
                      ),
                ),
                const Icon(Icons.auto_awesome_rounded,
                    color: HireIQColors.teal),
              ],
            ),
            const SizedBox(height: 24),
            _buildProfileSnippet(),
            const SizedBox(height: 24),
            _buildHealthIndicator(),
            const SizedBox(height: 32),
            const Text(
              'Generated Cover Letter',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: HireIQColors.navy),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: HireIQColors.silver),
                ),
                child: const SingleChildScrollView(
                  child: Text(
                    "Dear Hiring Manager,\n\nI am thrilled to apply for the Senior Full-Stack Developer position at Google Inc. With my extensive background in architecting React and Node.js applications, I am confident that I can contribute significantly to your core engineering team...\n\nMy experience at Stripe has uniquely prepared me for the high-scale challenges described in the job detail. I look forward to discussing how my skills align with your performance metrics.",
                    style:
                        TextStyle(color: HireIQColors.textMuted, height: 1.6),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.go('/application-tracker');
              },
              child: const Text('Submit Application →'),
            ),
            const SizedBox(height: 12),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.bolt, size: 14, color: HireIQColors.teal),
                  const SizedBox(width: 4),
                  Text(
                    'Powered by HireIQ AI Engine',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: HireIQColors.textMuted,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSnippet() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQColors.silver),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: HireIQColors.teal,
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alex Thompson',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                'alex.t@hireiq.app • +1 (555) 0123',
                style: TextStyle(color: HireIQColors.textMuted, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHealthIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: HireIQColors.teal.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQColors.teal.withValues(alpha: 0.2)),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline_rounded, size: 20, color: HireIQColors.teal),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Almost ready! Complete your portfolio for a 20% higher match rate.',
              style: TextStyle(
                fontSize: 13,
                color: HireIQColors.teal,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
