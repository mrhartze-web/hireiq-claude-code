import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class RecruiterBriefsWeb extends ConsumerWidget {
  const RecruiterBriefsWeb({super.key});

  static const _briefs = [
    _Brief('Senior Flutter Developer', 'TechFlow Solutions', 'Permanent', 'R85k–R120k', '8%', 'Closing 25 Mar', HireIQTheme.error),
    _Brief('Product Manager', 'Capitec Bank', 'Permanent', 'R95k–R130k', '10%', 'Closing 30 Mar', HireIQTheme.warning),
    _Brief('DevOps Engineer', 'Standard Bank', 'Contract', 'R80k–R110k', '12%', 'Closing 10 Apr', HireIQTheme.success),
    _Brief('UI/UX Designer', 'Nedbank', 'Permanent', 'R70k–R95k', '9%', 'Closing 15 Apr', HireIQTheme.success),
    _Brief('Data Scientist', 'Discovery', 'Permanent', 'R90k–R120k', '10%', 'Closing 20 Apr', HireIQTheme.success),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('My Briefs', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('${_briefs.length} active briefs across 4 clients', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, size: 16), label: Text('New Brief', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
          ]),
          const SizedBox(height: 28),
          Container(
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), color: HireIQTheme.background, child: Row(children: [_Brh('Role', 2), _Brh('Client', 2), _Brh('Type'), _Brh('Salary', 2), _Brh('Fee'), _Brh('Deadline'), _Brh('')])),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              ..._briefs.asMap().entries.map((e) {
                final b = e.value;
                final isLast = e.key == _briefs.length - 1;
                return Column(children: [
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                    Expanded(flex: 2, child: Text(b.role, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary))),
                    Expanded(flex: 2, child: Text(b.client, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                    Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.primaryNavy.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(b.type, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)))),
                    Expanded(flex: 2, child: Text(b.salary, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textPrimary))),
                    Expanded(child: Text(b.fee, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))),
                    Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: b.urgency.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(b.deadline, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: b.urgency)))),
                    Expanded(child: Row(children: [
                      IconButton(icon: const Icon(Icons.people_rounded, size: 16, color: HireIQTheme.primaryNavy), onPressed: () {}),
                      IconButton(icon: const Icon(Icons.edit_outlined, size: 16, color: HireIQTheme.textMuted), onPressed: () {}),
                    ])),
                  ])),
                  if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                ]);
              }),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _Brief { const _Brief(this.role, this.client, this.type, this.salary, this.fee, this.deadline, this.urgency); final String role, client, type, salary, fee, deadline; final Color urgency; }
Widget _Brh(String t, [int flex = 1]) => Expanded(flex: flex, child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
