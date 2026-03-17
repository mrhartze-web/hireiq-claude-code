import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import '../../shared/components/settings_tile.dart';

class RecruiterSettings extends StatelessWidget {
  const RecruiterSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileSection(),
            const SizedBox(height: 16),
            _buildSettingsGroup([
              SettingsTile(
                  icon: Icons.person_outline,
                  title: 'Profile',
                  subtitle: 'Manage your recruiter information',
                  onTap: () {}),
              SettingsTile(
                  icon: Icons.notifications_none,
                  title: 'Notifications',
                  subtitle: 'Manage your alerts',
                  onTap: () {}),
              SettingsTile(
                  icon: Icons.credit_card,
                  title: 'Plan & Billing',
                  subtitle: 'Manage your solo plan',
                  onTap: () {}),
              SettingsTile(
                  icon: Icons.lock_outline,
                  title: 'Account Security',
                  subtitle: 'Password and authentication',
                  onTap: () {}),
            ]),
            const SizedBox(height: 16),
            _buildSettingsGroup([
              SettingsTile(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {}),
              SettingsTile(
                  icon: Icons.info_outline,
                  title: 'About HireIQ',
                  onTap: () {}),
            ]),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () {},
              child: const Text('Log Out',
                  style: TextStyle(
                      color: HireIQTheme.error, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: HireIQTheme.surfaceWhite,
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: HireIQTheme.primaryNavy.withAlpha(25),
            child: const Text('LM',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Lerato Mokoena',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      color: HireIQTheme.primaryTeal.withAlpha(25),
                      borderRadius: BorderRadius.circular(4)),
                  child: const Text('Solo Recruiter Plan • R2,999/mo',
                      style: TextStyle(
                          color: HireIQTheme.primaryTeal,
                          fontSize: 11,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit_outlined,
                  color: HireIQTheme.primaryNavy)),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> tiles) {
    return Container(
      decoration: const BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        border: Border(
            top: BorderSide(color: HireIQTheme.borderLight),
            bottom: BorderSide(color: HireIQTheme.borderLight)),
      ),
      child: Column(children: tiles),
    );
  }
}
