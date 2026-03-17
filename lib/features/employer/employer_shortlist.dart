import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/candidate_card.dart';

class EmployerShortlist extends StatelessWidget {
  const EmployerShortlist({super.key});

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
              'Saved & Shortlisted',
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
                  Text(
                    'Compare Shortlisted Candidates',
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select multiple candidates to enter comparison view.',
                    style:
                        GoogleFonts.inter(color: HireIQTheme.textMuted),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            HireIQTheme.primaryNavy,
                            Color(0xFF243659),
                          ],
                        ),
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.compare_arrows,
                              color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Compare Selected (0)',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CandidateCard(
                    name: 'Sarah M.',
                    role: 'Product Designer',
                    matchIqScore: 92,
                    onActionPressed: () {},
                  ),
                  CandidateCard(
                    name: 'James K.',
                    role: 'UX Researcher',
                    matchIqScore: 88,
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
