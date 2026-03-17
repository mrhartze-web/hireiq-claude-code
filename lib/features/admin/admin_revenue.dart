import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class AdminRevenueDashboard extends StatelessWidget {
  const AdminRevenueDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revenue \u0026 Billing'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRevenueSummaryCard(),
            const SizedBox(height: 32),
            const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTransactionItem(
                'Pro Plan Monthly - TechFlow', '\$299.00', 'Success'),
            _buildTransactionItem(
                'Enterprise License - DataScale', '\$1,499.00', 'Success'),
            _buildTransactionItem(
                'SkillIQ Verification - User #129', '\$25.00', 'Success'),
            _buildTransactionItem(
                'Pro Plan Yearly - Creative Labs', '\$2,999.00', 'Pending'),
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
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: HireIQTheme.primaryNavy.withAlpha(76),
              blurRadius: 20,
              offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total MRR',
              style: TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 8),
          const Text('\$142,580.00',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMiniStat('Growth', '+12.5%', Icons.trending_up),
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
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
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
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(description,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(status,
                  style: TextStyle(
                      color: isSuccess
                          ? HireIQTheme.primaryTeal
                          : HireIQTheme.amber,
                      fontSize: 12)),
            ],
          ),
          Text(amount,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
