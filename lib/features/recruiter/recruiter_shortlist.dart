import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class RecruiterShortlist extends ConsumerStatefulWidget {
  const RecruiterShortlist({super.key});

  @override
  ConsumerState<RecruiterShortlist> createState() => _RecruiterShortlistState();
}

class _RecruiterShortlistState extends ConsumerState<RecruiterShortlist> {
  String _briefFilter = 'All Briefs';
  final _briefOptions = ['All Briefs', 'Flutter Developer', 'Data Scientist'];

  static const _shortlisted = [
    _SCandidate(name: 'Thabo Nkosi', role: 'Flutter Developer', match: 94, brief: 'Flutter Developer', location: 'Joburg', salary: 'R75k'),
    _SCandidate(name: 'Priya Naicker', role: 'Flutter Developer', match: 88, brief: 'Flutter Developer', location: 'Durban', salary: 'R65k'),
    _SCandidate(name: 'Ayanda Khumalo', role: 'Data Scientist', match: 86, brief: 'Data Scientist', location: 'Joburg', salary: 'R68k'),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _briefFilter == 'All Briefs'
        ? _shortlisted
        : _shortlisted.where((c) => c.brief == _briefFilter).toList();

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('My Shortlist',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Container(
            color: HireIQTheme.primaryNavy,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _briefOptions.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final option = _briefOptions[i];
                  final active = option == _briefFilter;
                  return GestureDetector(
                    onTap: () => setState(() => _briefFilter = option),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: active ? HireIQTheme.amber : Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                      ),
                      child: Text(option,
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: active ? HireIQTheme.primaryNavy : Colors.white)),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      body: filtered.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Text('No shortlisted candidates for this brief.'),
              ),
            )
          : ListView.separated(
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
                            Text(c.role, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                            const SizedBox(height: 4),
                            Row(children: [
                              const Icon(Icons.location_on_outlined, size: 11, color: HireIQTheme.textMuted),
                              const SizedBox(width: 2),
                              Text(c.location, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                              const SizedBox(width: 8),
                              const Icon(Icons.payments_outlined, size: 11, color: HireIQTheme.textMuted),
                              const SizedBox(width: 2),
                              Text(c.salary, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)),
                            ]),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
                            child: Row(children: [
                              const Icon(Icons.auto_awesome_rounded, size: 11, color: HireIQTheme.primaryTeal),
                              const SizedBox(width: 3),
                              Text('${c.match}%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
                            ]),
                          ),
                          const SizedBox(height: 8),
                          Row(children: [
                            IconButton(icon: const Icon(Icons.visibility_outlined, size: 16, color: HireIQTheme.textMuted), onPressed: (){}),
                            IconButton(icon: const Icon(Icons.send_rounded, size: 16, color: HireIQTheme.primaryTeal), onPressed: () {}),
                          ]),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class _SCandidate {
  const _SCandidate({required this.name, required this.role, required this.match, required this.brief, required this.location, required this.salary});
  final String name;
  final String role;
  final int match;
  final String brief;
  final String location;
  final String salary;
}
