import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/recruiter_provider.dart';
import '../../providers/auth_provider.dart';

class RecruiterEarningsDashboard extends ConsumerWidget {
  const RecruiterEarningsDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;
    if (user == null) {
      return const Center(child: Text('Not Authenticated'));
    }
    ref.watch(recruiterPlacementsProvider(user.uid));
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Earnings',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.date_range, color: Colors.white),
              onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryNavy,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
                boxShadow: [
                  BoxShadow(
                    color: HireIQTheme.primaryNavy.withValues(alpha: 0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Earnings (YTD)',
                    style: GoogleFonts.inter(
                        color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'R 450,000',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pending Payouts',
                            style: GoogleFonts.inter(
                                color: Colors.white70, fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'R 75,000',
                            style: GoogleFonts.inter(
                                color: HireIQTheme.primaryTeal,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Active Placements',
                            style: GoogleFonts.inter(
                                color: Colors.white70, fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '3',
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Recent Payouts',
              style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 16),
            _buildFeeCard(
              role: 'Senior Developer',
              annualSalary: 'R500,000',
              feePercentage: '15%',
              feeAmount: 'R75,000',
            ),
            _buildFeeCard(
              role: 'Mid-Level UX Designer',
              annualSalary: 'R400,000',
              feePercentage: '12%',
              feeAmount: 'R48,000',
            ),
            const SizedBox(height: 24),
            Text(
              'Pending (Awaiting Guarantee Period)',
              style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 16),
            _buildFeeCard(
              role: 'Junior Data Scientist',
              annualSalary: 'R280,000',
              feePercentage: '10%',
              feeAmount: 'R28,000',
              isPending: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeeCard({
    required String role,
    required String annualSalary,
    required String feePercentage,
    required String feeAmount,
    bool isPending = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  role,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: HireIQTheme.primaryNavy),
                ),
              ),
              if (isPending)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: HireIQTheme.amber.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: Text(
                    'Pending',
                    style: GoogleFonts.inter(
                        color: HireIQTheme.amber,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildFeeColumn('Annual Salary', annualSalary),
              ),
              Expanded(
                child: _buildFeeColumn('Fee %', feePercentage),
              ),
              Expanded(
                child: _buildFeeColumn('Fee Amount', feeAmount,
                    isHighlight: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeeColumn(String label, String value,
      {bool isHighlight = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
              fontSize: 11, color: HireIQTheme.textMuted),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
            color: isHighlight
                ? HireIQTheme.primaryTeal
                : HireIQTheme.primaryNavy,
          ),
        ),
      ],
    );
  }
}
