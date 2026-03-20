import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class RecruiterPipelineWeb extends ConsumerStatefulWidget {
  const RecruiterPipelineWeb({super.key});
  @override
  ConsumerState<RecruiterPipelineWeb> createState() => _State();
}

class _State extends ConsumerState<RecruiterPipelineWeb> {
  final _stages = ['Sourced', 'Submitted', 'Interview', 'Offer', 'Placed'];
  final _candidates = [
    _PC('Thabo Mokoena', 'Sr Flutter Dev', 'TechFlow', 94, 0),
    _PC('Sipho Dlamini', 'Mobile Eng.', 'Capitec', 88, 1),
    _PC('Anele Khumalo', 'Lead Flutter', 'Standard Bank', 85, 1),
    _PC('Priya Naidoo', 'Frontend Dev', 'Nedbank', 81, 2),
    _PC('Nomvula Sithole', 'Full Stack', 'Discovery', 78, 2),
    _PC('Ayanda Nkosi', 'Flutter Dev', 'TechFlow', 91, 3),
    _PC('Ruan van Niekerk', 'DevOps Eng.', 'Capitec', 83, 4),
  ];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Recruiter Pipeline', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Manage all candidates across every stage', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 24),
          SizedBox(height: 520, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: SizedBox(
            width: _stages.length * 240.0 + (_stages.length - 1) * 12,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: _stages.asMap().entries.map((e) {
              final stageIdx = e.key;
              final stageName = e.value;
              final stageCandidates = _candidates.where((c) => c.stage == stageIdx).toList();
              final stageColors = [HireIQTheme.textMuted, HireIQTheme.primaryNavy, HireIQTheme.info, HireIQTheme.warning, HireIQTheme.success];
              return SizedBox(width: 240, child: Container(
                margin: EdgeInsets.only(right: stageIdx < _stages.length - 1 ? 12 : 0),
                decoration: BoxDecoration(color: HireIQTheme.background, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: stageColors[stageIdx].withValues(alpha: 0.08),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(HireIQTheme.radiusLg)),
                      border: Border(bottom: BorderSide(color: stageColors[stageIdx].withValues(alpha: 0.2))),
                    ),
                    child: Row(children: [
                      Expanded(child: Text(stageName, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: stageColors[stageIdx]))),
                      Container(width: 22, height: 22, decoration: BoxDecoration(color: stageColors[stageIdx], shape: BoxShape.circle), child: Center(child: Text('${stageCandidates.length}', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white)))),
                    ]),
                  ),
                  Expanded(child: ListView(padding: const EdgeInsets.all(10), children: stageCandidates.map((c) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.borderLight)),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        CircleAvatar(radius: 14, backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.1), child: Text(c.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal))),
                        const SizedBox(width: 8),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(c.name, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                          Text('${c.role} · ${c.client}', style: GoogleFonts.inter(fontSize: 10, color: HireIQTheme.textMuted)),
                        ])),
                      ]),
                      const SizedBox(height: 8),
                      Row(children: [
                        const Icon(Icons.auto_awesome_rounded, size: 10, color: HireIQTheme.primaryTeal),
                        const SizedBox(width: 3),
                        Text('${c.matchiq}%', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
                        const Spacer(),
                        if (c.stage < _stages.length - 1) GestureDetector(
                          onTap: () => setState(() { final idx = _candidates.indexOf(c); _candidates[idx] = _PC(c.name, c.role, c.client, c.matchiq, c.stage + 1); }),
                          child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: HireIQTheme.amber.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('→', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: HireIQTheme.amber))),
                        ),
                      ]),
                    ]),
                  )).toList())),
                ]),
              ));
            }).toList()),
          ))),
        ]),
      ),
    );
  }
}

class _PC { _PC(this.name, this.role, this.client, this.matchiq, this.stage); final String name, role, client; final int matchiq; int stage; }
