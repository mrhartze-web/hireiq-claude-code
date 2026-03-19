import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class AdminRevenueDashboard extends StatelessWidget {
  const AdminRevenueDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Revenue & Billing',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRevenueSummaryCard(),
            const SizedBox(height: 32),
            Text(
              'Recent Transactions',
              style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 16),
            _buildTransactionItem(
                'Pro Plan Monthly - TechFlow', 'R4,490.00', 'Success'),
            _buildTransactionItem(
                'Enterprise License - DataScale', 'R22,490.00', 'Success'),
            _buildTransactionItem(
                'SkillIQ Verification - User #129', 'R375.00', 'Success'),
            _buildTransactionItem(
                'Pro Plan Yearly - Creative Labs', 'R44,990.00', 'Pending'),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQTheme.primaryNavy,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total MRR',
            style: GoogleFonts.inter(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            'R2,138,700.00',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // MRR growth — explicitly green
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.arrow_upward_rounded,
                          color: Color(0xFF22C55E), size: 14),
                      const SizedBox(width: 4),
                      Text(
                        'MRR Growth',
                        style: GoogleFonts.inter(
                            color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '+12%',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF22C55E),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              _buildMiniStat('Active Subs', '1,240', Icons.subscriptions),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: HireIQTheme.primaryTeal, size: 14),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.inter(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
      String description, String amount, String status) {
    final bool isSuccess = status == 'Success';

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: (isSuccess
                            ? HireIQTheme.primaryTeal
                            : HireIQTheme.amber)
                        .withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.inter(
                        color: isSuccess
                            ? HireIQTheme.primaryTeal
                            : HireIQTheme.amber,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            amount,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: HireIQTheme.primaryNavy),
          ),
        ],
      ),
    );
  }
}
