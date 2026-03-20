import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/empty_state.dart';

class RecruiterBriefs extends ConsumerStatefulWidget {
  const RecruiterBriefs({super.key});

  @override
  ConsumerState<RecruiterBriefs> createState() => _RecruiterBriefsState();
}

class _RecruiterBriefsState extends ConsumerState<RecruiterBriefs>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  String _search = '';

  static const _briefs = [
    _Brief(
      title: 'Senior Flutter Developer',
      client: 'TechFlow Solutions',
      location: 'Cape Town',
      salary: 'R60k – R80k',
      applicants: 47,
      status: 'Active',
      date: '5 days ago',
    ),
    _Brief(
      title: 'Data Scientist',
      client: 'Woolworths Financial Services',
      location: 'Johannesburg',
      salary: 'R55k – R70k',
      applicants: 23,
      status: 'Active',
      date: '12 days ago',
    ),
    _Brief(
      title: 'UX Designer',
      client: 'OUTsurance',
      location: 'Pretoria',
      salary: 'R45k – R60k',
      applicants: 18,
      status: 'Filled',
      date: '1 month ago',
    ),
    _Brief(
      title: 'DevOps Engineer',
      client: 'Shoprite Holdings',
      location: 'Cape Town',
      salary: 'R65k – R85k',
      applicants: 31,
      status: 'Filled',
      date: '2 months ago',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
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
              'My Briefs',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(112),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: TextField(
                      onChanged: (v) => setState(() => _search = v),
                      style: GoogleFonts.inter(
                          fontSize: 14, color: HireIQTheme.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Search briefs...',
                        hintStyle: GoogleFonts.inter(
                            color: HireIQTheme.textMuted, fontSize: 13),
                        prefixIcon: const Icon(Icons.search_rounded,
                            color: HireIQTheme.textMuted, size: 18),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusMd),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  TabBar(
                    controller: _tabs,
                    labelStyle: GoogleFonts.inter(
                        fontSize: 13, fontWeight: FontWeight.w700),
                    unselectedLabelStyle: GoogleFonts.inter(
                        fontSize: 13, fontWeight: FontWeight.w500),
                    labelColor: Colors.white,
                    unselectedLabelColor:
                        Colors.white.withValues(alpha: 0.5),
                    indicatorColor: HireIQTheme.amber,
                    indicatorWeight: 3,
                    tabs: const [
                      Tab(text: 'Active (2)'),
                      Tab(text: 'Filled (2)'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabs,
          children: [
            _buildList(_briefs.where((b) => b.status == 'Active').toList()),
            _buildList(_briefs.where((b) => b.status == 'Filled').toList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: HireIQTheme.amber,
        foregroundColor: HireIQTheme.primaryNavy,
        icon: const Icon(Icons.add),
        label: Text('New Brief',
            style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _buildList(List<_Brief> briefs) {
    final filtered = _search.isEmpty
        ? briefs
        : briefs
            .where((b) =>
                b.title.toLowerCase().contains(_search.toLowerCase()) ||
                b.client.toLowerCase().contains(_search.toLowerCase()))
            .toList();

    if (filtered.isEmpty) {
      return const EmptyState(
        icon: Icons.description_outlined,
        heading: 'No briefs found',
        body: 'Create a new brief or adjust your search query.',
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) => _BriefCard(brief: filtered[i]),
    );
  }
}

class _Brief {
  const _Brief({
    required this.title,
    required this.client,
    required this.location,
    required this.salary,
    required this.applicants,
    required this.status,
    required this.date,
  });

  final String title;
  final String client;
  final String location;
  final String salary;
  final int applicants;
  final String status;
  final String date;
}

class _BriefCard extends StatelessWidget {
  const _BriefCard({required this.brief});
  final _Brief brief;

  @override
  Widget build(BuildContext context) {
    final isFilled = brief.status == 'Filled';
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brief.title,
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: HireIQTheme.primaryNavy),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      brief.client,
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          color: HireIQTheme.primaryTeal,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (isFilled ? HireIQTheme.success : HireIQTheme.primaryTeal)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  brief.status,
                  style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isFilled ? HireIQTheme.success : HireIQTheme.primaryTeal),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _Chip(Icons.location_on_outlined, brief.location),
              _Chip(Icons.payments_outlined, brief.salary),
              _Chip(Icons.people_outline_rounded, '${brief.applicants} applicants'),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: HireIQTheme.borderLight),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(brief.date,
                  style: GoogleFonts.inter(
                      fontSize: 11, color: HireIQTheme.textMuted)),
              TextButton(
                onPressed: () {},
                child: Text(
                  isFilled ? 'View Results' : 'Manage',
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.primaryNavy),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _Chip(IconData icon, String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: HireIQTheme.primaryNavy.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: HireIQTheme.textMuted),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.inter(
              fontSize: 11,
              color: HireIQTheme.textMuted,
              fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
