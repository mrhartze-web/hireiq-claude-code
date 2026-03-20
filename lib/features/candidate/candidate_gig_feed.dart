import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/skeleton_loader.dart';
import '../../shared/components/empty_state.dart';

class CandidateGigFeed extends ConsumerStatefulWidget {
  const CandidateGigFeed({super.key});

  @override
  ConsumerState<CandidateGigFeed> createState() => _CandidateGigFeedState();
}

class _CandidateGigFeedState extends ConsumerState<CandidateGigFeed> {
  String _selectedCategory = 'All';
  bool _isLoading = false;

  static const _categories = [
    'All', 'Development', 'Design', 'Data', 'Marketing', 'Writing'
  ];

  static const _gigs = [
    _Gig(
      title: 'React Native Developer',
      company: 'TechFlow Solutions',
      location: 'Remote (Cape Town)',
      budgetMin: 65000,
      budgetMax: 85000,
      duration: '3 months',
      skills: ['React Native', 'TypeScript', 'Firebase'],
      proposals: 8,
      matchScore: 92,
      category: 'Development',
      isNew: true,
    ),
    _Gig(
      title: 'Data Science Consultant',
      company: 'DataScale Africa',
      location: 'Johannesburg',
      budgetMin: 55000,
      budgetMax: 75000,
      duration: '2 months',
      skills: ['Python', 'ML', 'Tableau'],
      proposals: 14,
      matchScore: 78,
      category: 'Data',
      isNew: false,
    ),
    _Gig(
      title: 'UI/UX Product Designer',
      company: 'Apex Digital',
      location: 'Cape Town',
      budgetMin: 45000,
      budgetMax: 60000,
      duration: '6 weeks',
      skills: ['Figma', 'Design Systems', 'Prototyping'],
      proposals: 22,
      matchScore: 0,
      category: 'Design',
      isNew: true,
    ),
    _Gig(
      title: 'Backend API Engineer',
      company: 'FinCorp SA',
      location: 'Remote',
      budgetMin: 70000,
      budgetMax: 95000,
      duration: '4 months',
      skills: ['Node.js', 'PostgreSQL', 'AWS'],
      proposals: 6,
      matchScore: 88,
      category: 'Development',
      isNew: false,
    ),
  ];

  List<_Gig> get _filtered => _selectedCategory == 'All'
      ? _gigs
      : _gigs.where((g) => g.category == _selectedCategory).toList();

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
              'Gig Marketplace',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.tune_rounded,
                    size: 20, color: Colors.white),
                onPressed: () {},
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Container(
                color: HireIQTheme.primaryNavy,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final cat = _categories[i];
                      final active = cat == _selectedCategory;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedCategory = cat),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: active
                                ? HireIQTheme.amber
                                : Colors.white
                                    .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(
                                HireIQTheme.radiusFull),
                          ),
                          child: Text(
                            cat,
                            style: GoogleFonts.inter(
                              fontSize: 13,
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
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            sliver: _isLoading
                ? const SliverToBoxAdapter(child: SkeletonLoader(itemCount: 4))
                : _filtered.isEmpty
                    ? const SliverToBoxAdapter(
                        child: EmptyState(
                          icon: Icons.work_outline_rounded,
                          heading: 'No gigs in this category',
                          body:
                              'Try a different filter or check back soon for new postings.',
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) =>
                              _GigCard(gig: _filtered[index]),
                          childCount: _filtered.length,
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

class _Gig {
  const _Gig({
    required this.title,
    required this.company,
    required this.location,
    required this.budgetMin,
    required this.budgetMax,
    required this.duration,
    required this.skills,
    required this.proposals,
    required this.matchScore,
    required this.category,
    required this.isNew,
  });

  final String title;
  final String company;
  final String location;
  final int budgetMin;
  final int budgetMax;
  final String duration;
  final List<String> skills;
  final int proposals;
  final int matchScore;
  final String category;
  final bool isNew;
}

class _GigCard extends StatefulWidget {
  const _GigCard({required this.gig});
  final _Gig gig;

  @override
  State<_GigCard> createState() => _GigCardState();
}

class _GigCardState extends State<_GigCard> {
  bool _saved = false;

  String _fmt(int n) => 'R${(n ~/ 1000)}k';

  @override
  Widget build(BuildContext context) {
    final g = widget.gig;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
            children: [
              // Company avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryNavy.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusSm),
                ),
                child: Center(
                  child: Text(
                    g.company[0],
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: HireIQTheme.primaryNavy),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            g.title,
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: HireIQTheme.primaryNavy),
                          ),
                        ),
                        if (g.isNew)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: HireIQTheme.success
                                  .withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(
                                  HireIQTheme.radiusFull),
                            ),
                            child: Text(
                              'NEW',
                              style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: HireIQTheme.success),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${g.company} • ${g.location}',
                      style: GoogleFonts.inter(
                          fontSize: 12, color: HireIQTheme.textMuted),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _saved = !_saved),
                child: Icon(
                  _saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                  color: _saved
                      ? HireIQTheme.primaryTeal
                      : HireIQTheme.textMuted,
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Budget + duration
          Row(
            children: [
              const Icon(Icons.payments_outlined,
                  size: 14, color: HireIQTheme.textMuted),
              const SizedBox(width: 5),
              Text(
                '${_fmt(g.budgetMin)} – ${_fmt(g.budgetMax)}',
                style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: HireIQTheme.primaryNavy),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.access_time_rounded,
                  size: 14, color: HireIQTheme.textMuted),
              const SizedBox(width: 5),
              Text(
                g.duration,
                style: GoogleFonts.inter(
                    fontSize: 13, color: HireIQTheme.textMuted),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.people_outline_rounded,
                  size: 14, color: HireIQTheme.textMuted),
              const SizedBox(width: 5),
              Text(
                '${g.proposals} proposals',
                style: GoogleFonts.inter(
                    fontSize: 13, color: HireIQTheme.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Skills
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: g.skills.map((s) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryNavy.withValues(alpha: 0.05),
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  s,
                  style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.textSecondary),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: HireIQTheme.borderLight),
          const SizedBox(height: 12),

          // Actions
          Row(
            children: [
              if (g.matchScore > 0) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.auto_awesome_rounded,
                          size: 12, color: HireIQTheme.primaryTeal),
                      const SizedBox(width: 4),
                      Text(
                        '${g.matchScore}% Match',
                        style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryTeal),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ] else
                const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryTeal,
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                  child: Text(
                    'Quick Apply',
                    style: GoogleFonts.inter(
                        fontSize: 13,
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
}
