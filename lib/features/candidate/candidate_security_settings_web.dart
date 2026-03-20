import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateSecuritySettingsWeb extends ConsumerStatefulWidget {
  const CandidateSecuritySettingsWeb({super.key});
  @override
  ConsumerState<CandidateSecuritySettingsWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateSecuritySettingsWeb> {
  bool _mfa = true;

  static const _sessions = [
    _Session('Chrome · macOS', 'Cape Town, SA', 'Now', true),
    _Session('Safari · iPhone 15', 'Cape Town, SA', '2h ago', false),
    _Session('Firefox · Windows', 'Johannesburg, SA', '3 days ago', false),
  ];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Security', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Protect your HireIQ account', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 28),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left
            Expanded(child: Column(children: [
              // Password
              _SecCard('Change Password', Column(children: [
                TextField(obscureText: true, controller: TextEditingController(text: '•••••••••••'), decoration: InputDecoration(labelText: 'Current Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14), suffixIcon: const Icon(Icons.visibility_off_rounded, size: 16))),
                const SizedBox(height: 12),
                TextField(obscureText: true, decoration: InputDecoration(labelText: 'New Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14), suffixIcon: const Icon(Icons.visibility_off_rounded, size: 16))),
                const SizedBox(height: 12),
                TextField(obscureText: true, decoration: InputDecoration(labelText: 'Confirm New Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14))),
                const SizedBox(height: 16),
                Align(alignment: Alignment.centerLeft, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Update Password', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)))),
              ])),
              const SizedBox(height: 18),
              // MFA
              _SecCard('Two-Factor Authentication', Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(_mfa ? '2FA is enabled' : '2FA is disabled', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: _mfa ? HireIQTheme.success : HireIQTheme.error)),
                  Text('Add an extra layer of security with an authenticator app', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                ])),
                Switch(value: _mfa, onChanged: (v) => setState(() => _mfa = v), activeTrackColor: HireIQTheme.primaryTeal),
              ])),
            ])),
            const SizedBox(width: 24),
            // Right: sessions
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(padding: const EdgeInsets.fromLTRB(20, 18, 20, 14), child: Row(children: [
                    Text('Active Sessions', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                    const Spacer(),
                    TextButton(onPressed: () {}, child: Text('Sign out all', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: HireIQTheme.error))),
                  ])),
                  const Divider(height: 1, color: HireIQTheme.borderLight),
                  ..._sessions.asMap().entries.map((e) {
                    final s = e.value;
                    final isLast = e.key == _sessions.length - 1;
                    return Column(children: [
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), child: Row(children: [
                        Container(width: 38, height: 38, decoration: BoxDecoration(color: s.current ? HireIQTheme.success.withValues(alpha: 0.1) : HireIQTheme.background, shape: BoxShape.circle), child: Icon(Icons.devices_rounded, color: s.current ? HireIQTheme.success : HireIQTheme.textMuted, size: 20)),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [Text(s.device, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)), if (s.current) Container(margin: const EdgeInsets.only(left: 8), padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: HireIQTheme.success.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('Current', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: HireIQTheme.success)))]),
                          Text('${s.location} · ${s.lastSeen}', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                        ])),
                        if (!s.current) TextButton(onPressed: () {}, child: Text('Revoke', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.error, fontWeight: FontWeight.w600))),
                      ])),
                      if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                    ]);
                  }),
                ]),
              ),
              const SizedBox(height: 18),
              // Security score
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Account Security Score', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                  const SizedBox(height: 12),
                  Row(children: [
                    Text('85%', style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w900, color: HireIQTheme.success)),
                    const SizedBox(width: 12),
                    Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull), child: const LinearProgressIndicator(value: 0.85, minHeight: 12, backgroundColor: HireIQTheme.borderLight, valueColor: AlwaysStoppedAnimation<Color>(HireIQTheme.success)))),
                  ]),
                  const SizedBox(height: 8),
                  Text('Enable 2FA and remove inactive sessions to reach 100%.', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                ]),
              ),
            ])),
          ]),
        ]),
      ),
    );
  }
}

class _Session {
  const _Session(this.device, this.location, this.lastSeen, this.current);
  final String device, location, lastSeen;
  final bool current;
}

Widget _SecCard(String title, Widget child) => Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)), const Divider(height: 20, color: HireIQTheme.borderLight), child]));
