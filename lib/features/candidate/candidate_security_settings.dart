import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateSecuritySettings extends ConsumerStatefulWidget {
  const CandidateSecuritySettings({super.key});

  @override
  ConsumerState<CandidateSecuritySettings> createState() =>
      _CandidateSecuritySettingsState();
}

class _CandidateSecuritySettingsState
    extends ConsumerState<CandidateSecuritySettings> {
  bool _twoFAEnabled = false;

  static const _sessions = [
    _Session(
        device: 'Chrome on MacBook Pro',
        location: 'Johannesburg, SA',
        lastActive: '2 minutes ago',
        isCurrent: true),
    _Session(
        device: 'HireIQ App on iPhone 15',
        location: 'Cape Town, SA',
        lastActive: '1 day ago',
        isCurrent: false),
    _Session(
        device: 'Firefox on Windows',
        location: 'Pretoria, SA',
        lastActive: '3 days ago',
        isCurrent: false),
  ];

  static const _loginHistory = [
    _LoginEntry(
        date: '20 Mar 2026, 03:10',
        device: 'Chrome on MacBook',
        location: 'Johannesburg, SA',
        status: 'Success'),
    _LoginEntry(
        date: '18 Mar 2026, 09:22',
        device: 'iPhone 15',
        location: 'Cape Town, SA',
        status: 'Success'),
    _LoginEntry(
        date: '15 Mar 2026, 14:05',
        device: 'Firefox on Windows',
        location: 'Pretoria, SA',
        status: 'Success'),
    _LoginEntry(
        date: '12 Mar 2026, 19:43',
        device: 'Unknown device',
        location: 'Durban, SA',
        status: 'Failed'),
    _LoginEntry(
        date: '10 Mar 2026, 08:11',
        device: 'Chrome on MacBook',
        location: 'Johannesburg, SA',
        status: 'Success'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Security',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Change Password ───────────────────────────────────────────
            _SectionHeader('Change Password'),
            const SizedBox(height: 12),
            _buildCard(
              child: Column(
                children: [
                  _PasswordField('Current Password'),
                  const Divider(height: 24, color: HireIQTheme.borderLight),
                  _PasswordField('New Password'),
                  const Divider(height: 24, color: HireIQTheme.borderLight),
                  _PasswordField('Confirm New Password'),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HireIQTheme.primaryNavy,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                HireIQTheme.radiusMd)),
                      ),
                      child: Text(
                        'Update Password',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Two-Factor Auth ───────────────────────────────────────────
            _SectionHeader('Two-Factor Authentication'),
            const SizedBox(height: 12),
            _buildCard(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (_twoFAEnabled
                              ? HireIQTheme.success
                              : HireIQTheme.primaryNavy)
                          .withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.phonelink_lock_rounded,
                      size: 22,
                      color: _twoFAEnabled
                          ? HireIQTheme.success
                          : HireIQTheme.primaryNavy,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '2-Factor Authentication',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: HireIQTheme.primaryNavy),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _twoFAEnabled
                              ? 'Active — your account is protected'
                              : 'Adds an extra layer of security to your account',
                          style: GoogleFonts.inter(
                              fontSize: 12, color: HireIQTheme.textMuted),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _twoFAEnabled,
                    onChanged: (v) => setState(() => _twoFAEnabled = v),
                    activeColor: HireIQTheme.primaryTeal,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Active Sessions ───────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _SectionHeader('Active Sessions'),
                GestureDetector(
                  onTap: _showSignOutAllDialog,
                  child: Text(
                    'Sign out all',
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: HireIQTheme.error),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildCard(
              child: Column(
                children: _sessions.asMap().entries.map((e) {
                  final isLast = e.key == _sessions.length - 1;
                  return Column(
                    children: [
                      _SessionRow(session: e.value),
                      if (!isLast)
                        const Divider(
                            height: 1, color: HireIQTheme.borderLight),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // ── Login History ─────────────────────────────────────────────
            _SectionHeader('Recent Login Activity'),
            const SizedBox(height: 12),
            _buildCard(
              child: Column(
                children: _loginHistory.asMap().entries.map((e) {
                  final isLast = e.key == _loginHistory.length - 1;
                  return Column(
                    children: [
                      _LoginHistoryRow(entry: e.value),
                      if (!isLast)
                        const Divider(
                            height: 1, color: HireIQTheme.borderLight),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  void _showSignOutAllDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Sign out all devices?',
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
        content: Text(
          'You\'ll be signed out of all devices. You\'ll need to log in again on each device.',
          style: GoogleFonts.inter(color: HireIQTheme.textMuted, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel',
                style: GoogleFonts.inter(color: HireIQTheme.textMuted)),
          ),
          OutlinedButton(
            onPressed: () => Navigator.pop(ctx),
            style: OutlinedButton.styleFrom(
                foregroundColor: HireIQTheme.error,
                side: const BorderSide(color: HireIQTheme.error)),
            child: Text('Sign out all',
                style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _Session {
  const _Session({
    required this.device,
    required this.location,
    required this.lastActive,
    required this.isCurrent,
  });

  final String device;
  final String location;
  final String lastActive;
  final bool isCurrent;
}

class _LoginEntry {
  const _LoginEntry({
    required this.date,
    required this.device,
    required this.location,
    required this.status,
  });

  final String date;
  final String device;
  final String location;
  final String status;
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: HireIQTheme.textMuted),
    );
  }
}

class _PasswordField extends StatefulWidget {
  const _PasswordField(this.label);
  final String label;

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: HireIQTheme.textPrimary),
              ),
              const SizedBox(height: 6),
              TextFormField(
                obscureText: _obscure,
                style: GoogleFonts.inter(
                    fontSize: 14, color: HireIQTheme.textPrimary),
                decoration: InputDecoration(
                  hintText: '••••••••',
                  hintStyle: GoogleFonts.inter(color: HireIQTheme.textMuted),
                  filled: true,
                  fillColor: HireIQTheme.background,
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 18,
                        color: HireIQTheme.textMuted),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                    borderSide: const BorderSide(color: HireIQTheme.borderLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                    borderSide: const BorderSide(color: HireIQTheme.borderLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                    borderSide: const BorderSide(
                        color: HireIQTheme.primaryTeal, width: 1.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SessionRow extends StatelessWidget {
  const _SessionRow({required this.session});
  final _Session session;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (session.isCurrent
                      ? HireIQTheme.primaryTeal
                      : HireIQTheme.primaryNavy)
                  .withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusSm),
            ),
            child: Icon(
              session.device.contains('iPhone')
                  ? Icons.phone_iphone_rounded
                  : Icons.computer_rounded,
              size: 18,
              color: session.isCurrent
                  ? HireIQTheme.primaryTeal
                  : HireIQTheme.textMuted,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        session.device,
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: HireIQTheme.primaryNavy),
                      ),
                    ),
                    if (session.isCurrent)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: HireIQTheme.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(
                              HireIQTheme.radiusFull),
                        ),
                        child: Text(
                          'Current',
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: HireIQTheme.success),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${session.location} • ${session.lastActive}',
                  style: GoogleFonts.inter(
                      fontSize: 11, color: HireIQTheme.textMuted),
                ),
              ],
            ),
          ),
          if (!session.isCurrent)
            GestureDetector(
              onTap: () {},
              child: Text(
                'Sign out',
                style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: HireIQTheme.error),
              ),
            ),
        ],
      ),
    );
  }
}

class _LoginHistoryRow extends StatelessWidget {
  const _LoginHistoryRow({required this.entry});
  final _LoginEntry entry;

  @override
  Widget build(BuildContext context) {
    final isSuccess = entry.status == 'Success';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isSuccess ? HireIQTheme.success : HireIQTheme.error,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.device,
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: HireIQTheme.textPrimary),
                ),
                Text(
                  '${entry.location} • ${entry.date}',
                  style: GoogleFonts.inter(
                      fontSize: 11, color: HireIQTheme.textMuted),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: (isSuccess ? HireIQTheme.success : HireIQTheme.error)
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
            ),
            child: Text(
              entry.status,
              style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color:
                      isSuccess ? HireIQTheme.success : HireIQTheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
