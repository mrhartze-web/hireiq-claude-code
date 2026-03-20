import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateSecuritySettingsWeb extends ConsumerWidget {
  const CandidateSecuritySettingsWeb({super.key});

  static const _sessions = [
    _Session('Chrome · macOS', 'Cape Town, SA', '2m ago', true),
    _Session('Safari · iPhone 14', 'Cape Town, SA', '1d ago', false),
    _Session('Chrome · Windows', 'Johannesburg, SA', '5d ago', false),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Security Centre', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)),
          Text('Manage your password and active sessions', style: GoogleFonts.inter(fontSize: 15, color: HireIQTheme.textMuted)),
          const SizedBox(height: 32),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Left: Password + 2FA
            Expanded(child: Column(children: [
              _WebCard('Change Password', [
                _Field('Current Password', true),
                const SizedBox(height: 14),
                _Field('New Password', true),
                const SizedBox(height: 14),
                _Field('Confirm Password', true),
                const SizedBox(height: 20),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.primaryNavy, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))), child: Text('Update Password', style: GoogleFonts.inter(fontWeight: FontWeight.w700)))),
              ]),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    const Icon(Icons.security_rounded, color: HireIQTheme.primaryTeal, size: 20),
                    const SizedBox(width: 8),
                    Text('Two-Factor Authentication', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                    const Spacer(),
                    Switch(value: false, onChanged: (_) {}, activeTrackColor: HireIQTheme.primaryTeal),
                  ]),
                  const SizedBox(height: 8),
                  Text('Add an extra layer of security. When enabled, you\'ll be asked for a verification code on each sign-in.', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)),
                ]),
              ),
            ])),
            const SizedBox(width: 28),
            // Right: Active sessions table
            Expanded(child: Container(
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(children: [
                    Text('Active Sessions', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                    const Spacer(),
                    TextButton(onPressed: () {}, child: Text('Revoke all other sessions', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.error, fontWeight: FontWeight.w600))),
                  ]),
                ),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), color: HireIQTheme.background, child: Row(children: [
                  _STH('Device / Browser', flex: 2), _STH('Location', flex: 2), _STH('Last Active', flex: 2), _STH('', flex: 1),
                ])),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                ..._sessions.asMap().entries.map((e) {
                  final s = e.value;
                  final isLast = e.key == _sessions.length - 1;
                  return Column(children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), child: Row(children: [
                      Expanded(flex: 2, child: Row(children: [
                        Icon(Icons.computer_rounded, size: 16, color: s.isCurrent ? HireIQTheme.primaryTeal : HireIQTheme.textMuted),
                        const SizedBox(width: 8),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(s.device, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: HireIQTheme.textPrimary)),
                          if (s.isCurrent) Text('Current session', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.success)),
                        ])),
                      ])),
                      Expanded(flex: 2, child: Text(s.location, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                      Expanded(flex: 2, child: Text(s.lastActive, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
                      Expanded(child: s.isCurrent ? const SizedBox.shrink() : TextButton(onPressed: () {}, child: Text('Revoke', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.error, fontWeight: FontWeight.w600)))),
                    ])),
                    if (!isLast) const Divider(height: 1, color: HireIQTheme.borderLight),
                  ]);
                }),
              ]),
            )),
          ]),
        ]),
      ),
    );
  }
}

class _Session { const _Session(this.device, this.location, this.lastActive, this.isCurrent); final String device, location, lastActive; final bool isCurrent; }
Widget _STH(String l, {int flex = 1}) => Expanded(flex: flex, child: Text(l, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)));
Widget _Field(String label, bool obscure) => TextField(obscureText: obscure, decoration: InputDecoration(labelText: label, labelStyle: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted), border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14)));
Widget _WebCard(String title, List<Widget> children) => Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)), const SizedBox(height: 20), ...children]));
