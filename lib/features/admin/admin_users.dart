import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class AdminUsers extends ConsumerStatefulWidget {
  const AdminUsers({super.key});

  @override
  ConsumerState<AdminUsers> createState() => _AdminUsersState();
}

class _AdminUsersState extends ConsumerState<AdminUsers>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _search = TextEditingController();
  String _query = '';

  static const _roles = ['All', 'Candidates', 'Employers', 'Recruiters', 'Admins'];

  static const _users = [
    _User(name: 'Thabo Nkosi', email: 'thabo@email.co.za', role: 'Candidate', joined: '12 Jan 2026', status: 'Active'),
    _User(name: 'Nomvula Dlamini', email: 'nomvula@agentflow.co.za', role: 'Recruiter', joined: '15 Jan 2026', status: 'Active'),
    _User(name: 'Craig Botha', email: 'craig@techflow.co.za', role: 'Employer', joined: '03 Feb 2026', status: 'Suspended'),
    _User(name: 'Priya Naicker', email: 'priya@email.co.za', role: 'Candidate', joined: '20 Jan 2026', status: 'Active'),
    _User(name: 'Zanele Mokoena', email: 'zanele@agency.co.za', role: 'Recruiter', joined: '01 Mar 2026', status: 'Active'),
    _User(name: 'Sipho van Rooyen', email: 'sipho@shoprite.co.za', role: 'Employer', joined: '14 Feb 2026', status: 'Active'),
    _User(name: 'Admin', email: 'admin@hireiq.co.za', role: 'Admin', joined: '01 Jan 2026', status: 'Active'),
    _User(name: 'Ayanda Khumalo', email: 'ayanda@candidates.co.za', role: 'Candidate', joined: '28 Feb 2026', status: 'Active'),
  ];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: _roles.length, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _search.dispose();
    super.dispose();
  }

  List<_User> _filtered(String role) {
    final base = role == 'All' ? _users : _users.where((u) => u.role == role.substring(0, role.length - 1)).toList();
    if (_query.isEmpty) return base;
    return base.where((u) => u.name.toLowerCase().contains(_query.toLowerCase()) || u.email.toLowerCase().contains(_query.toLowerCase())).toList();
  }

  Color _roleColor(_User u) {
    switch (u.role) {
      case 'Candidate': return HireIQTheme.primaryTeal;
      case 'Employer': return HireIQTheme.primaryNavy;
      case 'Recruiter': return const Color(0xFF7C3AED);
      case 'Admin': return HireIQTheme.amber;
      default: return HireIQTheme.textMuted;
    }
  }

  void _showActions(BuildContext ctx, _User u) {
    showModalBottomSheet(
      context: ctx,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 8),
          Container(width: 36, height: 4, decoration: BoxDecoration(color: HireIQTheme.borderLight, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          Text(u.name, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
          const Divider(height: 24),
          ListTile(leading: const Icon(Icons.person_off_outlined, color: HireIQTheme.error), title: Text('Suspend User', style: GoogleFonts.inter(color: HireIQTheme.error)), onTap: () => Navigator.pop(ctx)),
          ListTile(leading: const Icon(Icons.manage_accounts_outlined, color: HireIQTheme.primaryTeal), title: Text('Change Role', style: GoogleFonts.inter()), onTap: () => Navigator.pop(ctx)),
          ListTile(leading: const Icon(Icons.history_rounded, color: HireIQTheme.textMuted), title: Text('View Activity', style: GoogleFonts.inter()), onTap: () => Navigator.pop(ctx)),
          const SizedBox(height: 8),
        ]),
      ),
    );
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
            centerTitle: false,
            title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('User Management', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
              Text('${_users.length} total users', style: GoogleFonts.inter(fontSize: 11, color: Colors.white.withValues(alpha: 0.6))),
            ]),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: () => setState(() {}),
                tooltip: 'Refresh',
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(108),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: TextField(
                    controller: _search,
                    onChanged: (v) => setState(() => _query = v),
                    style: GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Search users…',
                      hintStyle: GoogleFonts.inter(color: HireIQTheme.textMuted, fontSize: 13),
                      prefixIcon: const Icon(Icons.search_rounded, color: HireIQTheme.textMuted, size: 18),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                TabBar(
                  controller: _tabs,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700),
                  unselectedLabelStyle: GoogleFonts.inter(fontSize: 12),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white.withValues(alpha: 0.5),
                  indicatorColor: HireIQTheme.amber,
                  indicatorWeight: 3,
                  tabs: _roles.map((r) => Tab(text: r)).toList(),
                ),
              ]),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabs,
          children: _roles.map((role) {
            final users = _filtered(role);
            if (users.isEmpty) {
              return Center(child: Text('No users found.', style: GoogleFonts.inter(color: HireIQTheme.textMuted)));
            }
            return RefreshIndicator(
              color: HireIQTheme.primaryTeal,
              onRefresh: () async => setState(() {}),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: users.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final u = users[i];
                  return GestureDetector(
                    onLongPress: () => _showActions(context, u),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: HireIQTheme.surfaceWhite,
                        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                        border: Border.all(color: HireIQTheme.borderLight),
                        boxShadow: [BoxShadow(color: HireIQTheme.primaryNavy.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 2))],
                      ),
                      child: Row(children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: _roleColor(u).withValues(alpha: 0.1),
                          child: Text(u.name[0], style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: _roleColor(u))),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(u.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                          Text(u.email, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                          const SizedBox(height: 4),
                          Row(children: [
                            _RoleBadge(u.role, _roleColor(u)),
                            const SizedBox(width: 6),
                            Text('Joined ${u.joined}', style: GoogleFonts.inter(fontSize: 10, color: HireIQTheme.textMuted)),
                          ]),
                        ])),
                        _StatusBadge(u.status),
                      ]),
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _User {
  const _User({required this.name, required this.email, required this.role, required this.joined, required this.status});
  final String name, email, role, joined, status;
}

class _RoleBadge extends StatelessWidget {
  const _RoleBadge(this.role, this.color);
  final String role;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
      child: Text(role, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: color)),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge(this.status);
  final String status;

  @override
  Widget build(BuildContext context) {
    final active = status == 'Active';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: (active ? HireIQTheme.success : HireIQTheme.error).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
      ),
      child: Text(status, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: active ? HireIQTheme.success : HireIQTheme.error)),
    );
  }
}
