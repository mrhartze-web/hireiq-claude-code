import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class CandidatePrivacySettings extends StatelessWidget {
  const CandidatePrivacySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Privacy Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionTitle('Profile Visibility'),
          _buildSwitchTile(
            title: 'Public Profile Visibility',
            subtitle:
                'Allow employers to find you in search results based on your MatchIQ score.',
            value: true,
            onChanged: (val) {},
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Data Sharing'),
          _buildSwitchTile(
            title: 'Share anonymized data',
            subtitle: 'Help improve HireIQ by sharing aggregated usage data.',
            value: false,
            onChanged: (val) {},
          ),
          _buildSwitchTile(
            title: 'Marketing Communications',
            subtitle: 'Receive emails about new features and promotions.',
            value: false,
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: HireIQTheme.primaryNavy),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: SwitchListTile(
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        subtitle: Text(subtitle,
            style: const TextStyle(color: HireIQTheme.textMuted, height: 1.4)),
        value: value,
        onChanged: onChanged,
        activeThumbColor: HireIQTheme.primaryTeal,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
