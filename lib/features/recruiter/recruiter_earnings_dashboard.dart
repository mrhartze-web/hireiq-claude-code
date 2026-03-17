import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import '../../shared/components/placement_fee_card.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/recruiter_provider.dart';
import '../../providers/auth_provider.dart';

class RecruiterEarningsDashboard extends ConsumerWidget {
  const RecruiterEarningsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;
    if (user == null) return const Center(child: Text('Not Authenticated'));
    final placementsAsync = ref.watch(recruiterPlacementsProvider(user.uid));
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Earnings'),
        actions: [
          IconButton(icon: const Icon(Icons.date_range), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryNavy,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Earnings (YTD)',
                      style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 8),
                  const Text('R 450,000',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Pending Payouts',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 13)),
                          const SizedBox(height: 4),
                          Text('R 75,000',
                              style: TextStyle(
                                  color: HireIQTheme.primaryTeal.withAlpha(229),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Active Placements',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 13)),
                          SizedBox(height: 4),
                          Text('3',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Payouts',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy),
              ),
            ),
            const SizedBox(height: 16),
            const PlacementFeeCard(
              feeAmount: 'R 75,000',
              annualSalary: 'R 500,000',
              feePercentage: '15%',
              role: 'Senior Developer',
            ),
            const PlacementFeeCard(
              feeAmount: 'R 60,000',
              annualSalary: 'R 400,000',
              feePercentage: '15%',
              role: 'UX Designer',
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pending (Awaiting Guarantee Period)',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.textMuted),
              ),
            ),
            const SizedBox(height: 16),
            const PlacementFeeCard(
              feeAmount: 'R 75,000',
              annualSalary: 'R 500,000',
              feePercentage: '15%',
              role: 'Data Scientist',
            ),
          ],
        ),
      ),
    );
  }
}
