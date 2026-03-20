import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/empty_state.dart';

class EmployerCandidatePipeline extends ConsumerStatefulWidget {
  const EmployerCandidatePipeline({super.key});

  @override
  ConsumerState<EmployerCandidatePipeline> createState() =>
      _EmployerCandidatePipelineState();
}

class _EmployerCandidatePipelineState
    extends ConsumerState<EmployerCandidatePipeline>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  static const _stages = ['Applied', 'Shortlisted', 'Interviewing', 'Offer'];

  static const _candidates = [
    _Candidate(
      name: 'Thabo Nkosi',
      role: 'Senior Flutter Developer',
      matchScore: 91,
      stage: 'Applied',
      appliedDate: '18 Mar 2026',
      location: 'Johannesburg',
    ),
    _Candidate(
      name: 'Nomsa Dlamini',
      role: 'Senior Flutter Developer',
      matchScore: 87,
      stage: 'Applied',
      appliedDate: '19 Mar 2026',
      location: 'Cape Town',
    ),
    _Candidate(
      name: 'Craig Botha',
      role: 'Senior Flutter Developer',
      matchScore: 84,
      stage: 'Shortlisted',
      appliedDate: '15 Mar 2026',
      location: 'Pretoria',
    ),
    _Candidate(
      name: 'Zanele Mokoena',
      role: 'Senior Flutter Developer',
      matchScore: 79,
      stage: 'Shortlisted',
      appliedDate: '14 Mar 2026',
      location: 'Durban',
    ),
    _Candidate(
      name: 'Sipho van Rooyen',
      role: 'Senior Flutter Developer',
      matchScore: 92,
      stage: 'Interviewing',
      appliedDate: '10 Mar 2026',
      location: 'Cape Town',
    ),
    _Candidate(
      name: 'Ayanda Khumalo',
      role: 'Senior Flutter Developer',
      matchScore: 88,
      stage: 'Offer',
      appliedDate: '5 Mar 2026',
      location: 'Johannesburg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: _stages.length, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
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
                icon: const Icon(Icons.tune_rounded,
                    size: 20, color: Colors.white),
                onPressed: () {},
              ),
            ],
            bottom: TabBar(
              controller: _tabs,
              isScrollable: true,
              labelStyle: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.w700),
              unselectedLabelStyle: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.w500),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withValues(alpha: 0.5),
              indicatorColor: HireIQTheme.amber,
              indicatorWeight: 3,
              tabs: _stages.map((s) {
                final count =
                    _candidates.where((c) => c.stage == s).length;
                return Tab(
                  child: Row(
                    children: [
                      Text(s),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusFull),
                        ),
                        child: Text(
                          '$count',
                          style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabs,
          children: _stages.map((stage) {
            final filtered =
                _candidates.where((c) => c.stage == stage).toList();
            if (filtered.isEmpty) {
              return const EmptyState(
                icon: Icons.people_outline_rounded,
                heading: 'No candidates in this stage',
                body:
                    'Move candidates through the pipeline to see them here.',
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) =>
                  _CandidatePipelineCard(candidate: filtered[i]),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _Candidate {
  const _Candidate({
    required this.name,
    required this.role,
    required this.matchScore,
    required this.stage,
    required this.appliedDate,
    required this.location,
  });

  final String name;
  final String role;
  final int matchScore;
  final String stage;
  final String appliedDate;
  final String location;
}

class _CandidatePipelineCard extends StatelessWidget {
  const _CandidatePipelineCard({required this.candidate});
  final _Candidate candidate;

  @override
  Widget build(BuildContext context) {
    final c = candidate;
    return Container(
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
                radius: 22,
                backgroundColor:
                    HireIQTheme.primaryTeal.withValues(alpha: 0.12),
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
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 12, color: HireIQTheme.textMuted),
                        const SizedBox(width: 2),
                        Text(
                          c.location,
                          style: GoogleFonts.inter(
                              fontSize: 12, color: HireIQTheme.textMuted),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.calendar_today_outlined,
                            size: 12, color: HireIQTheme.textMuted),
                        const SizedBox(width: 2),
                        Text(
                          c.appliedDate,
                          style: GoogleFonts.inter(
                              fontSize: 12, color: HireIQTheme.textMuted),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: HireIQTheme.borderLight),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ActionBtn(
                  label: 'View CV',
                  icon: Icons.description_outlined,
                  onTap: () {},
                  isPrimary: false,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ActionBtn(
                  label: 'Advance',
                  icon: Icons.arrow_forward_rounded,
                  onTap: () {},
                  isPrimary: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.isPrimary,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: isPrimary ? HireIQTheme.primaryNavy : HireIQTheme.background,
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
          border: Border.all(
            color:
                isPrimary ? HireIQTheme.primaryNavy : HireIQTheme.borderMedium,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 14,
              color: isPrimary ? Colors.white : HireIQTheme.textMuted,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isPrimary ? Colors.white : HireIQTheme.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
