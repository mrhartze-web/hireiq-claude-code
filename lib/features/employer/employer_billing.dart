import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class EmployerBilling extends StatelessWidget {
  const EmployerBilling({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Billing & Invoices'),
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
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Outstanding Balance',
                      style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 8),
                  const Text('R 0.00',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HireIQTheme.primaryTeal,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    child: const Text('Make a Payment',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Payment Methods',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy)),
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
                title: const Text('Visa ending in 4242',
                    style: TextStyle(
                        color: HireIQTheme.primaryNavy,
                        fontWeight: FontWeight.bold)),
                subtitle: const Text('Default payment method',
                    style: TextStyle(color: HireIQTheme.textMuted)),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text('Edit'),
                ),
              ),
            ),
            const SizedBox(height: 48),
            const Text('Recent Invoices',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 16),
            _buildInvoiceRow(
                'INV-2023-142', 'Oct 01, 2023', 'R 12,500.00', true),
            _buildInvoiceRow(
                'INV-2023-108', 'Sep 01, 2023', 'R 8,200.00', true),
            _buildInvoiceRow(
                'INV-2023-094', 'Aug 01, 2023', 'R 15,000.00', true),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceRow(String id, String date, String amount, bool isPaid) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(id,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 4),
              Text(date,
                  style: const TextStyle(
                      color: HireIQTheme.textMuted, fontSize: 13)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 4),
              Text(isPaid ? 'Paid' : 'Pending',
                  style: TextStyle(
                      color: isPaid
                          ? HireIQTheme.primaryTeal
                          : HireIQTheme.warning,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
