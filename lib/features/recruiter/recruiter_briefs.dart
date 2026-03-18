import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class RecruiterBriefs extends StatelessWidget {
  const RecruiterBriefs({super.key});

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
              'Active Briefs',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildBriefCard(
                  title: 'Senior Frontend Developer',
                  company: 'TechFlow Solutions',
                  candidates: 12,
                  matchRate: 85,
                  priority: 'High',
                ),
                _buildBriefCard(
                  title: 'Product Designer (Contract)',
                  company: 'Creative Labs',
                  candidates: 4,
                  matchRate: 72,
                  priority: 'Medium',
                ),
                _buildBriefCard(
                  title: 'Data Engineer',
                  company: 'DataScale Inc.',
                  candidates: 8,
                  matchRate: 91,
                  priority: 'High',
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBriefCard({
    required String title,
    required String company,
    required int candidates,
    required int matchRate,
    required String priority,
  }) {
    final bool isHighPriority = priority == 'High';
    final Color priorityColor =
        isHighPriority ? HireIQTheme.error : const Color(0xFFF59E0B);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: priorityColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  priority,
                  style: GoogleFonts.inter(
                    color: priorityColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.more_horiz, color: HireIQTheme.textMuted),
            ],
          ),
          const SizedBox(height: 12),
          Text(title,
              style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.textPrimary)),
          const SizedBox(height: 2),
          Text(company,
              style: GoogleFonts.inter(
                  fontSize: 13, color: HireIQTheme.textMuted)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStat('Matched', candidates.toString()),
              _buildStat('Match IQ', '$matchRate%'),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        HireIQTheme.primaryTeal,
                        Color(0xFF0A7A70),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                  child: Text(
                    'View Match',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 11, color: HireIQTheme.textMuted)),
        const SizedBox(height: 2),
        Text(value,
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.textPrimary)),
      ],
    );
  }
}
