import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class RecruiterCvVaultWeb extends ConsumerStatefulWidget {
  const RecruiterCvVaultWeb({super.key});
  @override
  ConsumerState<RecruiterCvVaultWeb> createState() => _State();
}

class _State extends ConsumerState<RecruiterCvVaultWeb> {
  String _search = '';

  static const _cvs = [
    _CV('Thabo Mokoena', 'Senior Flutter Developer', '20 Mar 2026', ['Flutter', 'Firebase', 'Riverpod'], 94),
    _CV('Sipho Dlamini', 'Mobile Engineer', '18 Mar 2026', ['Swift', 'Kotlin', 'Flutter'], 88),
    _CV('Anele Khumalo', 'Lead Flutter Dev', '15 Mar 2026', ['Flutter', 'BLoC', 'REST'], 85),
    _CV('Priya Naidoo', 'Frontend Developer', '12 Mar 2026', ['React', 'TypeScript', 'CSS'], 81),
    _CV('Nomvula Sithole', 'Full Stack Developer', '10 Mar 2026', ['Node', 'Flutter', 'SQL'], 78),
    _CV('Ayanda Nkosi', 'Flutter Developer', '08 Mar 2026', ['Flutter', 'Dart', 'Firebase'], 74),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _cvs.where((c) => c.name.toLowerCase().contains(_search.toLowerCase()) || c.role.toLowerCase().contains(_search.toLowerCase())).toList();

    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('CV Vault', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('${_cvs.length} CVs stored · Search and submit to clients instantly', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload_file_rounded, size: 16),
              label: Text('Upload CV', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)),
              style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))),
            ),
          ]),
          const SizedBox(height: 24),
          SizedBox(
            width: 380,
            child: TextField(
              onChanged: (v) => setState(() => _search = v),
              decoration: InputDecoration(prefixIcon: const Icon(Icons.search_rounded, size: 18), hintText: 'Search CVs by name or role...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14)),
            ),
          ),
          const SizedBox(height: 24),
          LayoutBuilder(builder: (ctx, constraints) {
            const cols = 3;
            const spacing = 16.0;
            final width = (constraints.maxWidth - spacing * (cols - 1)) / cols;
            return Wrap(spacing: spacing, runSpacing: spacing, children: filtered.map((cv) => SizedBox(width: width, child: _CVCard(cv))).toList());
          }),
        ]),
      ),
    );
  }
}

class _CVCard extends StatelessWidget {
  const _CVCard(this.cv);
  final _CV cv;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(radius: 22, backgroundColor: HireIQTheme.primaryNavy, child: Text(cv.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(cv.name, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
            Text(cv.role, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
          ])),
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('${cv.matchiq}%', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))),
        ]),
        const SizedBox(height: 10),
        Row(children: [const Icon(Icons.access_time_rounded, size: 12, color: HireIQTheme.textMuted), const SizedBox(width: 4), Text('Added ${cv.added}', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))]),
        const SizedBox(height: 10),
        Wrap(spacing: 6, runSpacing: 6, children: cv.skills.map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(s, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)))).toList()),
        const SizedBox(height: 14),
        Row(children: [
          Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Submit', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)))),
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.download_rounded, size: 18, color: HireIQTheme.primaryNavy), onPressed: () {}),
          IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 18, color: HireIQTheme.error), onPressed: () {}),
        ]),
      ]),
    );
  }
}

class _CV { const _CV(this.name, this.role, this.added, this.skills, this.matchiq); final String name, role, added; final List<String> skills; final int matchiq; }
