import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class CandidateSalaryGuide extends StatelessWidget {
  const CandidateSalaryGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Salary Guide'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Market Insights',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 8),
            const Text(
              'Average salaries based on role and experience in South Africa.',
              style: TextStyle(color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 24),
            _buildSalaryCard(
                'Junior Developer', 'R250k - R400k', '1-3 years experience'),
            _buildSalaryCard(
                'Mid-level Developer', 'R450k - R750k', '3-5 years experience'),
            _buildSalaryCard(
                'Senior Developer', 'R800k - R1.2m', '5+ years experience',
                highlight: true),
            _buildSalaryCard('Tech Lead / Architect', 'R1.1m - R1.8m',
                '8+ years experience'),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryNavy,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline,
                          color: HireIQTheme.amber, size: 24),
                      SizedBox(width: 12),
                      Text('Negotiation Tip',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Always wait for the employer to state their budget first. Use your MatchIQ score and Wildcard skills as leverage to negotiate to the higher end of the bracket.',
                    style: TextStyle(color: Colors.white70, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalaryCard(String role, String range, String exp,
      {bool highlight = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color:
                highlight ? HireIQTheme.primaryTeal : HireIQTheme.borderLight,
            width: highlight ? 2 : 1),
        boxShadow: highlight
            ? [
                BoxShadow(
                    color: HireIQTheme.primaryTeal.withAlpha(25),
                    blurRadius: 10,
                    offset: const Offset(0, 4))
              ]
            : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(role,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 4),
                Text(exp,
                    style: const TextStyle(
                        color: HireIQTheme.textMuted, fontSize: 13)),
              ],
            ),
          ),
          Text(range,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: highlight
                      ? HireIQTheme.primaryTeal
                      : HireIQTheme.primaryNavy)),
        ],
      ),
    );
  }
}
