import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class CandidateSecuritySettings extends StatelessWidget {
  const CandidateSecuritySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Security Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Change Password',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 16),
            _buildTextField('Current Password', obscureText: true),
            const SizedBox(height: 16),
            _buildTextField('New Password', obscureText: true),
            const SizedBox(height: 16),
            _buildTextField('Confirm New Password', obscureText: true),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.primaryNavy,
                  foregroundColor: HireIQTheme.surfaceWhite,
                ),
                child: const Text('Update Password'),
              ),
            ),
            const SizedBox(height: 48),
            const Text(
              'Two-Factor Authentication',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add an extra layer of security to your account.',
              style: TextStyle(color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: SwitchListTile(
                title: const Text('Enable 2FA',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy)),
                subtitle: const Text(
                    'Use an authenticator app for secure logins.',
                    style: TextStyle(color: HireIQTheme.textMuted)),
                value: false,
                onChanged: (val) {},
                activeThumbColor: HireIQTheme.primaryTeal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
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
