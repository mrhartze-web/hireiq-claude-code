import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateReferencesWeb extends ConsumerWidget {
  const CandidateReferencesWeb({super.key});

  static const _refs = [
    _Ref('Sipho Dlamini', 'Engineering Manager', 'TechFlow Solutions', 'sipho@techflow.co.za', '+27 82 111 2233', 'Verified'),
    _Ref('Anele Khumalo', 'CTO', 'Capitec Bank', 'anele.k@capitec.co.za', '+27 83 444 5566', 'Verified'),
    _Ref('Priya Naidoo', 'Lead Developer', 'Discovery Health', 'priya.n@discovery.co.za', '+27 71 777 8899', 'Pending'),
    _Ref('Ruan van der Berg', 'Product Manager', 'OUTsurance', 'ruan@outsurance.co.za', '+27 76 000 1122', 'Pending'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('References', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('Manage professional references for your profile', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, size: 16), label: Text('Add Reference', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
          ]),
          const SizedBox(height: 32),
          LayoutBuilder(builder: (ctx, constraints) {
            final cols = constraints.maxWidth > 900 ? 2 : 1;
            return _WrapGrid(cols: cols, children: _refs.map((r) => _RefCard(r)).toList());
          }),
        ]),
      ),
    );
  }
}

class _RefCard extends StatelessWidget {
  const _RefCard(this.ref_);
  final _Ref ref_;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(radius: 24, backgroundColor: HireIQTheme.primaryNavy.withValues(alpha: 0.1), child: Text(ref_.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy))),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(ref_.name, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
            Text('${ref_.role} · ${ref_.company}', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)),
          ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: ref_.status == 'Verified' ? HireIQTheme.success.withValues(alpha: 0.1) : HireIQTheme.warning.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
            child: Text(ref_.status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: ref_.status == 'Verified' ? HireIQTheme.success : HireIQTheme.warning)),
          ),
        ]),
        const SizedBox(height: 16),
        const Divider(color: HireIQTheme.borderLight),
        const SizedBox(height: 12),
        Row(children: [const Icon(Icons.email_outlined, size: 14, color: HireIQTheme.textMuted), const SizedBox(width: 8), Text(ref_.email, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))]),
        const SizedBox(height: 6),
        Row(children: [const Icon(Icons.phone_outlined, size: 14, color: HireIQTheme.textMuted), const SizedBox(width: 8), Text(ref_.phone, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))]),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.borderMedium), padding: const EdgeInsets.symmetric(vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Edit', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)))),
          const SizedBox(width: 10),
          Expanded(child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(color: HireIQTheme.error), padding: const EdgeInsets.symmetric(vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Remove', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.error)))),
        ]),
      ]),
    );
  }
}

class _Ref { const _Ref(this.name, this.role, this.company, this.email, this.phone, this.status); final String name, role, company, email, phone, status; }

class _WrapGrid extends StatelessWidget {
  const _WrapGrid({required this.cols, required this.children});
  final int cols;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i += cols) {
      final rowChildren = children.sublist(i, (i + cols).clamp(0, children.length));
      rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: rowChildren.asMap().entries.map((e) => Expanded(child: Padding(padding: EdgeInsets.only(right: e.key < rowChildren.length - 1 ? 16 : 0, bottom: 16), child: e.value))).toList()));
    }
    return Column(children: rows);
  }
}
