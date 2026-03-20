import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class AdminEmployerManagement extends ConsumerStatefulWidget {
  const AdminEmployerManagement({super.key});

  @override
  ConsumerState<AdminEmployerManagement> createState() =>
      _AdminEmployerManagementState();
}

class _AdminEmployerManagementState
    extends ConsumerState<AdminEmployerManagement> {
  final _search = TextEditingController();
  String _query = '';
  String _planFilter = 'All';
  final _plans = ['All', 'Starter', 'Growth', 'Enterprise'];

  static const _employers = [
    _Employer(name: 'TechFlow Solutions', plan: 'Enterprise', jobs: 14, hires: 32, joined: '10 Jan 2026', verified: true),
    _Employer(name: 'OUTsurance', plan: 'Growth', jobs: 7, hires: 18, joined: '15 Feb 2026', verified: true),
    _Employer(name: 'Shoprite Holdings', plan: 'Enterprise', jobs: 21, hires: 55, joined: '05 Jan 2026', verified: false),
    _Employer(name: 'Capitec Bank', plan: 'Growth', jobs: 5, hires: 12, joined: '01 Mar 2026', verified: true),
    _Employer(name: 'Lesedi Consulting', plan: 'Starter', jobs: 1, hires: 2, joined: '18 Mar 2026', verified: false),
  ];

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<_Employer> get _filtered {
    return _employers.where((e) {
      final matchPlan = _planFilter == 'All' || e.plan == _planFilter;
      final matchQ = _query.isEmpty || e.name.toLowerCase().contains(_query.toLowerCase());
      return matchPlan && matchQ;
    }).toList();
  }

  Color _planColor(String plan) {
    switch (plan) {
      case 'Enterprise': return const Color(0xFF7C3AED);
      case 'Growth': return HireIQTheme.primaryTeal;
      case 'Starter': return HireIQTheme.primaryNavy;
      default: return HireIQTheme.textMuted;
    }
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
          Text('Employer Management', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
          Text('${_employers.length} total employers', style: GoogleFonts.inter(fontSize: 11, color: Colors.white.withValues(alpha: 0.6))),
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
                  hintText: 'Search employers…',
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
                      decoration: BoxDecoration(
                        color: active ? HireIQTheme.amber : Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                      ),
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
          final e = _filtered[i];
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
                Expanded(child: Text(e.name, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                  decoration: BoxDecoration(color: _planColor(e.plan).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
                  child: Text(e.plan, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: _planColor(e.plan))),
                ),
              ]),
              const SizedBox(height: 4),
              Row(children: [
                const Icon(Icons.calendar_today_outlined, size: 11, color: HireIQTheme.textMuted),
                const SizedBox(width: 4),
                Text('Joined ${e.joined}', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: (e.verified ? HireIQTheme.success : HireIQTheme.warning).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: Text(e.verified ? 'CIPC Verified' : 'CIPC Pending',
                      style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: e.verified ? HireIQTheme.success : HireIQTheme.warning)),
                ),
              ]),
              const SizedBox(height: 12),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              const SizedBox(height: 12),
              Row(children: [
                _Stat('Active Jobs', '${e.jobs}'),
                _Stat('Total Hires', '${e.hires}'),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.borderLight), padding: const EdgeInsets.symmetric(vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))),
                  child: Text('View Jobs', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)),
                )),
                const SizedBox(width: 8),
                Expanded(child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.primaryTeal), padding: const EdgeInsets.symmetric(vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))),
                  child: Text('Verify CIPC', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.primaryTeal)),
                )),
                const SizedBox(width: 8),
                Expanded(child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.error), padding: const EdgeInsets.symmetric(vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))),
                  child: Text('Suspend', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.error)),
                )),
              ]),
            ]),
          );
        },
      ),
    );
  }
}

class _Employer {
  const _Employer({required this.name, required this.plan, required this.jobs, required this.hires, required this.joined, required this.verified});
  final String name, plan, joined;
  final int jobs, hires;
  final bool verified;
}

Widget _Stat(String label, String value) {
  return Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(value, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
    Text(label, style: GoogleFonts.inter(fontSize: 10, color: HireIQTheme.textMuted)),
  ]));
}
