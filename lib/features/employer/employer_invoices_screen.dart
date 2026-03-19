import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class _Invoice {
  final String number;
  final String date;
  final String description;
  final String amount;
  final String status;

  const _Invoice({
    required this.number,
    required this.date,
    required this.description,
    required this.amount,
    required this.status,
  });
}

const List<_Invoice> _invoices = [
  _Invoice(
    number: 'INV-2026-004',
    date: '15 Mar 2026',
    description: 'Enterprise License — DataScale',
    amount: 'R22,490.00',
    status: 'Paid',
  ),
  _Invoice(
    number: 'INV-2026-003',
    date: '01 Mar 2026',
    description: 'Pro Plan Monthly — TechFlow',
    amount: 'R4,490.00',
    status: 'Paid',
  ),
  _Invoice(
    number: 'INV-2026-002',
    date: '15 Feb 2026',
    description: 'Pro Plan Yearly — Creative Labs',
    amount: 'R44,990.00',
    status: 'Pending',
  ),
  _Invoice(
    number: 'INV-2026-001',
    date: '01 Feb 2026',
    description: 'SkillIQ Verification Bundle',
    amount: 'R375.00',
    status: 'Paid',
  ),
];

class EmployerInvoicesScreen extends ConsumerStatefulWidget {
  const EmployerInvoicesScreen({super.key});

  @override
  ConsumerState<EmployerInvoicesScreen> createState() =>
      _EmployerInvoicesScreenState();
}

class _EmployerInvoicesScreenState
    extends ConsumerState<EmployerInvoicesScreen> {
  int _tabIndex = 0;

  List<_Invoice> get _filtered {
    if (_tabIndex == 1) {
      return _invoices.where((i) => i.status == 'Pending').toList();
    } else if (_tabIndex == 2) {
      return _invoices.where((i) => i.status == 'Paid').toList();
    }
    return _invoices;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;

    return Scaffold(
      backgroundColor: HireIQTheme.surfaceWhite,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        title: Text(
          'Invoices',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Summary strip
          Container(
            padding: const EdgeInsets.all(16),
            color: HireIQTheme.primaryTeal.withValues(alpha: 0.06),
            child: Row(
              children: [
                const Icon(Icons.receipt_long_outlined,
                    color: HireIQTheme.primaryTeal, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Total paid in 2026:',
                  style: GoogleFonts.inter(
                    color: HireIQTheme.textMuted,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text(
                  'R67,470.00',
                  style: GoogleFonts.inter(
                    color: HireIQTheme.primaryTeal,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // Tab row
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                _buildTab('All', 0),
                const SizedBox(width: 24),
                _buildTab('Pending', 1),
                const SizedBox(width: 24),
                _buildTab('Paid', 2),
              ],
            ),
          ),

          // Invoice list
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.receipt_long,
                            color: HireIQTheme.textLight, size: 48),
                        const SizedBox(height: 12),
                        Text(
                          'No invoices found',
                          style: GoogleFonts.inter(
                            color: HireIQTheme.textMuted,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 4),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) =>
                        _InvoiceCard(invoice: filtered[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final isActive = _tabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _tabIndex = index),
      child: Container(
        padding: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color:
                  isActive ? HireIQTheme.primaryTeal : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isActive
                ? HireIQTheme.primaryTeal
                : HireIQTheme.textMuted,
            fontWeight:
                isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _InvoiceCard extends StatelessWidget {
  final _Invoice invoice;

  const _InvoiceCard({required this.invoice});

  @override
  Widget build(BuildContext context) {
    final isPaid = invoice.status == 'Paid';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invoice.number,
                      style: GoogleFonts.inter(
                        color: HireIQTheme.textMuted,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      invoice.description,
                      style: GoogleFonts.inter(
                        color: HireIQTheme.primaryNavy,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      invoice.date,
                      style: GoogleFonts.inter(
                        color: HireIQTheme.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isPaid
                          ? HireIQTheme.success.withValues(alpha: 0.1)
                          : HireIQTheme.amber.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                          HireIQTheme.radiusFull),
                    ),
                    child: Text(
                      invoice.status,
                      style: GoogleFonts.inter(
                        color: isPaid
                            ? HireIQTheme.success
                            : HireIQTheme.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    invoice.amount,
                    style: GoogleFonts.inter(
                      color: HireIQTheme.primaryNavy,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {},
            icon: const Icon(Icons.download_outlined,
                size: 14, color: HireIQTheme.primaryTeal),
            label: Text(
              'Download PDF',
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryTeal,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
