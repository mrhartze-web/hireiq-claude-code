import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class RecruiterPipeline extends StatelessWidget {
  const RecruiterPipeline({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: HireIQTheme.background,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              pinned: true,
              backgroundColor: HireIQTheme.primaryNavy,
              foregroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                'Recruit Pipeline',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: HireIQTheme.primaryTeal,
                indicatorWeight: 3,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
                labelStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 14),
                unselectedLabelStyle:
                    GoogleFonts.inter(fontSize: 14),
                tabs: const [
                  Tab(text: 'Screening (15)'),
                  Tab(text: 'Interview (8)'),
                  Tab(text: 'Offer (3)'),
                  Tab(text: 'Hired (42)'),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _buildPipelineList(),
              _buildPipelineList(),
              _buildPipelineList(),
              _buildPipelineList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPipelineList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildCandidateTile('Sarah Jenkins', 'Senior Developer', '8 min ago'),
        _buildCandidateTile('Michael Chen', 'Product Manager', '2 hours ago'),
        _buildCandidateTile('Emma Wilson', 'UX Designer', 'Yesterday'),
        _buildCandidateTile('David Miller', 'Cloud Specialist', '2 days ago'),
      ],
    );
  }

  Widget _buildCandidateTile(String name, String role, String time) {
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
            backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
            child: Text(
              name[0],
              style: GoogleFonts.inter(
                  color: HireIQTheme.primaryTeal,
                  fontWeight: FontWeight.bold),
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
                        color: HireIQTheme.textPrimary)),
                const SizedBox(height: 2),
                Text(role,
                    style: GoogleFonts.inter(
                        fontSize: 13, color: HireIQTheme.textMuted)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(Icons.arrow_forward_ios,
                  size: 14, color: HireIQTheme.textMuted),
              const SizedBox(height: 4),
              Text(time,
                  style: GoogleFonts.inter(
                      fontSize: 10, color: HireIQTheme.textMuted)),
            ],
          ),
        ],
      ),
    );
  }
}
