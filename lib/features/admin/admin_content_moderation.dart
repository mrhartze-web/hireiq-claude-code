import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class AdminContentModeration extends ConsumerStatefulWidget {
  const AdminContentModeration({super.key});

  @override
  ConsumerState<AdminContentModeration> createState() =>
      _AdminContentModerationState();
}

class _AdminContentModerationState extends ConsumerState<AdminContentModeration>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final Set<int> _selected = {};

  static const _stages = ['Flagged', 'Under Review', 'Resolved'];

  static const _items = [
    _ModerationItem(id: 0, type: 'Job Listing', title: 'Senior Dev — no salary disclosed', reason: 'Missing required salary info', flaggedBy: 'System', date: '19 Mar 2026', shieldScore: 92, tab: 'Flagged'),
    _ModerationItem(id: 1, type: 'Profile', title: 'Candidate: J. Van der Berg', reason: 'Suspected fake credentials', flaggedBy: 'User', date: '18 Mar 2026', shieldScore: 87, tab: 'Flagged'),
    _ModerationItem(id: 2, type: 'Message', title: 'Unsolicited contact attempt', reason: 'Harassment / spam', flaggedBy: 'User', date: '17 Mar 2026', shieldScore: 95, tab: 'Under Review'),
    _ModerationItem(id: 3, type: 'Report', title: 'Recruiter fee misrepresentation', reason: 'Misleading fee claim', flaggedBy: 'System', date: '15 Mar 2026', shieldScore: 78, tab: 'Resolved'),
  ];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: _stages.length, vsync: this);
    _tabs.addListener(() => setState(() => _selected.clear()));
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'Job Listing': return HireIQTheme.primaryNavy;
      case 'Profile': return HireIQTheme.primaryTeal;
      case 'Message': return HireIQTheme.warning;
      case 'Report': return HireIQTheme.error;
      default: return HireIQTheme.textMuted;
    }
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
            title: Text('Content Moderation', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(88),
              child: Column(children: [
                // Stats row
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Row(children: [
                    _NavStat('Pending', '3', HireIQTheme.amber),
                    const SizedBox(width: 8),
                    _NavStat('Approved Today', '12', HireIQTheme.success),
                    const SizedBox(width: 8),
                    _NavStat('Removed Today', '2', HireIQTheme.error),
                  ]),
                ),
                TabBar(
                  controller: _tabs,
                  labelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700),
                  unselectedLabelStyle: GoogleFonts.inter(fontSize: 13),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white.withValues(alpha: 0.5),
                  indicatorColor: HireIQTheme.amber,
                  indicatorWeight: 3,
                  tabs: _stages.map((s) => Tab(text: s)).toList(),
                ),
              ]),
            ),
          ),
        ],
        body: Stack(children: [
          TabBarView(
            controller: _tabs,
            children: _stages.map((stage) {
              final items = _items.where((i) => i.tab == stage).toList();
              if (items.isEmpty) {
                return Center(child: Text('No items.', style: GoogleFonts.inter(color: HireIQTheme.textMuted)));
              }
              return ListView.separated(
                padding: EdgeInsets.fromLTRB(16, 16, 16, _selected.isNotEmpty ? 80 : 16),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final item = items[i];
                  final isSelected = _selected.contains(item.id);
                  return GestureDetector(
                    onLongPress: () => setState(() => isSelected ? _selected.remove(item.id) : _selected.add(item.id)),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected ? HireIQTheme.primaryTeal.withValues(alpha: 0.05) : HireIQTheme.surfaceWhite,
                        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                        border: Border.all(color: isSelected ? HireIQTheme.primaryTeal.withValues(alpha: 0.4) : HireIQTheme.borderLight),
                        boxShadow: [BoxShadow(color: HireIQTheme.primaryNavy.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: _typeColor(item.type).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
                            child: Text(item.type, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: _typeColor(item.type))),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
                            child: Row(children: [
                              const Icon(Icons.shield_rounded, size: 11, color: HireIQTheme.primaryTeal),
                              const SizedBox(width: 3),
                              Text('ShieldIQ ${item.shieldScore}%', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
                            ]),
                          ),
                        ]),
                        const SizedBox(height: 8),
                        Text(item.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                        const SizedBox(height: 2),
                        Text(item.reason, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                        const SizedBox(height: 8),
                        Row(children: [
                          const Icon(Icons.flag_outlined, size: 11, color: HireIQTheme.textMuted),
                          const SizedBox(width: 3),
                          Text('Flagged by: ${item.flaggedBy}', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                          const SizedBox(width: 10),
                          const Icon(Icons.calendar_today_outlined, size: 11, color: HireIQTheme.textMuted),
                          const SizedBox(width: 3),
                          Text(item.date, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                        ]),
                        const SizedBox(height: 12),
                        Row(children: [
                          Expanded(child: _ActionBtn('Approve', HireIQTheme.success, () {})),
                          const SizedBox(width: 6),
                          Expanded(child: _ActionBtn('Review', HireIQTheme.primaryTeal, () {})),
                          const SizedBox(width: 6),
                          Expanded(child: _ActionBtn('Remove', HireIQTheme.error, () {})),
                        ]),
                      ]),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          if (_selected.isNotEmpty)
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: HireIQTheme.primaryNavy,
                child: Row(children: [
                  Text('${_selected.length} selected', style: GoogleFonts.inter(fontSize: 13, color: Colors.white)),
                  const Spacer(),
                  TextButton(onPressed: () {}, child: Text('Approve All', style: GoogleFonts.inter(color: HireIQTheme.success, fontWeight: FontWeight.w700))),
                  TextButton(onPressed: () {}, child: Text('Remove All', style: GoogleFonts.inter(color: HireIQTheme.error, fontWeight: FontWeight.w700))),
                  TextButton(onPressed: () => setState(() => _selected.clear()), child: Text('Cancel', style: GoogleFonts.inter(color: Colors.white54))),
                ]),
              ),
            ),
        ]),
      ),
    );
  }
}

class _ModerationItem {
  const _ModerationItem({required this.id, required this.type, required this.title, required this.reason, required this.flaggedBy, required this.date, required this.shieldScore, required this.tab});
  final int id;
  final String type, title, reason, flaggedBy, date, tab;
  final int shieldScore;
}

Widget _NavStat(String label, String value, Color color) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)),
      child: Column(children: [
        Text(value, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
        Text(label, style: GoogleFonts.inter(fontSize: 9, color: Colors.white.withValues(alpha: 0.7))),
      ]),
    ),
  );
}

Widget _ActionBtn(String label, Color color, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: color.withValues(alpha: 0.4)), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)),
      child: Center(child: Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: color))),
    ),
  );
}
