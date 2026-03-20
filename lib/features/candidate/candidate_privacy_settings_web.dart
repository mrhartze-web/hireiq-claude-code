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
  int _selectedCat = 0;
  final Map<String, bool> _toggles = {
    'profilePublic': true,
    'showSalary': false,
    'showLocation': true,
    'passportBadge': true,
    'shareAnalytics': false,
    'allowRecruiterContact': true,
    'marketingEmails': false,
    'jobAlerts': true,
    'weeklyDigest': true,
  };

  static const _categories = ['Profile Visibility', 'Data Sharing', 'Communications', 'Data Rights'];

  static const _settings = <String, List<_PToggle>>{
    'Profile Visibility': [
      _PToggle('profilePublic', 'Public Profile', 'Your profile is visible to all registered employers and recruiters on HireIQ.'),
      _PToggle('showSalary', 'Display Salary Expectations', 'Show your target salary range on your public profile.'),
      _PToggle('showLocation', 'Display Location', 'Show your city and province on your public profile.'),
      _PToggle('passportBadge', 'Show PassportIQ Badge', 'Display your PassportIQ verification status on your profile.'),
    ],
    'Data Sharing': [
      _PToggle('shareAnalytics', 'Share Usage Analytics', 'Help HireIQ improve by sharing anonymised usage data.'),
      _PToggle('allowRecruiterContact', 'Allow Recruiter Direct Contact', 'Allow recruiters to send you direct messages even without applying.'),
    ],
    'Communications': [
      _PToggle('marketingEmails', 'Marketing Emails', 'Receive product updates, tips and promotions via email.'),
      _PToggle('jobAlerts', 'Job Match Alerts', 'Receive email alerts when new jobs match your profile.'),
      _PToggle('weeklyDigest', 'Weekly Digest', 'A weekly summary of applications, matches, and activity.'),
    ],
    'Data Rights': [],
  };

  @override
  Widget build(BuildContext context) {
    final cat = _categories[_selectedCat];
    final items = _settings[cat] ?? [];

    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Privacy Settings', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Manage how your data is used and shared on HireIQ', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: category nav
            SizedBox(width: 220, child: Container(
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(children: _categories.asMap().entries.map((e) {
                final sel = _selectedCat == e.key;
                return InkWell(
                  onTap: () => setState(() => _selectedCat = e.key),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    decoration: BoxDecoration(color: sel ? HireIQTheme.primaryNavy.withValues(alpha: 0.05) : null, border: Border(left: BorderSide(color: sel ? HireIQTheme.primaryTeal : Colors.transparent, width: 3))),
                    child: Text(e.value, style: GoogleFonts.inter(fontSize: 13, fontWeight: sel ? FontWeight.w700 : FontWeight.w500, color: sel ? HireIQTheme.primaryNavy : HireIQTheme.textMuted)),
                  ),
                );
              }).toList()),
            )),
            const SizedBox(width: 24),
            // Right: settings toggles
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (items.isEmpty && cat == 'Data Rights') ...[
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Your Data Rights', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                    const SizedBox(height: 14),
                    ...[
                      ('Download My Data', 'Export a copy of all personal data stored on HireIQ.', Icons.download_rounded, HireIQTheme.info),
                      ('Delete My Account', 'Permanently delete your account and all associated data.', Icons.delete_rounded, HireIQTheme.error),
                    ].map((a) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: HireIQTheme.background, borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.borderLight)), child: Row(children: [
                      Icon(a.$3, color: a.$4, size: 20),
                      const SizedBox(width: 14),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(a.$1, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)), Text(a.$2, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))])),
                      ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: a.$4.withValues(alpha: 0.1), foregroundColor: a.$4, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text(a.$1.split(' ').first, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700))),
                    ])))),
                  ]),
                ),
              ] else ...[
                Container(
                  decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                  child: Column(children: items.asMap().entries.map((e) {
                    final item = e.value;
                    final isLast = e.key == items.length - 1;
                    return Column(children: [
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18), child: Row(children: [
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(item.label, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)),
                          const SizedBox(height: 4),
                          Text(item.description, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.4)),
                        ])),
                        Switch(value: _toggles[item.key] ?? false, onChanged: (v) => setState(() => _toggles[item.key] = v), activeTrackColor: HireIQTheme.primaryTeal),
                      ])),
                      if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                    ]);
                  }).toList()),
                ),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Save Changes', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700))),
              ],
              const SizedBox(height: 16),
              Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: HireIQTheme.info.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.info.withValues(alpha: 0.2))), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.info_rounded, color: HireIQTheme.info, size: 16), const SizedBox(width: 8), Expanded(child: Text('HireIQ is fully POPIA compliant. Your data is always protected in accordance with South African data privacy law.', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted, height: 1.4)))])),
            ])),
          ]),
        ]),
      ),
    );
  }
}

class _PToggle {
  const _PToggle(this.key, this.label, this.description);
  final String key, label, description;
}
