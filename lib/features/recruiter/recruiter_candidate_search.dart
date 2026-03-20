import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/empty_state.dart';

class RecruiterCandidateSearch extends ConsumerStatefulWidget {
  const RecruiterCandidateSearch({super.key});

  @override
  ConsumerState<RecruiterCandidateSearch> createState() =>
      _RecruiterCandidateSearchState();
}

class _RecruiterCandidateSearchState
    extends ConsumerState<RecruiterCandidateSearch> {
  String _query = '';
  bool _hasSearched = false;

  static const _results = [
    _SearchCandidate(
      name: 'Thabo Nkosi',
      role: 'Flutter Developer',
      experience: '7 yrs',
      location: 'Johannesburg',
      salary: 'R75k',
      matchScore: 94,
      skills: ['Flutter', 'Dart', 'Firebase', 'Riverpod'],
    ),
    _SearchCandidate(
      name: 'Priya Naicker',
      role: 'Flutter Developer',
      experience: '5 yrs',
      location: 'Durban',
      salary: 'R65k',
      matchScore: 88,
      skills: ['Flutter', 'iOS', 'Swift', 'Firebase'],
    ),
    _SearchCandidate(
      name: 'Craig Botha',
      role: 'Senior Mobile Developer',
      experience: '9 yrs',
      location: 'Cape Town',
      salary: 'R90k',
      matchScore: 81,
      skills: ['Flutter', 'Kotlin', 'React Native', 'Figma'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Candidate Search',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // ── Search Bar ────────────────────────────────────────────────
          Container(
            color: HireIQTheme.primaryNavy,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (v) => setState(() => _query = v),
                    onSubmitted: (_) =>
                        setState(() => _hasSearched = _query.isNotEmpty),
                    style: GoogleFonts.inter(
                        fontSize: 14, color: HireIQTheme.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Search by skill, role, or name...',
                      hintStyle: GoogleFonts.inter(
                          color: HireIQTheme.textMuted, fontSize: 13),
                      prefixIcon: const Icon(Icons.search_rounded,
                          color: HireIQTheme.textMuted, size: 18),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => setState(() => _hasSearched = _query.isNotEmpty),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: HireIQTheme.amber,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusMd),
                    ),
                    child: const Icon(Icons.search_rounded,
                        color: HireIQTheme.primaryNavy, size: 22),
                  ),
                ),
              ],
            ),
          ),

          // ── MatchIQ Tag Chips ─────────────────────────────────────────
          Container(
            color: HireIQTheme.background,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  'Flutter', 'Cape Town', 'R50k–R80k', 'Remote', '5+ yrs'
                ].map((tag) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _query = tag;
                        _hasSearched = true;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: HireIQTheme.surfaceWhite,
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusFull),
                        border: Border.all(color: HireIQTheme.borderLight),
                      ),
                      child: Text(
                        tag,
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: HireIQTheme.primaryNavy),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // ── Results ───────────────────────────────────────────────────
          Expanded(
            child: !_hasSearched
                ? const EmptyState(
                    icon: Icons.manage_search_rounded,
                    heading: 'Search for candidates',
                    body:
                        'Use the search bar or tap a suggestion to find candidates in the HireIQ talent pool.',
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _results.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) =>
                        _CandidateSearchCard(candidate: _results[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _SearchCandidate {
  const _SearchCandidate({
    required this.name,
    required this.role,
    required this.experience,
    required this.location,
    required this.salary,
    required this.matchScore,
    required this.skills,
  });

  final String name;
  final String role;
  final String experience;
  final String location;
  final String salary;
  final int matchScore;
  final List<String> skills;
}

class _CandidateSearchCard extends StatelessWidget {
  const _CandidateSearchCard({required this.candidate});
  final _SearchCandidate candidate;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
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
                    Text(c.name,
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryNavy)),
                    Text(c.role,
                        style: GoogleFonts.inter(
                            fontSize: 12, color: HireIQTheme.textMuted)),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome_rounded,
                        size: 11, color: HireIQTheme.primaryTeal),
                    const SizedBox(width: 4),
                    Text('${c.matchScore}%',
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryTeal)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 12, color: HireIQTheme.textMuted),
              const SizedBox(width: 4),
              Text(c.location,
                  style: GoogleFonts.inter(
                      fontSize: 12, color: HireIQTheme.textMuted)),
              const SizedBox(width: 12),
              const Icon(Icons.work_outline_rounded,
                  size: 12, color: HireIQTheme.textMuted),
              const SizedBox(width: 4),
              Text(c.experience,
                  style: GoogleFonts.inter(
                      fontSize: 12, color: HireIQTheme.textMuted)),
              const SizedBox(width: 12),
              const Icon(Icons.payments_outlined,
                  size: 12, color: HireIQTheme.textMuted),
              const SizedBox(width: 4),
              Text(c.salary,
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.primaryNavy)),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: c.skills.map((skill) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryNavy.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(skill,
                    style: GoogleFonts.inter(
                        fontSize: 11,
                        color: HireIQTheme.primaryNavy,
                        fontWeight: FontWeight.w500)),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: HireIQTheme.borderLight),
          const SizedBox(height: 10),
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
                  child: Text('View Profile',
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
                  child: Text('Submit to Brief',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
