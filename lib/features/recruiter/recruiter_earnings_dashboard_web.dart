import 'package:flutter/material.dart';
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
            const Text(
              'Earnings Dashboard',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 20),
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: HireIQTheme.surfaceWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: HireIQTheme.borderLight),
                ),
                child: DataTable(columns: const [
                  DataColumn(
                      label: Text('Role',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Annual Salary',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Fee Percentage',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Fee Amount',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ], rows: const [
                  DataRow(cells: [
                    DataCell(Text('Senior Developer')),
                    DataCell(Text('R300,000')),
                    DataCell(Text('12%')),
                    DataCell(Text('R36,000')),
                  ])
                ])),
          ],
        ),
      ),
    );
  }
}
