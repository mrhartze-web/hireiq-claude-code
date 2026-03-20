import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class RecruiterSettings extends ConsumerStatefulWidget {
  const RecruiterSettings({super.key});

  @override
  ConsumerState<RecruiterSettings> createState() => _RecruiterSettingsState();
}

class _RecruiterSettingsState extends ConsumerState<RecruiterSettings> {
  bool _emailAlerts = true;
  bool _smsAlerts = false;
  bool _publicProfile = true;
  bool _autoRecommend = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('Settings',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile
            _SectionHeader('Account Details'),
            const SizedBox(height: 12),
            _InfoCard(children: [
              _InfoRow(Icons.person_outline_rounded, 'Full Name', 'Nomvula Dlamini'),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              _InfoRow(Icons.email_outlined, 'Email', 'nomvula@agentflow.co.za'),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              _InfoRow(Icons.phone_outlined, 'Mobile', '082 555 4312'),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              _InfoRow(Icons.business_outlined, 'Agency', 'AgentFlow Recruitment'),
            ]),
            const SizedBox(height: 24),

            _SectionHeader('Notifications'),
            const SizedBox(height: 12),
            _InfoCard(children: [
              _ToggleRow('Email Alerts', _emailAlerts, (v) => setState(() => _emailAlerts = v)),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              _ToggleRow('SMS Alerts', _smsAlerts, (v) => setState(() => _smsAlerts = v)),
            ]),
            const SizedBox(height: 24),

            _SectionHeader('Profile & AI'),
            const SizedBox(height: 12),
            _InfoCard(children: [
              _ToggleRow('Public Recruiter Profile', _publicProfile, (v) => setState(() => _publicProfile = v)),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              _ToggleRow('MatchIQ Auto-Recommendations', _autoRecommend, (v) => setState(() => _autoRecommend = v)),
            ]),
            const SizedBox(height: 24),

            _SectionHeader('Danger Zone'),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(color: HireIQTheme.error.withValues(alpha: 0.25)),
              ),
              child: ListTile(
                onTap: () {},
                leading: const Icon(Icons.logout_rounded, color: HireIQTheme.error),
                title: Text('Sign Out', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: HireIQTheme.error)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted));
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [BoxShadow(color: HireIQTheme.primaryNavy.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 3))],
      ),
      child: Column(children: children),
    );
  }
}

Widget _InfoRow(IconData icon, String label, String value) {
  return Padding(
    padding: const EdgeInsets.all(14),
    child: Row(
      children: [
        Icon(icon, size: 16, color: HireIQTheme.textMuted),
        const SizedBox(width: 12),
        Text(label, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)),
        const Spacer(),
        Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.primaryNavy)),
      ],
    ),
  );
}

Widget _ToggleRow(String label, bool value, ValueChanged<bool> onChanged) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    child: Row(
      children: [
        Expanded(child: Text(label, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: HireIQTheme.textPrimary))),
        Switch(value: value, onChanged: onChanged, activeColor: HireIQTheme.primaryTeal),
      ],
    ),
  );
}
