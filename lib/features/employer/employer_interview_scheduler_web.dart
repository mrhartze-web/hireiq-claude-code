import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerInterviewSchedulerWeb extends ConsumerWidget {
  const EmployerInterviewSchedulerWeb({super.key});

  static const _candidates = [
    _SchedC('Sipho Mokoena', 'Senior Flutter Dev', '94%', '25 Mar, 10:00', 'Video Call'),
    _SchedC('Anele Khumalo', 'Product Manager', '88%', '26 Mar, 14:00', 'On-site'),
    _SchedC('Priya Naidoo', 'DevOps Engineer', '82%', '28 Mar, 09:00', 'Phone'),
    _SchedC('Nomvula Sithole', 'UI/UX Designer', '79%', 'TBD', 'Not set'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left: scheduler form
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Interview Scheduler', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
            Text('Schedule and manage candidates interviews', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Schedule New Interview', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 20),
                _FField('Candidate'),
                const SizedBox(height: 16),
                _FField('Job Role'),
                const SizedBox(height: 16),
                Row(children: [
                  Expanded(child: _FField('Date')),
                  const SizedBox(width: 16),
                  Expanded(child: _FField('Time')),
                ]),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: 'Video Call',
                  items: ['Video Call', 'Phone', 'On-site'].map((v) => DropdownMenuItem(value: v, child: Text(v, style: GoogleFonts.inter(fontSize: 13)))).toList(),
                  onChanged: (_) {},
                  decoration: InputDecoration(labelText: 'Format', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))),
                ),
                const SizedBox(height: 20),
                SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.calendar_today_rounded, size: 14), label: Text('Schedule & Notify Candidate', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)), style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))))),
              ]),
            ),
          ])),
          const SizedBox(width: 28),
          // Right: scheduled list
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 66),
            Text('Upcoming Interviews', style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 14),
            ..._candidates.map((c) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(children: [
                Row(children: [
                  CircleAvatar(radius: 18, backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.1), child: Text(c.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal))),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(c.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                    Text(c.role, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                  ])),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text(c.matchiq, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))),
                ]),
                const SizedBox(height: 10),
                Row(children: [
                  const Icon(Icons.schedule_rounded, size: 13, color: HireIQTheme.textMuted),
                  const SizedBox(width: 6),
                  Text(c.datetime, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                  const SizedBox(width: 16),
                  const Icon(Icons.videocam_outlined, size: 13, color: HireIQTheme.textMuted),
                  const SizedBox(width: 4),
                  Text(c.format, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                  const Spacer(),
                  if (c.datetime != 'TBD') TextButton(onPressed: () {}, child: Text('Reschedule', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.primaryNavy, fontWeight: FontWeight.w600))),
                ]),
              ]),
            )),
          ])),
        ]),
      ),
    );
  }
}

class _SchedC { const _SchedC(this.name, this.role, this.matchiq, this.datetime, this.format); final String name, role, matchiq, datetime, format; }
Widget _FField(String l) => TextField(decoration: InputDecoration(labelText: l, labelStyle: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted), border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14)));
