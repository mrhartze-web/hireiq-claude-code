import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:go_router/go_router.dart';

class CandidateSmartApply extends StatelessWidget {
  const CandidateSmartApply({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Smart Apply'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.auto_awesome,
                color: HireIQTheme.primaryTeal, size: 64),
            const SizedBox(height: 16),
            const Text(
              '92% MatchIQ Fit',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 8),
            const Text(
              'Senior Flutter Developer @ Apex Digital',
              style: TextStyle(color: HireIQTheme.textMuted, fontSize: 16),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: HireIQTheme.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Included in your application:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  ListTile(
                    leading: Icon(Icons.check_circle,
                        color: HireIQTheme.primaryTeal),
                    title: Text('Verified PassportIQ Details'),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle,
                        color: HireIQTheme.primaryTeal),
                    title: Text('WildcardIQ Assessment Score'),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  ListTile(
                    leading: Icon(Icons.check_circle,
                        color: HireIQTheme.primaryTeal),
                    title: Text('Video Pitch'),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Application sent successfully!')),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: HireIQTheme.primaryTeal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('One-Tap Apply',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
