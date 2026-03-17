import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class PlacementFeeCard extends StatelessWidget {
  final String role;
  final String annualSalary;
  final String feePercentage;
  final String feeAmount;

  const PlacementFeeCard({
    super.key,
    required this.role,
    required this.annualSalary,
    required this.feePercentage,
    required this.feeAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(role,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildColumn('Annual Salary', annualSalary, context),
              _buildColumn('Fee %', feePercentage, context),
              _buildColumn('Fee Amount', feeAmount, context, isAmount: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColumn(String label, String value, BuildContext context,
      {bool isAmount = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: HireIQTheme.textMuted)),
        const SizedBox(height: 4),
        Text(value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: isAmount ? FontWeight.bold : FontWeight.w500,
                  color: isAmount
                      ? HireIQTheme.primaryTeal
                      : HireIQTheme.primaryNavy,
                )),
      ],
    );
  }
}
