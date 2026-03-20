import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerCandidatePipelineWeb extends ConsumerStatefulWidget {
  const EmployerCandidatePipelineWeb({super.key});
  @override
  ConsumerState<EmployerCandidatePipelineWeb> createState() => _State();
}

class _State extends ConsumerState<EmployerCandidatePipelineWeb> {
  final _stages = ['Applied', 'Screening', 'Interview', 'Assessment', 'Offer'];
  final _candidates = [
    _PipeC('Thabo Mokoena', 'Senior Flutter Dev', 94, 0),
    _PipeC('Sipho Dlamini', 'Senior Flutter Dev', 88, 1),
    _PipeC('Anele Khumalo', 'Product Manager', 82, 1),
    _PipeC('Priya Naidoo', 'DevOps Engineer', 79, 2),
    _PipeC('Ruan van der Berg', 'UI/UX Designer', 76, 2),
    _PipeC('Nomvula Sithole', 'Senior Flutter Dev', 91, 3),
    _PipeC('Ayanda Nkosi', 'Product Manager', 85, 4),
  ];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Candidate Pipeline', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('Drag candidates across stages to update their status', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            DropdownButton<String>(value: 'All Roles', items: ['All Roles', 'Senior Flutter Dev', 'Product Manager', 'DevOps Engineer'].map((v) => DropdownMenuItem(value: v, child: Text(v, style: GoogleFonts.inter(fontSize: 13)))).toList(), onChanged: (_) {}, underline: const SizedBox.shrink()),
          ]),
          const SizedBox(height: 24),
          SizedBox(height: 520, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: SizedBox(
            width: _stages.length * 240.0 + (_stages.length - 1) * 12,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: _stages.asMap().entries.map((e) {
              final stageIdx = e.key;
              final stageName = e.value;
              final stageCandidates = _candidates.where((c) => c.stage == stageIdx).toList();
              return SizedBox(width: 240, child: Container(
                margin: EdgeInsets.only(right: stageIdx < _stages.length - 1 ? 12 : 0),
                decoration: BoxDecoration(color: HireIQTheme.background, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.05), borderRadius: const BorderRadius.vertical(top: Radius.circular(HireIQTheme.radiusLg))), child: Row(children: [
                    Expanded(child: Text(stageName, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
                    Container(width: 24, height: 24, decoration: BoxDecoration(color: HireIQTheme.primaryNavy, shape: BoxShape.circle), child: Center(child: Text('${stageCandidates.length}', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)))),
                  ])),
                  Expanded(child: ListView(padding: const EdgeInsets.all(10), children: stageCandidates.map((c) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.borderLight)),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        CircleAvatar(radius: 16, backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.1), child: Text(c.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal))),
                        const SizedBox(width: 8),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(c.name, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                          Text(c.role, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                        ])),
                      ]),
                      const SizedBox(height: 8),
                      Row(children: [
                        const Icon(Icons.auto_awesome_rounded, size: 11, color: HireIQTheme.primaryTeal),
                        const SizedBox(width: 4),
                        Text('${c.matchiq}%', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal)),
                        const Spacer(),
                        if (c.stage < _stages.length - 1) GestureDetector(onTap: () => setState(() { final idx = _candidates.indexOf(c); _candidates[idx] = _PipeC(c.name, c.role, c.matchiq, c.stage + 1); }), child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.amber.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('Move →', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: HireIQTheme.amber)))),
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

class _PipeC { _PipeC(this.name, this.role, this.matchiq, this.stage); final String name, role; final int matchiq; int stage; }
