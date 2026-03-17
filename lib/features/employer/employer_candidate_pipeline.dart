import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerCandidatePipeline extends StatelessWidget {
  const EmployerCandidatePipeline({super.key});

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
              'Candidate Pipeline',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 120,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPipelineColumn('New', 3, [
                      _buildKanbanCard('John Doe', 'Senior Developer', 92),
                      _buildKanbanCard('Jane Smith', 'Frontend Dev', 88),
                      _buildKanbanCard(
                          'Alice Johnson', 'Fullstack Engineer', 85),
                    ]),
                    _buildPipelineColumn('Reviewed', 2, [
                      _buildKanbanCard('Bob Brown', 'UI/UX Designer', 90),
                      _buildKanbanCard(
                          'Charlie Davis', 'Project Manager', 78),
                    ]),
                    _buildPipelineColumn('Shortlisted', 1, [
                      _buildKanbanCard(
                          'David Evans', 'Backend Developer', 95),
                    ]),
                    _buildPipelineColumn('Interviewing', 2, [
                      _buildKanbanCard('Eva Green', 'Data Scientist', 91),
                      _buildKanbanCard(
                          'Frank White', 'DevOps Engineer', 89),
                    ]),
                    _buildPipelineColumn('Offered', 0, const []),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineColumn(
      String title, int count, List<Widget> cards) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: 16, horizontal: 20),
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: HireIQTheme.borderLight)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: HireIQTheme.primaryNavy),
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryNavy.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$count',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: HireIQTheme.primaryNavy),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: cards.isEmpty
                  ? [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            'No candidates\nin this stage',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                                color: HireIQTheme.textMuted,
                                height: 1.5),
                          ),
                        ),
                      )
                    ]
                  : cards,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKanbanCard(String name, String role, int matchIq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HireIQTheme.background,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor:
                    HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                child: Text(
                  name[0],
                  style: GoogleFonts.inter(
                      color: HireIQTheme.primaryTeal,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.primaryNavy),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            role,
            style: GoogleFonts.inter(
                color: HireIQTheme.textMuted, fontSize: 12),
          ),
          const SizedBox(height: 10),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
              borderRadius:
                  BorderRadius.circular(HireIQTheme.radiusSm),
            ),
            child: Text(
              '$matchIq% Match',
              style: GoogleFonts.inter(
                  color: HireIQTheme.primaryTeal,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
