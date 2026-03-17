import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:flutter/services.dart';

class CandidateReferral extends StatelessWidget {
  const CandidateReferral({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Refer & Earn'),
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
                  Icon(Icons.card_giftcard, color: HireIQTheme.amber, size: 64),
                  SizedBox(height: 16),
                  Text('Earn up to R5,000',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('for every successful placement referred by you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Your Unique Link',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy)),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text('hireiq.com/ref/dwayne-12x9a',
                        style: TextStyle(
                            color: HireIQTheme.primaryNavy,
                            fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.copy, color: HireIQTheme.primaryTeal),
                    onPressed: () {
                      Clipboard.setData(const ClipboardData(
                          text: 'hireiq.com/ref/dwayne-12x9a'));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Copied to clipboard!')));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            _buildStatCard('Total Referrals', '12', Icons.people_outline),
            const SizedBox(height: 16),
            _buildStatCard('Total Earned', 'R15,000', Icons.payments_outlined,
                color: HireIQTheme.primaryTeal),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon,
      {Color color = HireIQTheme.primaryNavy}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: color.withAlpha(25), shape: BoxShape.circle),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 16),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: HireIQTheme.primaryNavy)),
            ],
          ),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 24, color: color)),
        ],
      ),
    );
  }
}
