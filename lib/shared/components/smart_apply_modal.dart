import 'package:flutter/material.dart';
import '../theme.dart';

class SmartApplyModal extends StatelessWidget {
  final String jobTitle;
  final String companyName;

  const SmartApplyModal({
    super.key,
    required this.jobTitle,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Smart Apply ⚡',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy,
                ),
              ),
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Applying to $jobTitle at $companyName',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: HireIQTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Your application will be tracked in real time. We will use your PassportIQ verified profile to fast-track the process.',
            style: TextStyle(
              fontSize: 14,
              color: HireIQTheme.textMuted,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          _buildFeatureRow(
              Icons.verified_user_outlined, 'PassportIQ Verified Profile'),
          _buildFeatureRow(
              Icons.auto_awesome_outlined, 'ForgeIQ AI Cover Letter Included'),
          _buildFeatureRow(Icons.speed, 'Priority Review by Recruitment Team'),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Application Submitted Successfully!'),
                    backgroundColor: HireIQTheme.success,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: HireIQTheme.primaryTeal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Confirm Application',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: HireIQTheme.primaryTeal),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: HireIQTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
