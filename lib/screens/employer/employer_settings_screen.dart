import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class EmployerSettingsScreen extends StatelessWidget {
  const EmployerSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        title: const Text('Employer Settings',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: HireIQColors.navy)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildCompanyCard(),
            const SizedBox(height: 32),
            _buildSettingRow('Team Management', Icons.people_alt_rounded),
            _buildSettingRow('Billing & Usage', Icons.receipt_long_rounded),
            _buildSettingRow('Job Posting Templates', Icons.file_copy_rounded),
            _buildSettingRow('Analytics Dashboard', Icons.bar_chart_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyCard() {
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
              backgroundColor: HireIQColors.navy,
              child: Icon(Icons.business_rounded, color: Colors.white)),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Linear Pro Inc',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text('Enterprise Workspace',
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
