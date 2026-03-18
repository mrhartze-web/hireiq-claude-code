import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';

class RecruiterCandidateSearch extends StatelessWidget {
  const RecruiterCandidateSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Source Talent',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
              child: TextField(
                style: GoogleFonts.inter(
                    fontSize: 14, color: HireIQTheme.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search skills, roles, or names...',
                  hintStyle: GoogleFonts.inter(
                      color: HireIQTheme.textMuted, fontSize: 14),
                  prefixIcon: const Icon(Icons.search,
                      color: HireIQTheme.primaryNavy),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.tune,
                          color: HireIQTheme.primaryTeal),
                      onPressed: () {}),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                    borderSide: const BorderSide(
                        color: HireIQTheme.primaryTeal, width: 1.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildQuickFilterRow(),
            const SizedBox(height: 24),
            Text(
              'Top Matches',
              style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 16),
            _buildCandidateResult('Alice Johnson', 'Senior Flutter Developer',
                94, 'Available Now'),
            _buildCandidateResult('Bob Smith', 'Backend Engineer (Go)', 88,
                'Employed, Open to Offers'),
            _buildCandidateResult(
                'Charlie Davis', 'UI/UX Designer', 85, 'Actively Looking'),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickFilterRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('Top MatchIQ', true),
          const SizedBox(width: 8),
          _buildFilterChip('Verified Only', false),
          const SizedBox(width: 8),
          _buildFilterChip('Remote', false),
          const SizedBox(width: 8),
          _buildFilterChip('Senior (5+ yrs)', false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? HireIQTheme.primaryNavy
            : HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
        border: Border.all(
            color: isSelected
                ? HireIQTheme.primaryNavy
                : HireIQTheme.borderLight),
        boxShadow: isSelected
            ? []
            : [
                BoxShadow(
                  color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: isSelected ? Colors.white : HireIQTheme.primaryNavy,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildCandidateResult(
      String name, String role, int score, String status) {
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
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
            child: Text(
              name[0],
              style: GoogleFonts.inter(
                  color: HireIQTheme.primaryTeal,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 2),
                Text(role,
                    style: GoogleFonts.inter(
                        color: HireIQTheme.textMuted, fontSize: 13)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.bolt,
                        color: HireIQTheme.primaryTeal, size: 16),
                    const SizedBox(width: 4),
                    Text('$score% Match',
                        style: GoogleFonts.inter(
                            color: HireIQTheme.primaryTeal,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Text(status,
                            style: GoogleFonts.inter(
                                color: HireIQTheme.textMuted, fontSize: 12),
                            overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.person_add_alt_1,
                color: HireIQTheme.primaryNavy),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
