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

class _State extends ConsumerState<CandidateNotificationsWeb>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  static const _labels = ['All', 'Jobs', 'Applications', 'Messages', 'System'];

  static const _notifs = [
    _Notif(Icons.work_rounded, HireIQTheme.primaryTeal, 'New job match', 'Senior Flutter Developer at TechFlow Solutions — 94% match!', '2 min ago', true, 'Jobs', 'Today'),
    _Notif(Icons.check_circle_rounded, HireIQTheme.success, 'Application update', 'Capitec Bank has shortlisted your application for Lead Mobile Engineer.', '1 hour ago', true, 'Applications', 'Today'),
    _Notif(Icons.message_rounded, HireIQTheme.info, 'New message', 'Sarah M. from TechFlow Solutions sent you a message.', '2 hours ago', true, 'Messages', 'Today'),
    _Notif(Icons.auto_awesome_rounded, HireIQTheme.primaryTeal, 'MatchIQ updated', 'Your MatchIQ score increased to 87% after completing your profile.', '5 hours ago', false, 'System', 'Today'),
    _Notif(Icons.work_rounded, HireIQTheme.primaryNavy, 'Job closing soon', 'Software Engineer at Standard Bank closes in 2 days. Apply now.', 'Yesterday', false, 'Jobs', 'Yesterday'),
    _Notif(Icons.verified_rounded, HireIQTheme.success, 'PassportIQ verified', 'Your identity has been successfully verified via PassportIQ.', 'Yesterday', false, 'System', 'Yesterday'),
    _Notif(Icons.send_rounded, HireIQTheme.primaryTeal, 'Application sent', 'Your application to OUTsurance has been submitted successfully.', '3 days ago', false, 'Applications', 'This week'),
  ];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: _labels.length, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groups = <String, List<_Notif>>{};
    for (final n in _notifs) {
      groups.putIfAbsent(n.group, () => []).add(n);
    }

    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Notifications', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('Stay updated on your applications and opportunities', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            TextButton.icon(onPressed: () {}, icon: const Icon(Icons.done_all_rounded, size: 16), label: Text('Mark all read', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)), style: TextButton.styleFrom(foregroundColor: HireIQTheme.primaryTeal)),
          ]),
          const SizedBox(height: 20),
          TabBar(controller: _tab, labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13), unselectedLabelStyle: GoogleFonts.inter(fontSize: 13), labelColor: HireIQTheme.primaryNavy, unselectedLabelColor: HireIQTheme.textMuted, indicatorColor: HireIQTheme.primaryTeal, tabs: _labels.map((l) => Tab(text: l)).toList()),
          const SizedBox(height: 20),
          ...groups.entries.map((g) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(padding: const EdgeInsets.only(bottom: 10), child: Text(g.key, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted, letterSpacing: 0.5))),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(children: g.value.asMap().entries.map((e) {
                final n = e.value;
                final isLast = e.key == g.value.length - 1;
                return Column(children: [
                  Container(
                    color: n.unread ? n.color.withValues(alpha: 0.03) : null,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    child: Row(children: [
                      Container(width: 38, height: 38, decoration: BoxDecoration(color: n.color.withValues(alpha: 0.1), shape: BoxShape.circle), child: Icon(n.icon, color: n.color, size: 18)),
                      const SizedBox(width: 14),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Text(n.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: n.unread ? FontWeight.w700 : FontWeight.w600, color: HireIQTheme.textPrimary)),
                          if (n.unread) Container(margin: const EdgeInsets.only(left: 8), width: 7, height: 7, decoration: BoxDecoration(color: n.color, shape: BoxShape.circle)),
                        ]),
                        Text(n.body, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.4)),
                      ])),
                      Text(n.time, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                    ]),
                  ),
                  if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                ]);
              }).toList()),
            ),
          ])),
        ]),
      ),
    );
  }
}

class _Notif {
  const _Notif(this.icon, this.color, this.title, this.body, this.time, this.unread, this.category, this.group);
  final IconData icon;
  final Color color;
  final String title, body, time, category, group;
  final bool unread;
}
