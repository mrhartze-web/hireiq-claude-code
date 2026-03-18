import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Settings',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          _buildSectionHeader('Account'),
          _buildGroup([
            SettingsTile(
              icon: Icons.person_outline,
              title: 'Personal Information',
              onTap: () {},
            ),
            SettingsTile(
              icon: Icons.lock_outline,
              title: 'Security',
              subtitle: 'Password, Biometrics',
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 24),
          _buildSectionHeader('Preferences'),
          _buildGroup([
            SettingsTile(
              icon: Icons.notifications_none,
              title: 'Notifications',
              onTap: () {},
            ),
            SettingsTile(
              icon: Icons.language,
              title: 'Language',
              subtitle: 'English (South Africa)',
              onTap: () {},
            ),
            SettingsTile(
              icon: Icons.dark_mode_outlined,
              title: 'Appearance',
              subtitle: 'System Default',
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 24),
          _buildSectionHeader('Support'),
          _buildGroup([
            SettingsTile(
              icon: Icons.help_outline,
              title: 'Help Center',
              onTap: () {},
            ),
            SettingsTile(
              icon: Icons.info_outline,
              title: 'About HireIQ',
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: HireIQTheme.error),
              child: Text(
                'Log Out',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.inter(
          color: HireIQTheme.textMuted,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildGroup(List<Widget> tiles) {
    return Container(
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        border: const Border(
          top: BorderSide(color: HireIQTheme.borderLight),
          bottom: BorderSide(color: HireIQTheme.borderLight),
        ),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: tiles),
    );
  }
}
