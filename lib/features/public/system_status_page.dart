import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/components/web_layout.dart';
import '../../shared/theme.dart';

// ── Service data ──────────────────────────────────────────────────────────────

class _Service {
  const _Service({required this.name, required this.icon});
  final String name;
  final IconData icon;
}

const _services = <_Service>[
  _Service(name: 'API', icon: Icons.api_outlined),
  _Service(name: 'Authentication', icon: Icons.lock_outline_rounded),
  _Service(name: 'Database', icon: Icons.storage_outlined),
  _Service(name: 'File Storage', icon: Icons.folder_outlined),
  _Service(name: 'Push Notifications', icon: Icons.notifications_outlined),
  _Service(name: 'Payment Processing', icon: Icons.credit_card_outlined),
];

// ── Page ──────────────────────────────────────────────────────────────────────

class SystemStatusPage extends StatelessWidget {
  const SystemStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Wordmark ──────────────────────────────────────────────
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Hire',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: HireIQTheme.primaryNavy,
                        letterSpacing: -0.5,
                      ),
                    ),
                    TextSpan(
                      text: 'IQ',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: HireIQTheme.primaryTeal,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ]),
                ),

                const SizedBox(height: 28),

                // ── Heading + badge ───────────────────────────────────────
                Text(
                  'System Status',
                  style: GoogleFonts.inter(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.textPrimary,
                    letterSpacing: -1.0,
                    height: 1.1,
                  ),
                ),

                const SizedBox(height: 16),

                // All Operational badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: HireIQTheme.successLight,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: HireIQTheme.success.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: HireIQTheme.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'All Systems Operational',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF15803D),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // ── Services card ─────────────────────────────────────────
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: HireIQTheme.surfaceWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: HireIQTheme.borderLight),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card header
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                        child: Row(
                          children: [
                            Text(
                              'Services',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: HireIQTheme.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${_services.length}/${_services.length} operational',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF15803D),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Divider(height: 1),

                      // Service rows
                      ...List.generate(_services.length, (i) {
                        final service = _services[i];
                        final isLast = i == _services.length - 1;
                        return _ServiceRow(
                          service: service,
                          showDivider: !isLast,
                        );
                      }),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // ── Incident history ──────────────────────────────────────
                const _IncidentHistoryCard(),

                const SizedBox(height: 32),

                // ── Last updated ──────────────────────────────────────────
                _LastUpdatedRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Service row ───────────────────────────────────────────────────────────────

class _ServiceRow extends StatelessWidget {
  const _ServiceRow({
    required this.service,
    required this.showDivider,
  });

  final _Service service;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              // Service icon
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: HireIQTheme.backgroundLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  service.icon,
                  size: 18,
                  color: HireIQTheme.textMuted,
                ),
              ),

              const SizedBox(width: 14),

              // Name
              Expanded(
                child: Text(
                  service.name,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: HireIQTheme.textPrimary,
                  ),
                ),
              ),

              // Status indicator
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: HireIQTheme.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Operational',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF15803D),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (showDivider)
          const Divider(height: 1, indent: 24, endIndent: 24),
      ],
    );
  }
}

// ── Incident history ──────────────────────────────────────────────────────────

class _Incident {
  const _Incident({
    required this.date,
    required this.title,
    required this.description,
    required this.resolved,
  });
  final String date;
  final String title;
  final String description;
  final bool resolved;
}

const _incidents = <_Incident>[
  _Incident(
    date: '14 Mar 2026',
    title: 'Payment Processing — Elevated Latency',
    description: 'Some users experienced slow response times on PayFast checkout. Root cause identified as upstream gateway congestion. Resolved within 38 minutes.',
    resolved: true,
  ),
  _Incident(
    date: '02 Feb 2026',
    title: 'Push Notifications — Delayed Delivery',
    description: 'FCM delivery delays of up to 12 minutes affected candidate job-match alerts. Firebase infrastructure issue. All notifications delivered after resolution.',
    resolved: true,
  ),
  _Incident(
    date: '09 Jan 2026',
    title: 'Authentication — Intermittent Login Failures',
    description: 'A subset of social-auth (Google/LinkedIn) logins failed for approximately 25 minutes. Caused by an expired OAuth callback config. Fixed and verified.',
    resolved: true,
  ),
  _Incident(
    date: '18 Nov 2025',
    title: 'File Storage — CV Upload Timeout',
    description: 'CV uploads above 5 MB timed out for roughly 2 hours due to a misconfigured Cloud Storage CORS policy. Policy corrected and uploads restored.',
    resolved: true,
  ),
  _Incident(
    date: '03 Oct 2025',
    title: 'Database — Read Latency Spike',
    description: 'Firestore read times spiked for candidate job-feed queries during peak hours. Index optimisation applied within 55 minutes. No data loss occurred.',
    resolved: true,
  ),
  _Incident(
    date: '22 Aug 2025',
    title: 'API — MatchIQ Scoring Unavailable',
    description: 'MatchIQ scoring endpoint returned 503 for 18 minutes following a cold-start failure in Cloud Functions. Function warmed and service restored.',
    resolved: true,
  ),
  _Incident(
    date: '11 Jul 2025',
    title: 'API — Planned Maintenance Window',
    description: 'Scheduled 45-minute maintenance to upgrade Firestore indexes and deploy SignalIQ v2 engine. Completed ahead of schedule with no unplanned downtime.',
    resolved: true,
  ),
];

class _IncidentHistoryCard extends StatelessWidget {
  const _IncidentHistoryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
            child: Text(
              'Past Incidents',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: HireIQTheme.textPrimary,
              ),
            ),
          ),
          const Divider(height: 1),
          ..._incidents.asMap().entries.map((entry) {
            final i = entry.key;
            final incident = entry.value;
            final isLast = i == _incidents.length - 1;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          color: incident.resolved
                              ? HireIQTheme.success
                              : HireIQTheme.warning,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    incident.title,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: HireIQTheme.textPrimary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  incident.date,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: HireIQTheme.textLight,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              incident.description,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: HireIQTheme.textMuted,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: incident.resolved
                                    ? HireIQTheme.successLight
                                    : HireIQTheme.warningLight,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                incident.resolved ? 'Resolved' : 'Monitoring',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: incident.resolved
                                      ? const Color(0xFF15803D)
                                      : HireIQTheme.warning,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  const Divider(height: 1, indent: 46, endIndent: 20),
              ],
            );
          }),
        ],
      ),
    );
  }
}

// ── Last updated ──────────────────────────────────────────────────────────────

class _LastUpdatedRow extends StatelessWidget {
  _LastUpdatedRow();

  final DateTime _now = DateTime.now();

  String get _formatted {
    final h = _now.hour.toString().padLeft(2, '0');
    final m = _now.minute.toString().padLeft(2, '0');
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${_now.day} ${months[_now.month - 1]} ${_now.year}, $h:$m';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.refresh_rounded,
          size: 15,
          color: HireIQTheme.textLight,
        ),
        const SizedBox(width: 6),
        Text(
          'Last updated: $_formatted',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: HireIQTheme.textLight,
          ),
        ),
      ],
    );
  }
}
