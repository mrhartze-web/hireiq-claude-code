import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidatePrivacySettings extends ConsumerStatefulWidget {
  const CandidatePrivacySettings({super.key});

  @override
  ConsumerState<CandidatePrivacySettings> createState() =>
      _CandidatePrivacySettingsState();
}

class _CandidatePrivacySettingsState
    extends ConsumerState<CandidatePrivacySettings> {
  String _visibility = 'Employers only';
  bool _showSalary = true;
  bool _showCurrentEmployer = false;
  bool _allowRecruiterContact = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Privacy Settings',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Profile Visibility ────────────────────────────────────────
            _SectionHeader('Profile Visibility'),
            const SizedBox(height: 12),
            Container(
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
              child: Column(
                children: [
                  _VisibilityOption(
                    label: 'Public',
                    subtitle: 'Anyone can find and view your profile',
                    icon: Icons.public_rounded,
                    isSelected: _visibility == 'Public',
                    onTap: () =>
                        setState(() => _visibility = 'Public'),
                  ),
                  const Divider(height: 1, color: HireIQTheme.borderLight),
                  _VisibilityOption(
                    label: 'Employers only',
                    subtitle:
                        'Only verified employers on HireIQ can view you',
                    icon: Icons.business_outlined,
                    isSelected: _visibility == 'Employers only',
                    onTap: () =>
                        setState(() => _visibility = 'Employers only'),
                  ),
                  const Divider(height: 1, color: HireIQTheme.borderLight),
                  _VisibilityOption(
                    label: 'Hidden',
                    subtitle: 'Your profile is invisible — you apply first',
                    icon: Icons.visibility_off_outlined,
                    isSelected: _visibility == 'Hidden',
                    onTap: () =>
                        setState(() => _visibility = 'Hidden'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Information Toggles ───────────────────────────────────────
            _SectionHeader('Information Sharing'),
            const SizedBox(height: 12),
            Container(
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
              child: Column(
                children: [
                  _ToggleTile(
                    title: 'Show salary expectations',
                    subtitle:
                        'Employers can see your target salary range',
                    value: _showSalary,
                    onChanged: (v) => setState(() => _showSalary = v),
                  ),
                  const Divider(height: 1, color: HireIQTheme.borderLight),
                  _ToggleTile(
                    title: 'Show current employer',
                    subtitle: 'Display where you currently work',
                    value: _showCurrentEmployer,
                    onChanged: (v) =>
                        setState(() => _showCurrentEmployer = v),
                  ),
                  const Divider(height: 1, color: HireIQTheme.borderLight),
                  _ToggleTile(
                    title: 'Allow recruiter contact',
                    subtitle:
                        'Verified recruiters can message you about roles',
                    value: _allowRecruiterContact,
                    onChanged: (v) =>
                        setState(() => _allowRecruiterContact = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── POPIA Note ────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: HireIQTheme.infoLight,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                border: Border.all(
                    color: HireIQTheme.info.withValues(alpha: 0.25)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.shield_outlined,
                      size: 18, color: HireIQTheme.info),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'HireIQ is fully compliant with the Protection of Personal Information Act (POPIA). Your data is never sold or shared without explicit consent.',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          color: HireIQTheme.info,
                          height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Save Changes ──────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.amber,
                  foregroundColor: HireIQTheme.primaryNavy,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg)),
                ),
                child: Text(
                  'Save Privacy Settings',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ── Data Deletion ─────────────────────────────────────────────
            _SectionHeader('Data & Account'),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: _showDeleteDialog,
                icon: const Icon(Icons.delete_forever_outlined, size: 18),
                label: Text(
                  'Request Data Deletion',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: HireIQTheme.error,
                  side: const BorderSide(color: HireIQTheme.error),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Account?',
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w700, color: HireIQTheme.error)),
        content: Text(
          'This will permanently delete your profile, applications, and all data from HireIQ. This action cannot be undone.',
          style: GoogleFonts.inter(color: HireIQTheme.textMuted, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel',
                style: GoogleFonts.inter(color: HireIQTheme.textMuted)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
                backgroundColor: HireIQTheme.error,
                foregroundColor: Colors.white),
            child: Text('Delete',
                style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
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

class _VisibilityOption extends StatelessWidget {
  const _VisibilityOption({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (isSelected
                        ? HireIQTheme.primaryTeal
                        : HireIQTheme.primaryNavy)
                    .withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon,
                  size: 20,
                  color: isSelected
                      ? HireIQTheme.primaryTeal
                      : HireIQTheme.textMuted),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                        fontSize: 12, color: HireIQTheme.textMuted),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: label,
              groupValue: isSelected ? label : '',
              onChanged: (_) => onTap(),
              activeColor: HireIQTheme.primaryTeal,
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                      fontSize: 12, color: HireIQTheme.textMuted),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: HireIQTheme.primaryTeal,
          ),
        ],
      ),
    );
  }
}
