import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateNotificationsWeb extends ConsumerStatefulWidget {
  const CandidateNotificationsWeb({super.key});
  @override
  ConsumerState<CandidateNotificationsWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateNotificationsWeb> with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _filters = ['All', 'Jobs', 'Applications', 'System'];
  final Set<int> _read = {};

  static const _notifs = [
    _Notif(0, 'New match found!', 'Senior Flutter Developer at TechFlow Solutions — 94% MatchIQ', '2h ago', Icons.auto_awesome_rounded, HireIQTheme.primaryTeal, 'Jobs'),
    _Notif(1, 'Application viewed', 'Capitec Bank reviewed your application for Lead Engineer', '5h ago', Icons.visibility_outlined, HireIQTheme.info, 'Applications'),
    _Notif(2, 'Shortlisted!', 'You\'ve been shortlisted at OUTsurance for React Native Developer', '1d ago', Icons.star_rounded, HireIQTheme.amber, 'Applications'),
    _Notif(3, 'New message', 'Nomvula Dlamini from AgentFlow sent you a message', '1d ago', Icons.message_outlined, HireIQTheme.primaryNavy, 'Jobs'),
    _Notif(4, 'Profile tip', 'Add 2 more skills to improve your MatchIQ score by 5%', '2d ago', Icons.lightbulb_outline_rounded, HireIQTheme.warning, 'System'),
    _Notif(5, 'Interview scheduled', 'Standard Bank confirmed your interview for 25 Mar 2026', '3d ago', Icons.event_rounded, HireIQTheme.success, 'Applications'),
    _Notif(6, 'Subscription renewal', 'Your Pro plan renews on 01 Apr 2026 — R299', '4d ago', Icons.credit_card_outlined, HireIQTheme.textMuted, 'System'),
  ];

  @override
  void initState() { super.initState(); _tabs = TabController(length: _filters.length, vsync: this); }
  @override
  void dispose() { _tabs.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Notifications', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('Stay up to date with your job search', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            TextButton.icon(onPressed: () => setState(() => _read.addAll(_notifs.map((n) => n.id))), icon: const Icon(Icons.done_all_rounded, size: 16, color: HireIQTheme.primaryTeal), label: Text('Mark all read', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.primaryTeal, fontWeight: FontWeight.w600))),
          ]),
          const SizedBox(height: 24),
          Container(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: HireIQTheme.borderLight))),
            child: TabBar(
              controller: _tabs, isScrollable: true, tabAlignment: TabAlignment.start,
              labelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700),
              unselectedLabelStyle: GoogleFonts.inter(fontSize: 13),
              labelColor: HireIQTheme.primaryNavy, unselectedLabelColor: HireIQTheme.textMuted,
              indicatorColor: HireIQTheme.primaryTeal, indicatorWeight: 2,
              tabs: _filters.map((f) => Tab(text: f)).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: TabBarView(
              controller: _tabs,
              children: _filters.map((filter) {
                final items = filter == 'All' ? _notifs : _notifs.where((n) => n.category == filter).toList();
                return Column(mainAxisSize: MainAxisSize.min, children: items.asMap().entries.map((e) {
                  final n = e.value;
                  final isRead = _read.contains(n.id);
                  final isLast = e.key == items.length - 1;
                  return Column(children: [
                    Container(
                      color: isRead ? null : n.color.withValues(alpha: 0.02),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(children: [
                          Container(width: 44, height: 44, decoration: BoxDecoration(color: n.color.withValues(alpha: 0.1), shape: BoxShape.circle), child: Icon(n.icon, size: 20, color: n.color)),
                          const SizedBox(width: 16),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(children: [
                              Text(n.title, style: GoogleFonts.inter(fontSize: 14, fontWeight: isRead ? FontWeight.w500 : FontWeight.w700, color: HireIQTheme.textPrimary)),
                              if (!isRead) Container(margin: const EdgeInsets.only(left: 8), width: 6, height: 6, decoration: const BoxDecoration(color: HireIQTheme.primaryTeal, shape: BoxShape.circle)),
                            ]),
                            Text(n.body, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)),
                          ])),
                          const SizedBox(width: 16),
                          Text(n.time, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                          const SizedBox(width: 12),
                          if (!isRead) TextButton(onPressed: () => setState(() => _read.add(n.id)), child: Text('Read', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.primaryTeal))),
                        ]),
                      ),
                    ),
                    if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                  ]);
                }).toList());
              }).toList(),
            ),
          ),
        ]),
      ),
    );
  }
}

class _Notif {
  const _Notif(this.id, this.title, this.body, this.time, this.icon, this.color, this.category);
  final int id;
  final String title, body, time, category;
  final IconData icon;
  final Color color;
}
