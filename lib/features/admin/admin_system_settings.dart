import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class AdminSystemSettings extends ConsumerStatefulWidget {
  const AdminSystemSettings({super.key});

  @override
  ConsumerState<AdminSystemSettings> createState() =>
      _AdminSystemSettingsState();
}

class _AdminSystemSettingsState extends ConsumerState<AdminSystemSettings> {
  // Feature flags
  bool _gigMarketplace = true;
  bool _wildcardIq = true;
  bool _passportIq = true;
  bool _enterpriseMode = false;
  bool _maintenanceMode = false;

  // Business rules
  final _feeCtrl = TextEditingController(text: '20');

  bool _dirty = false;

  void _markDirty() => setState(() => _dirty = true);

  Future<void> _save() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
        title: Text('Save Settings?', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
        content: Text('These changes will take effect immediately across the platform. Are you sure?', style: GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textMuted)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text('Cancel', style: GoogleFonts.inter(color: HireIQTheme.textMuted))),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.amber, foregroundColor: HireIQTheme.primaryNavy, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd))),
            child: Text('Save', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
    if (confirmed == true) setState(() => _dirty = false);
  }

  @override
  void dispose() {
    _feeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('System Settings', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
        actions: [
          if (_dirty)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextButton(
                onPressed: _save,
                child: Text('Save', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.amber)),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Feature Flags
          _Section('Feature Flags'),
          _Card(children: [
            _ToggleRow('Enable Gig Marketplace', _gigMarketplace, (v) { setState(() => _gigMarketplace = v); _markDirty(); }),
            const Divider(height: 1, color: HireIQTheme.borderLight),
            _ToggleRow('Enable WildcardIQ Blind Screening', _wildcardIq, (v) { setState(() => _wildcardIq = v); _markDirty(); }),
            const Divider(height: 1, color: HireIQTheme.borderLight),
            _ToggleRow('Enable PassportIQ Verification', _passportIq, (v) { setState(() => _passportIq = v); _markDirty(); }),
            const Divider(height: 1, color: HireIQTheme.borderLight),
            _ToggleRow('Enable Enterprise Mode', _enterpriseMode, (v) { setState(() => _enterpriseMode = v); _markDirty(); }),
            const Divider(height: 1, color: HireIQTheme.borderLight),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Maintenance Mode', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: _maintenanceMode ? HireIQTheme.error : HireIQTheme.textPrimary)),
                  if (_maintenanceMode)
                    Text('Platform is currently offline for users', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.error)),
                ])),
                Switch(
                  value: _maintenanceMode,
                  onChanged: (v) { setState(() => _maintenanceMode = v); _markDirty(); },
                  activeTrackColor: HireIQTheme.error.withValues(alpha: 0.9),
                  thumbColor: const WidgetStatePropertyAll(Colors.white),
                ),
              ]),
            ),
          ]),
          const SizedBox(height: 24),

          // Business Rules
          _Section('Business Rules'),
          _Card(children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Platform Fee (%)', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: HireIQTheme.textPrimary)),
                  Text('Applied to all gig commissions', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                ])),
                SizedBox(
                  width: 70,
                  child: TextField(
                    controller: _feeCtrl,
                    onChanged: (_) => _markDirty(),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy),
                    decoration: InputDecoration(
                      suffix: Text('%', style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                  ),
                ),
              ]),
            ),
            const Divider(height: 1, color: HireIQTheme.borderLight),
            _InfoRow('Placement Fee — Junior', '10%'),
            const Divider(height: 1, color: HireIQTheme.borderLight),
            _InfoRow('Placement Fee — Mid', '12%'),
            const Divider(height: 1, color: HireIQTheme.borderLight),
            _InfoRow('Placement Fee — Senior', '15%'),
            const Divider(height: 1, color: HireIQTheme.borderLight),
            _InfoRow('Candidate Free Application Limit', '5 per month'),
            const Divider(height: 1, color: HireIQTheme.borderLight),
            _InfoRow('Employer Starter Job Limit', '3 active jobs'),
          ]),
          const SizedBox(height: 24),

          // Contact info
          _Section('Contact & Version'),
          _Card(children: [
            _InfoRow('Support Email', 'hello@hireiq.co.za'),
            const Divider(height: 1, color: HireIQTheme.borderLight),
            _InfoRow('App Version', 'v1.0.0'),
          ]),
          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: HireIQTheme.amber,
                foregroundColor: HireIQTheme.primaryNavy,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
              ),
              child: Text('Save Settings', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800)),
            ),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}

Widget _Section(String title) => Padding(
  padding: const EdgeInsets.only(bottom: 10),
  child: Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)),
);

Widget _Card({required List<Widget> children}) => Container(
  decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusLg), border: Border.all(color: HireIQTheme.borderLight), boxShadow: [BoxShadow(color: HireIQTheme.primaryNavy.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 2))]),
  child: Column(children: children),
);

Widget _ToggleRow(String label, bool value, ValueChanged<bool> onChanged) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
  child: Row(children: [
    Expanded(child: Text(label, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: HireIQTheme.textPrimary))),
    Switch(value: value, onChanged: onChanged, activeTrackColor: HireIQTheme.primaryTeal),
  ]),
);

Widget _InfoRow(String label, String value) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
  child: Row(children: [
    Expanded(child: Text(label, style: GoogleFonts.inter(fontSize: 13, color: HireIQTheme.textMuted))),
    Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
  ]),
);
