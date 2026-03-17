import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class CandidateMatchIqExplanation extends StatelessWidget {
  const CandidateMatchIqExplanation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('MatchIQ Score'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryNavy,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          value: 0.92,
                          backgroundColor: Colors.white24,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              HireIQTheme.primaryTeal),
                          strokeWidth: 12,
                        ),
                      ),
                      Text('92%',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text('Excellent Match',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(
                      'Your profile is highly aligned with this role based on our AI analysis.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Score Breakdown',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy)),
            ),
            const SizedBox(height: 16),
            _buildBreakdownItem('Skills Match', 0.95,
                '95% match on required and preferred skills.'),
            _buildBreakdownItem('Experience Limit', 0.88,
                '88% match based on your years in the industry.'),
            _buildBreakdownItem('Culture Fit', 0.90,
                '90% alignment with company values from your video pitch.'),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withAlpha(25),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: HireIQTheme.primaryTeal),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb_outline,
                      color: HireIQTheme.primaryTeal, size: 32),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Complete your PassportIQ verification to boost your overall MatchIQ trust score by 5%.',
                      style: TextStyle(
                          color: HireIQTheme.primaryNavy,
                          height: 1.5,
                          fontWeight: FontWeight.w500),
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

  Widget _buildBreakdownItem(String title, double percentage, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: HireIQTheme.primaryNavy)),
              Text('${(percentage * 100).toInt()}%',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryTeal,
                      fontSize: 16)),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: HireIQTheme.borderLight,
            valueColor:
                const AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal),
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 12),
          Text(detail, style: const TextStyle(color: HireIQTheme.textMuted)),
        ],
      ),
    );
  }
}
