import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';

class AdminContentModeration extends StatelessWidget {
  const AdminContentModeration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Content Moderation',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: HireIQTheme.surfaceWhite,
              child: TabBar(
                labelColor: HireIQTheme.primaryNavy,
                unselectedLabelColor: HireIQTheme.textMuted,
                indicatorColor: HireIQTheme.primaryTeal,
                indicatorWeight: 3,
                labelStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 14),
                unselectedLabelStyle: GoogleFonts.inter(fontSize: 14),
                tabs: const [
                  Tab(text: 'Flagged Job Posts'),
                  Tab(text: 'Flagged Profiles'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      _buildFlaggedItem(
                          'Apex Digital',
                          'Job Post: "Software Engineer (H1B Only)"',
                          'Flagged for discriminatory language',
                          '2h ago'),
                      _buildFlaggedItem(
                          'FinTech Startup',
                          'Job Post: "Earn R1m/day working from home!"',
                          'Flagged as potential spam/scam',
                          '4h ago'),
                    ],
                  ),
                  ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      _buildFlaggedItem(
                          'User: JohnDoe123',
                          'Profile Verification Failed',
                          'PassportIQ image check failed (blurry ID)',
                          'Yesterday'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlaggedItem(
      String entity, String itemContext, String reason, String time) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                entity,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: HireIQTheme.primaryNavy),
              ),
              Text(
                time,
                style: GoogleFonts.inter(
                    color: HireIQTheme.textMuted, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            itemContext,
            style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontWeight: FontWeight.w500,
                fontSize: 13),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: HireIQTheme.error.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: HireIQTheme.error, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    reason,
                    style: GoogleFonts.inter(
                        color: HireIQTheme.error, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    foregroundColor: HireIQTheme.textMuted),
                child: Text(
                  'Dismiss',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.error,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusMd)),
                ),
                child: Text(
                  'Take Action',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
