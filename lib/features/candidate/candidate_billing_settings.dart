import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:go_router/go_router.dart';

class CandidateBillingSettings extends StatelessWidget {
  const CandidateBillingSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Billing'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Current Plan',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryNavy,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Free Tier',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: HireIQTheme.primaryTeal.withAlpha(51),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('Active',
                            style: TextStyle(
                                color: HireIQTheme.primaryTeal,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                      'Basic profile visibility and standard application features.',
                      style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.push('/candidate/upgrade'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HireIQTheme.primaryTeal,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    child: const Text('Upgrade to Pro',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Payment Method',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: ListTile(
                leading: const Icon(Icons.credit_card,
                    color: HireIQTheme.primaryNavy),
                title: const Text('No payment method added',
                    style: TextStyle(color: HireIQTheme.textMuted)),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text('Add'),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Billing History',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('No billing history available.',
                    style: TextStyle(color: HireIQTheme.textMuted)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
