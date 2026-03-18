import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class RecruiterShortlist extends StatelessWidget {
  const RecruiterShortlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Candidate Shortlist',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildCandidateCard(
            name: 'Thabo Nkosi',
            experience: '5 yrs exp',
            matchIq: '94',
            wildcardIq: '847',
          ),
          _buildCandidateCard(
            name: 'Sipho Khumalo',
            experience: '8 yrs exp',
            matchIq: '89',
            wildcardIq: '912',
          ),
          _buildCandidateCard(
            name: 'Naledi Mokoena',
            experience: '6 yrs exp',
            matchIq: '91',
            wildcardIq: '885',
          ),
          const SizedBox(height: 20),
          _buildInfoFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Head of Engineering — FinCorp SA',
          style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.primaryNavy),
        ),
        const SizedBox(height: 6),
        Text(
          '6 shortlisted candidates',
          style: GoogleFonts.inter(
              fontSize: 14, color: HireIQTheme.textMuted),
        ),
      ],
    );
  }

  Widget _buildCandidateCard({
    required String name,
    required String experience,
    required String matchIq,
    required String wildcardIq,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor:
                    HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                child: Text(
                  name[0],
                  style: GoogleFonts.inter(
                      color: HireIQTheme.primaryTeal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: HireIQTheme.primaryNavy),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      experience,
                      style: GoogleFonts.inter(
                          fontSize: 13, color: HireIQTheme.textMuted),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                  border: Border.all(
                      color:
                          HireIQTheme.primaryTeal.withValues(alpha: 0.3)),
                ),
                child: Text(
                  'MatchIQ $matchIq',
                  style: GoogleFonts.inter(
                      color: HireIQTheme.primaryTeal,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ],
          ),
          const Divider(height: 28, color: HireIQTheme.borderLight),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome,
                      color: HireIQTheme.primaryNavy, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'WildcardIQ: $wildcardIq',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: HireIQTheme.primaryNavy),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'View Profile',
                  style: GoogleFonts.inter(
                      color: HireIQTheme.primaryTeal,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.primaryTeal.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
            color: HireIQTheme.primaryTeal.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline,
                  color: HireIQTheme.primaryTeal, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Placement fee on hire: R14,250–R18,000',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy,
                      fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '(15% of first-year salary). 90-day guarantee included.',
            style: GoogleFonts.inter(
                fontSize: 12, color: HireIQTheme.textMuted, height: 1.4),
          ),
        ],
      ),
    );
  }
}
