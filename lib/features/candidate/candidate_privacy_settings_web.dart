import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidatePrivacySettingsWeb extends ConsumerStatefulWidget {
  const CandidatePrivacySettingsWeb({super.key});
  @override
  ConsumerState<CandidatePrivacySettingsWeb> createState() => _State();
}

class _State extends ConsumerState<CandidatePrivacySettingsWeb> {
  String _selected = 'Profile Visibility';
  bool _publicProfile = true, _showSalary = false, _showContact = false, _allowSearch = true, _allowMessages = true, _showActivity = false;

  final _categories = ['Profile Visibility', 'Job Search', 'Communications', 'Data & Privacy'];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Privacy Settings', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Control how your information is shared on HireIQ', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 32),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left nav
            SizedBox(width: 220, child: Container(
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(children: _categories.asMap().entries.map((e) {
                final cat = e.value;
                final isActive = cat == _selected;
                final isLast = e.key == _categories.length - 1;
                return Column(children: [
                  InkWell(
                    onTap: () => setState(() => _selected = cat),
                    child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), decoration: BoxDecoration(color: isActive ? HireIQTheme.primaryNavy.withValues(alpha: 0.05) : null, borderRadius: isActive ? BorderRadius.circular(HireIQTheme.radiusMd) : null),
                      child: Row(children: [
                        Expanded(child: Text(cat, style: GoogleFonts.inter(fontSize: 13, fontWeight: isActive ? FontWeight.w700 : FontWeight.w500, color: isActive ? HireIQTheme.primaryNavy : HireIQTheme.textMuted))),
                        if (isActive) const Icon(Icons.chevron_right_rounded, size: 16, color: HireIQTheme.primaryNavy),
                      ]),
                    ),
                  ),
                  if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                ]);
              }).toList()),
            )),
            const SizedBox(width: 24),
            // Right content
            Expanded(child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(_selected, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 20),
                if (_selected == 'Profile Visibility') ...[
                  _TogRow('Public Profile', 'Show your profile to employers and recruiters', _publicProfile, (v) => setState(() => _publicProfile = v)),
                  _TogRow('Show Current Salary', 'Display salary expectations on your profile', _showSalary, (v) => setState(() => _showSalary = v)),
                  _TogRow('Show Contact Info', 'Allow direct contact via email and phone', _showContact, (v) => setState(() => _showContact = v)),
                  _TogRow('Show Activity', 'Show when you were last active', _showActivity, (v) => setState(() => _showActivity = v)),
                ] else if (_selected == 'Job Search') ...[
                  _TogRow('Appear in Search', 'Allow recruiters to find your profile', _allowSearch, (v) => setState(() => _allowSearch = v)),
                  _TogRow('Allow Messages', 'Receive messages from recruiters', _allowMessages, (v) => setState(() => _allowMessages = v)),
                ] else ...[
                  _TogRow('Email Notifications', 'Receive job matches and updates by email', true, (_) {}),
                  _TogRow('WhatsApp Alerts', 'Get urgent notifications via WhatsApp', false, (_) {}),
                ],
                const SizedBox(height: 24),
                ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Save Changes', style: GoogleFonts.inter(fontWeight: FontWeight.w700))),
              ]),
            )),
          ]),
        ]),
      ),
    );
  }
}

Widget _TogRow(String title, String subtitle, bool value, ValueChanged<bool> cb) => Padding(
  padding: const EdgeInsets.only(bottom: 20),
  child: Row(children: [
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)),
      Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
    ])),
    Switch(value: value, onChanged: cb, activeTrackColor: HireIQTheme.primaryTeal),
  ]),
);
