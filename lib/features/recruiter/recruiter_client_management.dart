import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';

class RecruiterClientManagement extends StatelessWidget {
  const RecruiterClientManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'My Clients',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildClientCard('Apex Digital', 'Technology', 2),
          _buildClientCard('FinTech Startup', 'Finance', 1),
          _buildClientCard('Global Logistics Ltd', 'Logistics', 0),
        ],
      ),
    );
  }

  Widget _buildClientCard(String name, String industry, int activeRoles) {
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
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: HireIQTheme.primaryNavy.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
              border: Border.all(color: HireIQTheme.borderLight),
            ),
            child: const Icon(Icons.business, color: HireIQTheme.primaryTeal),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 2),
                Text(
                  industry,
                  style: GoogleFonts.inter(
                      color: HireIQTheme.textMuted, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.work_outline,
                      color: activeRoles > 0
                          ? HireIQTheme.primaryTeal
                          : HireIQTheme.textMuted,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$activeRoles Active Briefs',
                      style: GoogleFonts.inter(
                        color: activeRoles > 0
                            ? HireIQTheme.primaryTeal
                            : HireIQTheme.textMuted,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios,
              size: 14, color: HireIQTheme.textMuted),
        ],
      ),
    );
  }
}
