import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class RecruiterBriefBuilderWeb extends ConsumerStatefulWidget {
  const RecruiterBriefBuilderWeb({super.key});
  @override
  ConsumerState<RecruiterBriefBuilderWeb> createState() => _State();
}

class _State extends ConsumerState<RecruiterBriefBuilderWeb> {
  String _type = 'Permanent';
  bool _exclusive = true;

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // form
          Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Brief Builder', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
            Text('Create a structured job brief for your client', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            const SizedBox(height: 28),
            _BCard('Client & Role', Column(children: [
              _BF('Client / Company Name'),
              const SizedBox(height: 14),
              _BF('Job Title'),
              const SizedBox(height: 14),
              Row(children: [
                Expanded(child: DropdownButtonFormField<String>(value: _type, items: ['Permanent', 'Contract', 'Temp to Perm'].map((v) => DropdownMenuItem(value: v, child: Text(v, style: GoogleFonts.inter(fontSize: 13)))).toList(), onChanged: (v) => setState(() => _type = v!), decoration: InputDecoration(labelText: 'Placement Type', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))))),
                const SizedBox(width: 16),
                Expanded(child: _BF('Location')),
              ]),
            ])),
            const SizedBox(height: 20),
            _BCard('Compensation', Column(children: [
              Row(children: [Expanded(child: _BF('Min Salary')), const SizedBox(width: 16), Expanded(child: _BF('Max Salary'))]),
              const SizedBox(height: 14),
              _BF('Recruiter Fee (%)'),
            ])),
            const SizedBox(height: 20),
            _BCard('Requirements', Column(children: [
              TextField(maxLines: 4, decoration: InputDecoration(hintText: 'Key requirements, years of experience, qualifications...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.all(14))),
              const SizedBox(height: 14),
              TextField(maxLines: 3, decoration: InputDecoration(hintText: 'Nice to have skills...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.all(14))),
            ])),
          ])),
          const SizedBox(width: 28),
          // Right
          SizedBox(width: 290, child: Column(children: [
            const SizedBox(height: 68),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Brief Settings', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 14),
                Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Exclusive Brief', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)), Text('Only this recruiter can work on it', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))])), Switch(value: _exclusive, onChanged: (v) => setState(() => _exclusive = v), activeTrackColor: HireIQTheme.primaryTeal)]),
                const SizedBox(height: 14),
                _BF('Deadline'),
              ]),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.primaryTeal.withValues(alpha: 0.2))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [const Icon(Icons.auto_awesome_rounded, color: HireIQTheme.primaryTeal, size: 16), const SizedBox(width: 8), Text('WildcardIQ will match\ncandidates to this brief', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.primaryNavy, fontWeight: FontWeight.w600))]),
              ]),
            ),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Create Brief', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14)))),
          ])),
        ]),
      ),
    );
  }
}

Widget _BF(String l) => TextField(decoration: InputDecoration(labelText: l, labelStyle: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted), border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14)));
Widget _BCard(String title, Widget child) => Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)), const SizedBox(height: 16), child]));
