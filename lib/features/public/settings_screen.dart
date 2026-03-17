import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import '../../shared/components/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          _buildSectionHeader('Account'),
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
          const SizedBox(height: 24),
          _buildSectionHeader('Preferences'),
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
          const SizedBox(height: 24),
          _buildSectionHeader('Support'),
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
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(foregroundColor: HireIQTheme.error),
              child: const Text('Log Out',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: HireIQTheme.textMuted,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
