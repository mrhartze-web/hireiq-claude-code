import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerBilling extends StatelessWidget {
  const EmployerBilling({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Billing & Invoices',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          HireIQTheme.primaryNavy,
                          Color(0xFF243659),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusXl),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Outstanding Balance',
                          style: GoogleFonts.inter(
                              color: Colors.white70, fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'R 0.00',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            height: 46,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  HireIQTheme.primaryTeal,
                                  Color(0xFF0A7A70),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                  HireIQTheme.radiusMd),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Make a Payment',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Payment Methods',
                    style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusMd),
                      border:
                          Border.all(color: HireIQTheme.borderLight),
                      boxShadow: [
                        BoxShadow(
                          color: HireIQTheme.primaryNavy
                              .withValues(alpha: 0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.credit_card,
                          color: HireIQTheme.primaryNavy),
                      title: Text(
                        'Visa ending in 4242',
                        style: GoogleFonts.inter(
                            color: HireIQTheme.primaryNavy,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        'Default payment method',
                        style: GoogleFonts.inter(
                            color: HireIQTheme.textMuted, fontSize: 13),
                      ),
                      trailing: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: HireIQTheme.primaryTeal
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                                HireIQTheme.radiusSm),
                          ),
                          child: Text(
                            'Edit',
                            style: GoogleFonts.inter(
                                color: HireIQTheme.primaryTeal,
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Recent Invoices',
                    style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 16),
                  _buildInvoiceRow('INV-2023-142', 'Oct 01, 2023',
                      'R 12,500.00', true),
                  _buildInvoiceRow('INV-2023-108', 'Sep 01, 2023',
                      'R 8,200.00', true),
                  _buildInvoiceRow('INV-2023-094', 'Aug 01, 2023',
                      'R 15,000.00', true),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceRow(
      String id, String date, String amount, bool isPaid) {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                id,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: HireIQTheme.primaryNavy),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: GoogleFonts.inter(
                    color: HireIQTheme.textMuted, fontSize: 13),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: HireIQTheme.primaryNavy),
              ),
              const SizedBox(height: 4),
              Text(
                isPaid ? 'Paid' : 'Pending',
                style: GoogleFonts.inter(
                    color: isPaid
                        ? HireIQTheme.primaryTeal
                        : const Color(0xFFF59E0B),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
