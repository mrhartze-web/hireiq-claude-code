import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class RecruiterEarningsDashboardWeb extends StatelessWidget {
  const RecruiterEarningsDashboardWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Earnings Dashboard',
              style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 8),
            Text(
              'Placement fee tiers: 10% junior · 12% mid-level · 15% senior & specialist',
              style: GoogleFonts.inter(
                  fontSize: 14, color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
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
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(
                    HireIQTheme.primaryNavy.withValues(alpha: 0.04)),
                dataRowMinHeight: 52,
                dataRowMaxHeight: 52,
                columns: [
                  DataColumn(
                    label: Text(
                      'Role',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: HireIQTheme.primaryNavy),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Annual Salary',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: HireIQTheme.primaryNavy),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Fee Percentage',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: HireIQTheme.primaryNavy),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Fee Amount',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: HireIQTheme.primaryNavy),
                    ),
                  ),
                ],
                rows: [
                  _buildRow('Junior Developer', 'R200,000', '10%', 'R20,000'),
                  _buildRow(
                      'Mid-Level Engineer', 'R350,000', '12%', 'R42,000'),
                  _buildRow('Senior Developer', 'R300,000', '12%', 'R36,000'),
                  _buildRow(
                      'Senior Specialist', 'R480,000', '15%', 'R72,000'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildRow(
      String role, String salary, String feePercent, String feeAmount) {
    return DataRow(cells: [
      DataCell(Text(role,
          style: GoogleFonts.inter(
              color: HireIQTheme.primaryNavy, fontWeight: FontWeight.w500))),
      DataCell(Text(salary,
          style: GoogleFonts.inter(color: HireIQTheme.textPrimary))),
      DataCell(Text(feePercent,
          style: GoogleFonts.inter(color: HireIQTheme.textPrimary))),
      DataCell(Text(feeAmount,
          style: GoogleFonts.inter(
              color: HireIQTheme.primaryTeal, fontWeight: FontWeight.bold))),
    ]);
  }
}
