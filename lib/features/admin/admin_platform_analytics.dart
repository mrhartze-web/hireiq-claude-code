import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class AdminPlatformAnalytics extends ConsumerWidget {
  const AdminPlatformAnalytics({super.key});

  static const _months = ['Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar'];
  static const _growth = [1240.0, 1580.0, 2100.0, 2890.0, 3650.0, 4521.0];

  static const _cities = [
    _City('Johannesburg', 4521, HireIQTheme.primaryTeal),
    _City('Cape Town', 2847, HireIQTheme.primaryNavy),
    _City('Durban', 1203, Color(0xFF7C3AED)),
    _City('Pretoria', 987, HireIQTheme.amber),
  ];

  static const _topEmployers = [
    'TechFlow Solutions',
    'Shoprite Holdings',
    'Standard Bank',
    'OUTsurance',
    'Capitec Bank',
  ];

  static const _topRecruiters = [
    'Nomvula Dlamini',
    'Zanele Mokoena',
    'Sipho van Rooyen',
    'Craig Botha',
    'Priya Naicker',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxGrowth = _growth.reduce((a, b) => a > b ? a : b);
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('Platform Analytics', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Stat cards grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.4,
            children: const [
              _StatCard(label: 'Total Users', value: '9,558', color: HireIQTheme.primaryNavy, icon: Icons.people_rounded),
              _StatCard(label: 'Active Jobs', value: '348', color: HireIQTheme.primaryTeal, icon: Icons.work_rounded),
              _StatCard(label: 'Placements (Mar)', value: '87', color: HireIQTheme.amber, icon: Icons.handshake_rounded),
              _StatCard(label: 'MRR', value: 'R127k', color: HireIQTheme.success, icon: Icons.trending_up_rounded),
            ],
          ),
          const SizedBox(height: 24),

          // User growth bar chart
          Text('User Growth (Last 6 Months)', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: List.generate(_months.length, (i) {
              final height = (_growth[i] / maxGrowth) * 100;
              final isLast = i == _months.length - 1;
              return Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: isLast ? HireIQTheme.primaryTeal : HireIQTheme.primaryNavy.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(_months[i], style: GoogleFonts.inter(fontSize: 10, color: isLast ? HireIQTheme.primaryNavy : HireIQTheme.textMuted)),
                ]),
              ));
            })),
          ),
          const SizedBox(height: 24),

          // Role distribution
          Text('Role Distribution', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(children: [
              _RoleBar('Candidates', 0.72, HireIQTheme.primaryTeal, '6,882'),
              const SizedBox(height: 14),
              _RoleBar('Employers', 0.18, HireIQTheme.primaryNavy, '1,720'),
              const SizedBox(height: 14),
              _RoleBar('Recruiters', 0.10, const Color(0xFF7C3AED), '956'),
            ]),
          ),
          const SizedBox(height: 24),

          // Top lists side by side
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: _TopList('Top Employers', _topEmployers, HireIQTheme.primaryNavy)),
            const SizedBox(width: 12),
            Expanded(child: _TopList('Top Recruiters', _topRecruiters, Color(0xFF7C3AED))),
          ]),
          const SizedBox(height: 24),

          // Geographic chips
          Text('Geographic Distribution', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: _cities.map((c) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: c.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), border: Border.all(color: c.color.withValues(alpha: 0.25))),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(c.city, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(color: c.color, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
                child: Text('${c.count.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                    style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ]),
          )).toList()),
        ]),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value, required this.color, required this.icon});
  final String label, value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.6), size: 20),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value, style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
          Text(label, style: GoogleFonts.inter(fontSize: 11, color: Colors.white.withValues(alpha: 0.7))),
        ]),
      ]),
    );
  }
}

class _City {
  const _City(this.city, this.count, this.color);
  final String city;
  final int count;
  final Color color;
}

Widget _RoleBar(String label, double share, Color color, String count) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [
      Expanded(child: Text(label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: HireIQTheme.textPrimary))),
      Text('$count (${(share * 100).round()}%)', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
    ]),
    const SizedBox(height: 6),
    ClipRRect(
      borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
      child: LinearProgressIndicator(value: share, minHeight: 8, backgroundColor: HireIQTheme.borderLight, valueColor: AlwaysStoppedAnimation<Color>(color)),
    ),
  ]);
}

Widget _TopList(String title, List<String> items, Color accentColor) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
      const SizedBox(height: 10),
      ...items.asMap().entries.map((e) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(children: [
          Container(width: 20, height: 20, decoration: BoxDecoration(color: accentColor.withValues(alpha: 0.1), shape: BoxShape.circle), child: Center(child: Text('${e.key + 1}', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: accentColor)))),
          const SizedBox(width: 8),
          Expanded(child: Text(e.value, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textPrimary), overflow: TextOverflow.ellipsis)),
        ]),
      )),
    ]),
  );
}
