import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/job-feed'),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection('Account'),
              GestureDetector(
                onTap: () => context.go('/candidate-profile'),
                child:
                    _buildSettingItem(Icons.person_outline_rounded, 'Profile'),
              ),
              _buildSettingItem(
                  Icons.notifications_none_rounded, 'Notifications'),
              _buildSettingItem(
                  Icons.lock_outline_rounded, 'Security & Password'),
              const SizedBox(height: 32),
              _buildSection('Preferences'),
              _buildSettingItem(Icons.language_rounded, 'Language',
                  trailing: 'English (US)'),
              _buildSettingItem(Icons.dark_mode_outlined, 'Dark Theme',
                  isSwitch: true),
              const SizedBox(height: 32),
              _buildSection('Support'),
              _buildSettingItem(Icons.help_outline_rounded, 'Help Center'),
              _buildSettingItem(Icons.info_outline_rounded, 'About HireIQ'),
              const SizedBox(height: 48),
              Center(
                child: TextButton(
                  onPressed: () => context.go('/role-selection'),
                  child: const Text('Log Out',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text('Version 1.0.4 (Build 482)',
                    style:
                        TextStyle(color: HireIQColors.textMuted, fontSize: 10)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: HireIQColors.teal,
            letterSpacing: 1.2),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title,
      {String? trailing, bool isSwitch = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQColors.silver),
      ),
      child: Row(
        children: [
          Icon(icon, color: HireIQColors.navy, size: 22),
          const SizedBox(width: 16),
          Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: HireIQColors.navy))),
          if (trailing != null)
            Text(trailing,
                style: const TextStyle(
                    color: HireIQColors.textMuted, fontSize: 13)),
          if (isSwitch)
            Switch.adaptive(
              value: true,
              activeTrackColor: HireIQColors.teal.withValues(alpha: 0.5),
              activeThumbColor: HireIQColors.teal,
              onChanged: (_) {},
            ),
          if (!isSwitch && trailing == null)
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: HireIQColors.silver),
        ],
      ),
    );
  }
}
