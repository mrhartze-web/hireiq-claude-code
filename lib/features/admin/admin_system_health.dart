import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class AdminSystemHealth extends ConsumerStatefulWidget {
  const AdminSystemHealth({super.key});

  @override
  ConsumerState<AdminSystemHealth> createState() => _AdminSystemHealthState();
}

class _AdminSystemHealthState extends ConsumerState<AdminSystemHealth> {
  DateTime _lastChecked = DateTime.now();

  static const _services = [
    _Service('Firebase Auth', '99.98%', '42ms', 'Operational'),
    _Service('Firestore Database', '99.95%', '87ms', 'Operational'),
    _Service('Firebase Storage', '100.00%', '124ms', 'Operational'),
    _Service('Firebase Hosting', '100.00%', '18ms', 'Operational'),
    _Service('Cloud Functions', '99.72%', '310ms', 'Degraded'),
    _Service('Peach Payments', '99.99%', '55ms', 'Operational'),
  ];

  static const _incidents = [
    _Incident('17 Mar 2026', 'Cloud Functions cold-start latency spike', '43 min', true),
    _Incident('08 Mar 2026', 'Firestore read quota warning', '12 min', true),
    _Incident('22 Feb 2026', 'Firebase Storage upload timeout (batch)', '1h 8 min', true),
  ];

  void _refresh() => setState(() => _lastChecked = DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('System Health', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
        actions: [
          IconButton(icon: const Icon(Icons.refresh_rounded, color: HireIQTheme.primaryTeal), onPressed: _refresh, tooltip: 'Refresh'),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Status banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: HireIQTheme.success.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
              border: Border.all(color: HireIQTheme.success.withValues(alpha: 0.3)),
            ),
            child: Row(children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: HireIQTheme.success.withValues(alpha: 0.12), shape: BoxShape.circle),
                child: const Icon(Icons.check_circle_rounded, color: HireIQTheme.success, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('All Systems Operational', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.success)),
                Text('Last checked: ${_lastChecked.hour.toString().padLeft(2, '0')}:${_lastChecked.minute.toString().padLeft(2, '0')}:${_lastChecked.second.toString().padLeft(2, '0')}',
                    style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
              ])),
            ]),
          ),
          const SizedBox(height: 24),

          Text('Services', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 12),
          ...List.generate(_services.length, (i) {
            final s = _services[i];
            final isOp = s.status == 'Operational';
            final statusColor = isOp ? HireIQTheme.success : HireIQTheme.warning;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(color: HireIQTheme.borderLight),
                boxShadow: [BoxShadow(color: HireIQTheme.primaryNavy.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: Row(children: [
                Container(width: 8, height: 8, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                const SizedBox(width: 12),
                Expanded(child: Text(s.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary))),
                _StatChip('↑ ${s.uptime}', HireIQTheme.success),
                const SizedBox(width: 6),
                _StatChip('⚡ ${s.responseTime}', HireIQTheme.textMuted),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
                  child: Text(s.status, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: statusColor)),
                ),
              ]),
            );
          }),
          const SizedBox(height: 24),

          Text('Recent Incidents', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
          const SizedBox(height: 12),
          ..._incidents.map((inc) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: HireIQTheme.surfaceWhite,
              borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
              border: Border.all(color: HireIQTheme.borderLight),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text(inc.title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary))),
                if (inc.resolved)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(color: HireIQTheme.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
                    child: Text('Resolved', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: HireIQTheme.success)),
                  ),
              ]),
              const SizedBox(height: 4),
              Row(children: [
                const Icon(Icons.calendar_today_outlined, size: 11, color: HireIQTheme.textMuted),
                const SizedBox(width: 4),
                Text(inc.date, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                const SizedBox(width: 10),
                const Icon(Icons.timer_outlined, size: 11, color: HireIQTheme.textMuted),
                const SizedBox(width: 4),
                Text('Resolved in ${inc.resolutionTime}', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
              ]),
            ]),
          )),
        ]),
      ),
    );
  }
}

class _Service {
  const _Service(this.name, this.uptime, this.responseTime, this.status);
  final String name, uptime, responseTime, status;
}

class _Incident {
  const _Incident(this.date, this.title, this.resolutionTime, this.resolved);
  final String date, title, resolutionTime;
  final bool resolved;
}

Widget _StatChip(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)),
    child: Text(label, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
  );
}
