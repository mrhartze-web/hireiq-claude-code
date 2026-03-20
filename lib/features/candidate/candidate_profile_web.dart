import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateProfileWeb extends ConsumerStatefulWidget {
  const CandidateProfileWeb({super.key});
  @override
  ConsumerState<CandidateProfileWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateProfileWeb>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left sidebar
          SizedBox(width: 280, child: Column(children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                CircleAvatar(radius: 48, backgroundColor: HireIQTheme.primaryNavy, child: Text('TM', style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white))),
                const SizedBox(height: 4),
                TextButton.icon(onPressed: () {}, icon: const Icon(Icons.camera_alt_rounded, size: 12), label: Text('Change photo', style: GoogleFonts.inter(fontSize: 11)), style: TextButton.styleFrom(foregroundColor: HireIQTheme.textMuted)),
                const SizedBox(height: 8),
                Text('Thabo Mokoena', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
                Text('Senior Flutter Developer', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.primaryTeal, fontWeight: FontWeight.w600)),
                Text('Cape Town, South Africa', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                const Divider(height: 24, color: HireIQTheme.borderLight),
                _PStat('MatchIQ Score', '87%', HireIQTheme.primaryTeal),
                _PStat('Profile Views', '142', HireIQTheme.info),
                _PStat('Applications', '6', HireIQTheme.primaryNavy),
                _PStat('Connections', '34', HireIQTheme.success),
              ]),
            ),
            const SizedBox(height: 14),
            ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.edit_rounded, size: 14), label: Text('Edit Profile', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), ),
          ])),
          const SizedBox(width: 24),
          // Centre: tabbed profile sections
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TabBar(controller: _tab, labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12), unselectedLabelStyle: GoogleFonts.inter(fontSize: 12), labelColor: HireIQTheme.primaryNavy, unselectedLabelColor: HireIQTheme.textMuted, indicatorColor: HireIQTheme.primaryTeal, isScrollable: true, tabs: const [Tab(text: 'Experience'), Tab(text: 'Education'), Tab(text: 'Skills'), Tab(text: 'Portfolio'), Tab(text: 'References')]),
            const SizedBox(height: 16),
            _ProfileCard('Experience', [
              _ExpEntry('Senior Flutter Developer', 'TechFlow Solutions', '2022 – Present', 'Built the flagship mobile banking application used by 2M+ users. Led a team of 4 developers.'),
              _ExpEntry('Flutter Developer', 'Capitec Bank', '2020 – 2022', 'Developed customer-facing features for the Capitec banking app with 8M+ DAU.'),
            ]),
          ])),
          const SizedBox(width: 24),
          // Right sidebar
          SizedBox(width: 260, child: Column(children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Profile Strength', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 12),
                Center(child: SizedBox(width: 80, height: 80, child: Stack(alignment: Alignment.center, children: [
                  const CircularProgressIndicator(value: 0.72, strokeWidth: 9, backgroundColor: HireIQTheme.borderLight, valueColor: AlwaysStoppedAnimation<Color>(HireIQTheme.warning)),
                  Text('72%', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
                ]))),
                const SizedBox(height: 12),
                ...[
                  ('Add portfolio projects', false),
                  ('List 5 key skills', true),
                  ('Add references', false),
                ].map((a) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Row(children: [Icon(a.$2 ? Icons.check_circle_rounded : Icons.circle_outlined, size: 14, color: a.$2 ? HireIQTheme.success : HireIQTheme.borderMedium), const SizedBox(width: 8), Expanded(child: Text(a.$1, style: GoogleFonts.inter(fontSize: 11, color: a.$2 ? HireIQTheme.textMuted : HireIQTheme.textPrimary)))]))),
              ]),
            ),
            const SizedBox(height: 14),
            // PassportIQ status
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.2))),
              child: Row(children: [
                const Icon(Icons.verified_rounded, color: HireIQTheme.primaryTeal, size: 28),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('PassportIQ', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  Text('2/4 verifications complete', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                ])),
                TextButton(onPressed: () {}, child: Text('Verify', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))),
              ]),
            ),
          ])),
        ]),
      ),
    );
  }
}

Widget _PStat(String label, String value, Color color) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(children: [Text(label, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)), const Spacer(), Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: color))]));

Widget _ProfileCard(String title, List<_ExpEntry> items) => Container(
  padding: const EdgeInsets.all(22),
  decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [Text(title, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)), const Spacer(), IconButton(icon: const Icon(Icons.add_circle_outline_rounded, color: HireIQTheme.primaryTeal), onPressed: () {})]),
    const Divider(color: HireIQTheme.borderLight, height: 20),
    ...items.map((e) => Padding(padding: const EdgeInsets.only(bottom: 18), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 6, height: 6, margin: const EdgeInsets.only(top: 6, right: 12), decoration: const BoxDecoration(color: HireIQTheme.primaryTeal, shape: BoxShape.circle)),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(e.role, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
        Text('${e.company}  ·  ${e.dates}', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.primaryTeal)),
        const SizedBox(height: 4),
        Text(e.desc, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.5)),
      ])),
    ]))),
  ]),
);

class _ExpEntry {
  const _ExpEntry(this.role, this.company, this.dates, this.desc);
  final String role, company, dates, desc;
}
