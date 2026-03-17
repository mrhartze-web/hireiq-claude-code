import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class AdminSystemSettings extends StatelessWidget {
  const AdminSystemSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('System Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionTitle('Platform Status'),
          _buildSwitchTile(
            title: 'Maintenance Mode',
            subtitle: 'Disable all user access for system upgrades.',
            value: false,
            onChanged: (val) {},
            activeColor: HireIQTheme.error,
          ),
          _buildSwitchTile(
            title: 'New User Registration',
            subtitle:
                'Allow new candidates, employers, and recruiters to sign up.',
            value: true,
            onChanged: (val) {},
            activeColor: HireIQTheme.primaryTeal,
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('AI Configuration'),
          _buildSwitchTile(
            title: 'MatchIQ Engine',
            subtitle: 'Enable or disable automated candidate matching.',
            value: true,
            onChanged: (val) {},
            activeColor: HireIQTheme.primaryTeal,
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Global Defaults'),
          _buildTextField('Default Platform Fee (%)', 'e.g. 15'),
          const SizedBox(height: 16),
          _buildTextField('Guarantee Period (Days)', 'e.g. 90'),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 55),
              backgroundColor: HireIQTheme.primaryNavy,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Save Configuration',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
    required Color activeColor,
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
        activeThumbColor: activeColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: HireIQTheme.textMuted),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: HireIQTheme.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: HireIQTheme.borderLight),
            ),
          ),
        ),
      ],
    );
  }
}
