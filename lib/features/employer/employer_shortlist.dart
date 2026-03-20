import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/empty_state.dart';

class EmployerShortlist extends ConsumerStatefulWidget {
  const EmployerShortlist({super.key});

  @override
  ConsumerState<EmployerShortlist> createState() => _EmployerShortlistState();
}

class _EmployerShortlistState extends ConsumerState<EmployerShortlist> {
  String _selectedJob = 'All Jobs';
  final _jobs = [
    'All Jobs',
    'Senior Flutter Developer',
    'Data Scientist',
    'Product Manager'
  ];

  static const _shortlisted = [
    _ShortlistCandidate(
      name: 'Thabo Nkosi',
      role: 'Flutter Developer',
      matchScore: 91,
      location: 'Johannesburg',
      experience: '7 years',
      salary: 'R75k/month',
    ),
    _ShortlistCandidate(
      name: 'Nomsa Dlamini',
      role: 'Flutter Developer',
      matchScore: 87,
      location: 'Cape Town',
      experience: '5 years',
      salary: 'R65k/month',
    ),
    _ShortlistCandidate(
      name: 'Craig Botha',
      role: 'Flutter Developer',
      matchScore: 82,
      location: 'Pretoria',
      experience: '4 years',
      salary: 'R55k/month',
    ),
    _ShortlistCandidate(
      name: 'Zanele Mokoena',
      role: 'Flutter Developer',
      matchScore: 79,
      location: 'Durban',
      experience: '4 years',
      salary: 'R58k/month',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Shortlist',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Container(
                color: HireIQTheme.primaryNavy,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _jobs.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final job = _jobs[i];
                      final active = job == _selectedJob;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedJob = job),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: active
                                ? HireIQTheme.amber
                                : Colors.white.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(
                                HireIQTheme.radiusFull),
                          ),
                          child: Text(
                            job,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: active
                                  ? HireIQTheme.primaryNavy
                                  : Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          _shortlisted.isEmpty
              ? const SliverToBoxAdapter(
                  child: EmptyState(
                    icon: Icons.people_outline_rounded,
                    heading: 'No candidates shortlisted',
                    body:
                        'Shortlist candidates from your pipeline to compare them here.',
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _ShortlistCard(
                          candidate: _shortlisted[index]),
                      childCount: _shortlisted.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _ShortlistCandidate {
  const _ShortlistCandidate({
    required this.name,
    required this.role,
    required this.matchScore,
    required this.location,
    required this.experience,
    required this.salary,
  });

  final String name;
  final String role;
  final int matchScore;
  final String location;
  final String experience;
  final String salary;
}

class _ShortlistCard extends StatelessWidget {
  const _ShortlistCard({required this.candidate});
  final _ShortlistCandidate candidate;

  @override
  Widget build(BuildContext context) {
    final c = candidate;
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
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                child: Text(
                  c.name.split(' ').map((w) => w[0]).take(2).join(),
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: HireIQTheme.primaryTeal),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.name,
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: HireIQTheme.primaryNavy),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 12, color: HireIQTheme.textMuted),
                        const SizedBox(width: 3),
                        Text(
                          c.location,
                          style: GoogleFonts.inter(
                              fontSize: 12, color: HireIQTheme.textMuted),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.work_outline_rounded,
                            size: 12, color: HireIQTheme.textMuted),
                        const SizedBox(width: 3),
                        Text(
                          c.experience,
                          style: GoogleFonts.inter(
                              fontSize: 12, color: HireIQTheme.textMuted),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.auto_awesome_rounded,
                            size: 11, color: HireIQTheme.primaryTeal),
                        const SizedBox(width: 4),
                        Text(
                          '${c.matchScore}%',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: HireIQTheme.primaryTeal),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    c.salary,
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: HireIQTheme.borderLight),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: HireIQTheme.primaryNavy,
                    side: const BorderSide(color: HireIQTheme.borderMedium),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)),
                  ),
                  child: Text('View CV',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 12)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HireIQTheme.amber,
                    foregroundColor: HireIQTheme.primaryNavy,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)),
                  ),
                  child: Text('Make Offer',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12)),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded,
                    color: HireIQTheme.error, size: 20),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
