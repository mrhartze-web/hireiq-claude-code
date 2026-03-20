import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class RecruiterSettingsWeb extends ConsumerStatefulWidget {
  const RecruiterSettingsWeb({super.key});
  @override
  ConsumerState<RecruiterSettingsWeb> createState() => _State();
}

class _State extends ConsumerState<RecruiterSettingsWeb> {
  int _cat = 0;
  bool _emailNotif = true;
  bool _smsNotif = false;
  bool _briefAlerts = true;
  bool _matchAlerts = true;
  bool _weeklyReport = true;

  final _cats = ['Profile', 'Notifications', 'Security', 'Billing', 'Agency'];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left nav
          SizedBox(width: 220, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Settings', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 20),
            ..._cats.asMap().entries.map((e) {
              final isActive = e.key == _cat;
              return GestureDetector(
                onTap: () => setState(() => _cat = e.key),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(color: isActive ? HireIQTheme.primaryNavy : Colors.transparent, borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)),
                  child: Row(children: [
                    Icon([Icons.person_outline_rounded, Icons.notifications_outlined, Icons.lock_outline_rounded, Icons.receipt_long_outlined, Icons.business_outlined][e.key], size: 16, color: isActive ? Colors.white : HireIQTheme.textMuted),
                    const SizedBox(width: 10),
                    Text(e.value, style: GoogleFonts.inter(fontSize: 13, fontWeight: isActive ? FontWeight.w700 : FontWeight.w500, color: isActive ? Colors.white : HireIQTheme.textMuted)),
                  ]),
                ),
              );
            }),
          ])),
          const SizedBox(width: 24),
          // Right content
          Expanded(child: IndexedStack(index: _cat, children: [
            // Profile
            _SCard('Personal Information', Column(children: [
              Row(children: [Expanded(child: _SF('First Name', 'Lindiwe')), const SizedBox(width: 16), Expanded(child: _SF('Last Name', 'Hadebe'))]),
              const SizedBox(height: 16),
              _SF('Email Address', 'lindiwe@recruiter.co.za'),
              const SizedBox(height: 16),
              _SF('Phone', '+27 82 000 5678'),
              const SizedBox(height: 16),
              _SF('Agency / Company', 'TalentForce Recruitment'),
              const SizedBox(height: 20),
              Align(alignment: Alignment.centerLeft, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Save Changes', style: GoogleFonts.inter(fontWeight: FontWeight.w700)))),
            ])),
            // Notifications
            _SCard('Notification Preferences', Column(children: [
              _SToggle('Email notifications', 'Receive updates via email', _emailNotif, (v) => setState(() => _emailNotif = v)),
              _SToggle('SMS notifications', 'Receive urgent alerts via SMS', _smsNotif, (v) => setState(() => _smsNotif = v)),
              const Divider(color: HireIQTheme.borderLight, height: 28),
              _SToggle('Brief alerts', 'New briefs matching your expertise', _briefAlerts, (v) => setState(() => _briefAlerts = v)),
              _SToggle('Candidate match alerts', 'When a new candidate matches an open brief', _matchAlerts, (v) => setState(() => _matchAlerts = v)),
              _SToggle('Weekly performance report', 'Summary of your KPIs every Monday', _weeklyReport, (v) => setState(() => _weeklyReport = v)),
            ])),
            // Security
            _SCard('Security', Column(children: [
              _SF('Current Password', '', obscure: true),
              const SizedBox(height: 16),
              _SF('New Password', '', obscure: true),
              const SizedBox(height: 16),
              _SF('Confirm New Password', '', obscure: true),
              const SizedBox(height: 20),
              Align(alignment: Alignment.centerLeft, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.primaryNavy, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Update Password', style: GoogleFonts.inter(fontWeight: FontWeight.w700)))),
            ])),
            // Billing
            _SCard('Billing', Text('Manage your subscription from the Earnings Dashboard.', style: GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textMuted))),
            // Agency
            _SCard('Agency Details', Column(children: [
              _SF('Agency Name', 'TalentForce Recruitment'),
              const SizedBox(height: 16),
              _SF('Registration Number', 'REG-2023-0012'),
              const SizedBox(height: 16),
              _SF('Website', 'talentforce.co.za'),
              const SizedBox(height: 20),
              Align(alignment: Alignment.centerLeft, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Save', style: GoogleFonts.inter(fontWeight: FontWeight.w700)))),
            ])),
          ])),
        ]),
      ),
    );
  }
}

Widget _SCard(String title, Widget child) => Container(padding: const EdgeInsets.all(28), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)), const SizedBox(height: 22), child]));
Widget _SF(String l, String val, {bool obscure = false}) => TextField(obscureText: obscure, controller: TextEditingController(text: val), decoration: InputDecoration(labelText: l, labelStyle: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted), border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14)));
Widget _SToggle(String title, String sub, bool val, ValueChanged<bool> onChanged) => Padding(padding: const EdgeInsets.only(bottom: 14), child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)), Text(sub, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))])), Switch(value: val, onChanged: onChanged, activeTrackColor: HireIQTheme.primaryTeal)]));
