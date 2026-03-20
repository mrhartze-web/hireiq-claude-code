import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerPostJobWeb extends ConsumerStatefulWidget {
  const EmployerPostJobWeb({super.key});
  @override
  ConsumerState<EmployerPostJobWeb> createState() => _State();
}

class _State extends ConsumerState<EmployerPostJobWeb> {
  String _type = 'Full-time';
  String _arrangement = 'Hybrid';
  bool _ai = true;

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // form
          Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Post a New Job', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
            Text('Create a compelling job listing with AI assistance', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            const SizedBox(height: 28),
            _PostCard('Basic Details', Column(children: [
              _PF('Job Title'),
              const SizedBox(height: 14),
              _PF('Department'),
              const SizedBox(height: 14),
              Row(children: [
                Expanded(child: DropdownButtonFormField<String>(value: _type, items: ['Full-time', 'Part-time', 'Contract', 'Freelance'].map((v) => DropdownMenuItem(value: v, child: Text(v, style: GoogleFonts.inter(fontSize: 13)))).toList(), onChanged: (v) => setState(() => _type = v!), decoration: InputDecoration(labelText: 'Job Type', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))))),
                const SizedBox(width: 16),
                Expanded(child: DropdownButtonFormField<String>(value: _arrangement, items: ['Remote', 'Hybrid', 'On-site'].map((v) => DropdownMenuItem(value: v, child: Text(v, style: GoogleFonts.inter(fontSize: 13)))).toList(), onChanged: (v) => setState(() => _arrangement = v!), decoration: InputDecoration(labelText: 'Work Arrangement', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))))),
              ]),
            ])),
            const SizedBox(height: 20),
            _PostCard('Compensation', Column(children: [
              Row(children: [
                Expanded(child: _PF('Min Salary (R/month)')),
                const SizedBox(width: 16),
                Expanded(child: _PF('Max Salary (R/month)')),
              ]),
              const SizedBox(height: 14),
              Text('Display salary range to candidates', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)),
            ])),
            const SizedBox(height: 20),
            _PostCard('Job Description & Requirements', Column(children: [
              TextField(maxLines: 6, decoration: InputDecoration(hintText: 'Describe the role, responsibilities, and impact...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.all(14))),
              const SizedBox(height: 14),
              TextField(maxLines: 4, decoration: InputDecoration(hintText: 'List key requirements and must-haves...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.all(14))),
            ])),
          ])),
          const SizedBox(width: 28),
          // Right: settings
          SizedBox(width: 300, child: Column(children: [
            const SizedBox(height: 68),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('AI Options', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 14),
                Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Enhance with ForgeIQ', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                    Text('Rewrite the JD for maximum attraction', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                  ])),
                  Switch(value: _ai, onChanged: (v) => setState(() => _ai = v), activeTrackColor: HireIQTheme.primaryTeal),
                ]),
                if (_ai) ...[
                  const SizedBox(height: 12),
                  ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.auto_awesome_rounded, size: 14), label: Text('Generate with AI', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.primaryTeal, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
                ],
              ]),
            ),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Publish Job', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 15)))),
            const SizedBox(height: 12),
            SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.borderMedium), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Save as Draft', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13, color: HireIQTheme.textPrimary)))),
          ])),
        ]),
      ),
    );
  }
}

Widget _PF(String l) => TextField(decoration: InputDecoration(labelText: l, labelStyle: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted), border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14)));
Widget _PostCard(String title, Widget child) => Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)), const SizedBox(height: 16), child]));
