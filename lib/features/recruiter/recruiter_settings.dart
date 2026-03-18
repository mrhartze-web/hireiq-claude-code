import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/settings_tile.dart';

class RecruiterSettings extends StatelessWidget {
  const RecruiterSettings({super.key});

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
              child: Text(
                'Log Out',
                style: GoogleFonts.inter(
                    color: HireIQTheme.error, fontWeight: FontWeight.bold),
              ),
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
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: HireIQTheme.primaryNavy.withValues(alpha: 0.1),
            child: Text(
              'LM',
              style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lerato Mokoena',
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: Text(
                    'Solo Recruiter Plan · R2,999/mo',
                    style: GoogleFonts.inter(
                        color: HireIQTheme.primaryTeal,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
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
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        border: const Border(
            top: BorderSide(color: HireIQTheme.borderLight),
            bottom: BorderSide(color: HireIQTheme.borderLight)),
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
