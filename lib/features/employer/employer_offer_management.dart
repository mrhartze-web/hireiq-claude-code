import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerOfferManagement extends StatelessWidget {
  const EmployerOfferManagement({super.key});

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
              'Offer Management',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active Offers',
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 16),
                  _buildOfferCard(
                    'Senior Backend Engineer',
                    'Alex T.',
                    'R900k/yr',
                    'Pending Candidate',
                    const Color(0xFFF59E0B),
                  ),
                  _buildOfferCard(
                    'Product Designer',
                    'Sarah M.',
                    'R750k/yr',
                    'Accepted',
                    HireIQTheme.primaryTeal,
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Draft Offers',
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.textMuted),
                  ),
                  const SizedBox(height: 16),
                  _buildOfferCard(
                    'Frontend Developer',
                    'Michael B.',
                    'R600k/yr',
                    'Draft',
                    HireIQTheme.textMuted,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard(String role, String candidate, String salary,
      String status, Color statusColor) {
    return GestureDetector(
      onTap: () {},
      child: Container(
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
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Candidate: $candidate',
                    style: GoogleFonts.inter(
                        fontSize: 13, color: HireIQTheme.textMuted),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Offer: $salary',
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        color: HireIQTheme.primaryNavy,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius:
                    BorderRadius.circular(HireIQTheme.radiusSm),
              ),
              child: Text(
                status,
                style: GoogleFonts.inter(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
