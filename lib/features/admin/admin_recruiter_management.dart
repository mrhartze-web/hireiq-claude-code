import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class AdminRecruiterManagement extends ConsumerStatefulWidget {
  const AdminRecruiterManagement({super.key});

  @override
  ConsumerState<AdminRecruiterManagement> createState() =>
      _AdminRecruiterManagementState();
}

class _AdminRecruiterManagementState
    extends ConsumerState<AdminRecruiterManagement> {
  final _search = TextEditingController();
  String _query = '';
  String _planFilter = 'All';
  final _plans = ['All', 'Solo', 'Agency'];

  static const _recruiters = [
    _Recruiter(name: 'Nomvula Dlamini', plan: 'Agency', briefs: 8, placements: 22, earnings: 'R287,000', joined: '15 Jan 2026', shieldStatus: 'Clean', teamSize: 5),
    _Recruiter(name: 'Zanele Mokoena', plan: 'Solo', briefs: 3, placements: 7, earnings: 'R91,500', joined: '01 Mar 2026', shieldStatus: 'Clean', teamSize: 0),
    _Recruiter(name: 'Thabo Nkosi', plan: 'Agency', briefs: 12, placements: 34, earnings: 'R441,000', joined: '10 Jan 2026', shieldStatus: 'Flagged', teamSize: 8),
    _Recruiter(name: 'Sipho van Rooyen', plan: 'Solo', briefs: 5, placements: 11, earnings: 'R143,000', joined: '20 Feb 2026', shieldStatus: 'Clean', teamSize: 0),
  ];

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<_Recruiter> get _filtered {
    return _recruiters.where((r) {
      final matchPlan = _planFilter == 'All' || r.plan == _planFilter;
      final matchQ = _query.isEmpty || r.name.toLowerCase().contains(_query.toLowerCase());
      return matchPlan && matchQ;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: false,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Recruiter Management', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
          Text('${_recruiters.length} total recruiters', style: GoogleFonts.inter(fontSize: 11, color: Colors.white.withValues(alpha: 0.6))),
        ]),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: TextField(
                controller: _search,
                onChanged: (v) => setState(() => _query = v),
                style: GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search recruiters…',
                  hintStyle: GoogleFonts.inter(color: HireIQTheme.textMuted, fontSize: 13),
                  prefixIcon: const Icon(Icons.search_rounded, color: HireIQTheme.textMuted, size: 18),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), borderSide: BorderSide.none),
                ),
              ),
            ),
            SizedBox(
              height: 36,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _plans.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final p = _plans[i];
                  final active = p == _planFilter;
                  return GestureDetector(
                    onTap: () => setState(() => _planFilter = p),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(color: active ? HireIQTheme.amber : Colors.white.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
                      child: Text(p, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: active ? HireIQTheme.primaryNavy : Colors.white)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
          ]),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _filtered.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final r = _filtered[i];
          final isClean = r.shieldStatus == 'Clean';
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: HireIQTheme.surfaceWhite,
              borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
              border: Border.all(color: HireIQTheme.borderLight),
              boxShadow: [BoxShadow(color: HireIQTheme.primaryNavy.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 2))],
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                  child: Text(r.name.split(' ').map((w) => w[0]).take(2).join(), style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal)),
                ),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(r.name, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  Row(children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
                      child: Text(r.plan, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
                    ),
                    if (r.teamSize > 0) ...[
                      const SizedBox(width: 6),
                      Text('Team: ${r.teamSize}', style: GoogleFonts.inter(fontSize: 10, color: HireIQTheme.textMuted)),
                    ],
                  ]),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: (isClean ? HireIQTheme.success : HireIQTheme.error).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
                  child: Row(children: [
                    Icon(Icons.shield_rounded, size: 11, color: isClean ? HireIQTheme.success : HireIQTheme.error),
                    const SizedBox(width: 3),
                    Text(r.shieldStatus, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: isClean ? HireIQTheme.success : HireIQTheme.error)),
                  ]),
                ),
              ]),
              const SizedBox(height: 12),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              const SizedBox(height: 12),
              Row(children: [
                _RecStat('Active Briefs', '${r.briefs}'),
                _RecStat('Placements', '${r.placements}'),
                _RecStat('Earnings', r.earnings),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.borderLight), padding: const EdgeInsets.symmetric(vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('View Placements', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)))),
                const SizedBox(width: 6),
                Expanded(child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.primaryTeal), padding: const EdgeInsets.symmetric(vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('View Earnings', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: HireIQTheme.primaryTeal)))),
                const SizedBox(width: 6),
                Expanded(child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.error), padding: const EdgeInsets.symmetric(vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Suspend', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: HireIQTheme.error)))),
              ]),
            ]),
          );
        },
      ),
    );
  }
}

class _Recruiter {
  const _Recruiter({required this.name, required this.plan, required this.briefs, required this.placements, required this.earnings, required this.joined, required this.shieldStatus, required this.teamSize});
  final String name, plan, earnings, joined, shieldStatus;
  final int briefs, placements, teamSize;
}

Widget _RecStat(String label, String value) {
  return Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(value, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
    Text(label, style: GoogleFonts.inter(fontSize: 10, color: HireIQTheme.textMuted)),
  ]));
}
