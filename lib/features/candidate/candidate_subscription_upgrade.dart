import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:go_router/go_router.dart';

class CandidateSubscriptionUpgrade extends StatelessWidget {
  const CandidateSubscriptionUpgrade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.primaryNavy,
      appBar: AppBar(
        title: const Text('Upgrade to Pro',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.workspace_premium,
                color: HireIQTheme.amber, size: 80),
            const SizedBox(height: 24),
            const Text(
              'Stand out to top employers',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Get 3x more profile views and priority placement with HireIQ Pro.',
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 20)
                ],
              ),
              child: Column(
                children: [
                  const Text('Pro Plan',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 8),
                  const Text('R49',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                          color: HireIQTheme.primaryTeal)),
                  const Text('per month',
                      style: TextStyle(color: HireIQTheme.textMuted)),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  _buildFeatureRow('Priority MatchIQ ranking'),
                  _buildFeatureRow('Unlimited skill assessments'),
                  _buildFeatureRow('Detailed salary insights'),
                  _buildFeatureRow('Direct messaging with recruiters',
                      isLast: true),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      context.pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Successfully upgraded to Pro!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 55),
                      backgroundColor: HireIQTheme.primaryTeal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Upgrade Now',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String text, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Row(
        children: [
          const Icon(Icons.check_circle,
              color: HireIQTheme.primaryTeal, size: 20),
          const SizedBox(width: 12),
          Expanded(
              child: Text(text,
                  style: const TextStyle(
                      color: HireIQTheme.primaryNavy,
                      fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
