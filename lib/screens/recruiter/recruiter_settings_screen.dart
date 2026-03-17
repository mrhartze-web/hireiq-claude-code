import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class RecruiterSettingsScreen extends StatelessWidget {
  const RecruiterSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        title: const Text('Recruiter Settings',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: HireIQColors.navy)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildProfileCard(),
            const SizedBox(height: 32),
            _buildSettingRow('Pipeline Preferences', Icons.tune_rounded),
            _buildSettingRow(
                'Notification Alerts', Icons.notifications_active_rounded),
            _buildSettingRow('API & Integrations', Icons.code_rounded),
            _buildSettingRow('Sourcing Limits', Icons.analytics_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: HireIQColors.silver)),
      child: const Row(
        children: [
          CircleAvatar(
              radius: 28,
              backgroundColor: HireIQColors.teal,
              child: Icon(Icons.work_rounded, color: Colors.white)),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Professional Sourcing',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text('Plan: Recruiter Pro',
                  style:
                      TextStyle(color: HireIQColors.textMuted, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRow(String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: HireIQColors.surface, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Icon(icon, color: HireIQColors.navy, size: 20),
          const SizedBox(width: 16),
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: HireIQColors.navy)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded,
              size: 12, color: HireIQColors.silver),
        ],
      ),
    );
  }
}
