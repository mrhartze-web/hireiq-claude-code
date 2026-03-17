import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';
import '../../shared/components/candidate_card.dart';

class EmployerCandidates extends StatelessWidget {
  const EmployerCandidates({super.key});

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
              'Candidate Pool',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list, color: Colors.white),
                onPressed: () => context.push('/employer/candidate-search'),
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
                    'Top MatchIQ Fits',
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Candidates sorted by their relevance to your active briefs.',
                    style: GoogleFonts.inter(color: HireIQTheme.textMuted),
                  ),
                  const SizedBox(height: 24),
                  CandidateCard(
                    name: 'Alex T.',
                    role: 'Backend Developer',
                    matchIqScore: 94,
                    onActionPressed: () {},
                  ),
                  CandidateCard(
                    name: 'Samantha J.',
                    role: 'Flutter Developer',
                    matchIqScore: 89,
                    onActionPressed: () {},
                  ),
                  CandidateCard(
                    name: 'Michael B.',
                    role: 'Tech Lead',
                    matchIqScore: 85,
                    onActionPressed: () {},
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
}
