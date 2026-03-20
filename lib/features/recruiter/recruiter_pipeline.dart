import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/empty_state.dart';

class RecruiterPipeline extends ConsumerStatefulWidget {
  const RecruiterPipeline({super.key});

  @override
  ConsumerState<RecruiterPipeline> createState() => _RecruiterPipelineState();
}

class _RecruiterPipelineState extends ConsumerState<RecruiterPipeline>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  static const _stages = ['Applied', 'Shortlisted', 'Interviewing', 'Offer'];

  static const _candidates = [
    _PipelineCandidate(name: 'Thabo Nkosi', client: 'TechFlow Solutions', role: 'Flutter Dev', match: 94, stage: 'Applied', location: 'Joburg'),
    _PipelineCandidate(name: 'Priya Naicker', client: 'TechFlow Solutions', role: 'Flutter Dev', match: 88, stage: 'Applied', location: 'Durban'),
    _PipelineCandidate(name: 'Craig Botha', client: 'OUTsurance', role: 'DevOps Eng.', match: 85, stage: 'Shortlisted', location: 'Cape Town'),
    _PipelineCandidate(name: 'Ayanda Khumalo', client: 'OUTsurance', role: 'DevOps Eng.', match: 89, stage: 'Interviewing', location: 'Joburg'),
    _PipelineCandidate(name: 'Sipho van Rooyen', client: 'Shoprite', role: 'Data Scientist', match: 92, stage: 'Offer', location: 'Cape Town'),
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
            title: Text('My Pipeline',
                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            bottom: TabBar(
              controller: _tabs,
              isScrollable: true,
              labelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700),
              unselectedLabelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withValues(alpha: 0.5),
              indicatorColor: HireIQTheme.amber,
              indicatorWeight: 3,
              tabs: _stages.map((s) {
                final count = _candidates.where((c) => c.stage == s).length;
                return Tab(
                  child: Row(
                    children: [
                      Text(s),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                        ),
                        child: Text('$count', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
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
            final filtered = _candidates.where((c) => c.stage == stage).toList();
            if (filtered.isEmpty) {
              return const EmptyState(
                icon: Icons.people_outline_rounded,
                heading: 'No candidates here',
                body: 'Submit candidates from your CV Vault to fill this stage.',
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final c = filtered[i];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: HireIQTheme.surfaceWhite,
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                    border: Border.all(color: HireIQTheme.borderLight),
                    boxShadow: [BoxShadow(color: HireIQTheme.primaryNavy.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 3))],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                        child: Text(c.name.split(' ').map((w) => w[0]).take(2).join(),
                            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(c.name, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                            Text('${c.client} — ${c.role}', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 11, color: HireIQTheme.textMuted),
                                const SizedBox(width: 3),
                                Text(c.location, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                            ),
                            child: Text('${c.match}%',
                                style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
                          ),
                          const SizedBox(height: 6),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: HireIQTheme.textMuted),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _PipelineCandidate {
  const _PipelineCandidate({required this.name, required this.client, required this.role, required this.match, required this.stage, required this.location});
  final String name;
  final String client;
  final String role;
  final int match;
  final String stage;
  final String location;
}
