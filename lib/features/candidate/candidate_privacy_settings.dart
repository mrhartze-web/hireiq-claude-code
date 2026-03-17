import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidatePrivacySettings extends StatelessWidget {
  const CandidatePrivacySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Privacy Settings',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _PrivacySectionTitle(title: 'Profile Visibility'),
                  const SizedBox(height: 12),
                  _PrivacySwitchTile(
                    title: 'Public Profile Visibility',
                    subtitle:
                        'Allow employers to find you in search results based on your MatchIQ score.',
                    value: true,
                    onChanged: (val) {},
                  ),

                  const SizedBox(height: 28),

                  const _PrivacySectionTitle(title: 'Data Sharing'),
                  const SizedBox(height: 12),
                  _PrivacySwitchTile(
                    title: 'Share anonymized data',
                    subtitle:
                        'Help improve HireIQ by sharing aggregated usage data.',
                    value: false,
                    onChanged: (val) {},
                  ),
                  const SizedBox(height: 12),
                  _PrivacySwitchTile(
                    title: 'Marketing Communications',
                    subtitle:
                        'Receive emails about new features and promotions.',
                    value: false,
                    onChanged: (val) {},
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Section title ──────────────────────────────────────────────────────────────

class _PrivacySectionTitle extends StatelessWidget {
  const _PrivacySectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: HireIQTheme.primaryNavy,
        letterSpacing: -0.3,
      ),
    );
  }
}

// ── Switch tile ────────────────────────────────────────────────────────────────

class _PrivacySwitchTile extends StatelessWidget {
  const _PrivacySwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.isLast = false,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SwitchListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: HireIQTheme.primaryNavy,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: HireIQTheme.textMuted,
            height: 1.45,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeThumbColor: HireIQTheme.primaryTeal,
      ),
    );
  }
}
