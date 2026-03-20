import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateJobSearchWeb extends ConsumerStatefulWidget {
  const CandidateJobSearchWeb({super.key});
  @override
  ConsumerState<CandidateJobSearchWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateJobSearchWeb> {
  int _selectedJob = 0;
  bool _remote = false;

  static const _jobs = [
    _Job('Senior Flutter Developer', 'TechFlow Solutions', 'Cape Town', 'R85k–R120k', 'Full-time', 94),
    _Job('Lead Mobile Engineer', 'Capitec Bank', 'Johannesburg', 'R95k–R130k', 'Full-time', 91),
    _Job('Software Engineer III', 'Standard Bank', 'Remote', 'R80k–R110k', 'Full-time', 88),
    _Job('React Native Developer', 'OUTsurance', 'Cape Town', 'R70k–R95k', 'Contract', 84),
    _Job('Frontend Developer', 'Nedbank', 'Johannesburg', 'R65k–R90k', 'Full-time', 81),
    _Job('Mobile Architect', 'Discovery', 'Cape Town', 'R110k–R145k', 'Full-time', 79),
  ];

  @override
  Widget build(BuildContext context) {
    final job = _jobs[_selectedJob];
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left: search & filters
          SizedBox(width: 260, child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextField(decoration: InputDecoration(hintText: 'Job title, keyword...', prefixIcon: const Icon(Icons.search_rounded, size: 18), border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12), hintStyle: GoogleFonts.inter(fontSize: 12))),
              const SizedBox(height: 12),
              TextField(controller: TextEditingController(text: 'Cape Town'), decoration: InputDecoration(labelText: 'Location', prefixIcon: const Icon(Icons.location_on_rounded, size: 16), border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12))),
              const SizedBox(height: 16),
              Text('Job Type', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)),
              const SizedBox(height: 8),
              Wrap(spacing: 6, runSpacing: 6, children: ['Full-time', 'Contract', 'Part-time'].map((t) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: t == 'Full-time' ? HireIQTheme.primaryNavy : HireIQTheme.background, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), border: Border.all(color: t == 'Full-time' ? HireIQTheme.primaryNavy : HireIQTheme.borderLight)), child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: t == 'Full-time' ? Colors.white : HireIQTheme.textMuted)))).toList()),
              const SizedBox(height: 16),
              Text('Salary Range', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)),
              const SizedBox(height: 4),
              Text('R50,000 – R150,000/month', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textPrimary)),
              Slider(value: 0.7, onChanged: (v) {}, activeColor: HireIQTheme.primaryTeal, inactiveColor: HireIQTheme.borderLight),
              const SizedBox(height: 8),
              Text('Experience Level', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)),
              const SizedBox(height: 8),
              Wrap(spacing: 6, runSpacing: 6, children: ['Junior', 'Mid', 'Senior', 'Lead'].map((e) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: e == 'Senior' ? HireIQTheme.primaryTeal.withValues(alpha: 0.1) : HireIQTheme.background, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), border: Border.all(color: e == 'Senior' ? HireIQTheme.primaryTeal : HireIQTheme.borderLight)), child: Text(e, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: e == 'Senior' ? HireIQTheme.primaryTeal : HireIQTheme.textMuted)))).toList()),
              const SizedBox(height: 16),
              Row(children: [
                Text('Remote only', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textPrimary)),
                const Spacer(),
                Switch(value: _remote, onChanged: (v) => setState(() => _remote = v), activeTrackColor: HireIQTheme.primaryTeal),
              ]),
              const SizedBox(height: 12),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Search Jobs', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)))),
            ]),
          )),
          const SizedBox(width: 16),
          // Centre: job results
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('${_jobs.length} results near Cape Town', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: HireIQTheme.textMuted)),
            const SizedBox(height: 12),
            ..._jobs.asMap().entries.map((e) {
              final j = e.value;
              final sel = _selectedJob == e.key;
              return GestureDetector(
                onTap: () => setState(() => _selectedJob = e.key),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: sel ? HireIQTheme.primaryTeal : HireIQTheme.borderLight, width: sel ? 2 : 1)),
                  child: Row(children: [
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(j.title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                      Text('${j.company} · ${j.location}', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                      const SizedBox(height: 6),
                      Row(children: [
                        Text(j.salary, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                        const SizedBox(width: 10),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.07), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(j.type, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy))),
                      ]),
                    ])),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.auto_awesome_rounded, size: 12, color: HireIQTheme.primaryTeal), const SizedBox(width: 4), Text('${j.matchiq}%', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal))])),
                  ]),
                ),
              );
            }),
          ])),
          const SizedBox(width: 16),
          // Right: preview
          SizedBox(width: 300, child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(job.title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text(job.company, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.primaryTeal)),
              const SizedBox(height: 8),
              _JMI(Icons.location_on_rounded, job.location),
              _JMI(Icons.attach_money_rounded, job.salary),
              _JMI(Icons.work_outline_rounded, job.type),
              const Divider(color: HireIQTheme.borderLight, height: 20),
              Center(child: SizedBox(width: 80, height: 80, child: Stack(alignment: Alignment.center, children: [
                CircularProgressIndicator(value: job.matchiq / 100, strokeWidth: 9, backgroundColor: HireIQTheme.borderLight, valueColor: const AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal)),
                Text('${job.matchiq}%', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              ]))),
              const SizedBox(height: 4),
              Center(child: Text('MatchIQ Score', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))),
              const SizedBox(height: 16),
              Text('About this role', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 6),
              Text('We are looking for an experienced developer to join our team and build next-generation mobile experiences for South African consumers.', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.55)),
              const SizedBox(height: 16),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Quick Apply', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)))),
              const SizedBox(height: 8),
              SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.borderMedium), padding: const EdgeInsets.symmetric(vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), foregroundColor: HireIQTheme.primaryNavy), child: Text('View Full Details', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600)))),
            ]),
          )),
        ]),
      ),
    );
  }
}

class _Job {
  const _Job(this.title, this.company, this.location, this.salary, this.type, this.matchiq);
  final String title, company, location, salary, type;
  final int matchiq;
}

Widget _JMI(IconData icon, String text) => Padding(padding: const EdgeInsets.only(bottom: 5), child: Row(children: [Icon(icon, size: 13, color: HireIQTheme.textMuted), const SizedBox(width: 6), Text(text, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))]));
