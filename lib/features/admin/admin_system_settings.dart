import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';

class AdminSystemSettings extends StatelessWidget {
  const AdminSystemSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'System Settings',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
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
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusMd)),
            ),
            child: Text(
              'Save Configuration',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold, fontSize: 15),
            ),
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
        style: GoogleFonts.inter(
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
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: GoogleFonts.inter(
              fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(
              color: HireIQTheme.textMuted, height: 1.4, fontSize: 13),
        ),
        value: value,
        onChanged: onChanged,
        activeTrackColor: activeColor,
        activeThumbColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: HireIQTheme.primaryNavy),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: HireIQTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
            border: Border.all(color: HireIQTheme.borderLight),
            boxShadow: [
              BoxShadow(
                color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            style: GoogleFonts.inter(
                fontSize: 14, color: HireIQTheme.textPrimary),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                  color: HireIQTheme.textMuted, fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                borderSide: const BorderSide(
                    color: HireIQTheme.primaryTeal, width: 1.5),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }
}
