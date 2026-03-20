import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerOfferManagementWeb extends ConsumerWidget {
  const EmployerOfferManagementWeb({super.key});

  static const _offers = [
    _Offer('Sipho Mokoena', 'Senior Flutter Developer', 'R105,000/mo', 'Awaiting Response', HireIQTheme.warning),
    _Offer('Priya Naidoo', 'Product Manager', 'R115,000/mo', 'Accepted', HireIQTheme.success),
    _Offer('Anele Khumalo', 'DevOps Engineer', 'R95,000/mo', 'Declined', HireIQTheme.error),
    _Offer('Nomvula Sithole', 'UI/UX Designer', 'R85,000/mo', 'Draft', HireIQTheme.textMuted),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Offer Management', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
              Text('Track and manage all extended offers', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            ]),
            const Spacer(),
            ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, size: 16), label: Text('Create Offer', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)))),
          ]),
          const SizedBox(height: 28),
          // Summary stats
          Row(children: [
            _OfferStat('Offers Sent', '4', HireIQTheme.primaryNavy),
            const SizedBox(width: 16),
            _OfferStat('Accepted', '1', HireIQTheme.success),
            const SizedBox(width: 16),
            _OfferStat('Awaiting', '1', HireIQTheme.warning),
            const SizedBox(width: 16),
            _OfferStat('Declined', '1', HireIQTheme.error),
          ]),
          const SizedBox(height: 28),
          Container(
            decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
            child: Column(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), color: HireIQTheme.background, child: Row(children: [_OH('Candidate', 2), _OH('Role', 2), _OH('Salary', 2), _OH('Status', 2), _OH('Actions')])),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              ..._offers.asMap().entries.map((e) {
                final offer = e.value;
                final isLast = e.key == _offers.length - 1;
                return Column(children: [
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), child: Row(children: [
                    Expanded(flex: 2, child: Row(children: [
                      CircleAvatar(radius: 16, backgroundColor: HireIQTheme.primaryNavy.withValues(alpha: 0.1), child: Text(offer.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy))),
                      const SizedBox(width: 10),
                      Text(offer.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)),
                    ])),
                    Expanded(flex: 2, child: Text(offer.role, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                    Expanded(flex: 2, child: Text(offer.salary, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
                    Expanded(flex: 2, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: offer.statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(offer.status, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: offer.statusColor)))),
                    Expanded(child: Row(children: [
                      IconButton(icon: const Icon(Icons.visibility_outlined, size: 16, color: HireIQTheme.primaryNavy), onPressed: () {}),
                      if (offer.status == 'Draft') IconButton(icon: const Icon(Icons.send_rounded, size: 16, color: HireIQTheme.primaryTeal), onPressed: () {}),
                      if (offer.status == 'Awaiting Response') IconButton(icon: const Icon(Icons.cancel_outlined, size: 16, color: HireIQTheme.error), onPressed: () {}),
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

class _Offer { const _Offer(this.name, this.role, this.salary, this.status, this.statusColor); final String name, role, salary, status; final Color statusColor; }
Widget _OfferStat(String l, String v, Color c) => Expanded(child: Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(v, style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w800, color: c)), Text(l, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))])));
Widget _OH(String t, [int flex = 1]) => Expanded(flex: flex, child: Text(t, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
