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
