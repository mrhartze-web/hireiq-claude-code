import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class ConfirmHireScreen extends StatelessWidget {
  const ConfirmHireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const Text(
          'Confirm Hire',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Icon(Icons.check_circle_rounded,
                color: HireIQColors.teal, size: 80),
            const SizedBox(height: 24),
            const Text(
              'Finalizing Hire',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: HireIQColors.navy),
            ),
            const SizedBox(height: 8),
            const Text(
              'You are about to send an offer to Alex Rivera for the Senior Product Designer role.',
              textAlign: TextAlign.center,
              style: TextStyle(color: HireIQColors.textMuted, fontSize: 15),
            ),
            const SizedBox(height: 40),
            _buildInfoCard(),
            const SizedBox(height: 40),
            _buildAgreementSection(),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                // Return to dashboard after successful hire
                context.go('/employer-dashboard');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Offer sent successfully!'),
                    backgroundColor: HireIQColors.teal,
                  ),
                );
              },
              child: const Text('Send Official Offer'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel Request',
                  style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _infoRow('Base Salary', '\$145,000 /yr'),
          const Divider(height: 24),
          _infoRow('Bonus Tier', 'Level 2 (10%)'),
          const Divider(height: 24),
          _infoRow('Probation', '3 Months'),
          const Divider(height: 24),
          _infoRow('Start Date', 'Oct 28, 2023'),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: HireIQColors.textMuted)),
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: HireIQColors.navy)),
      ],
    );
  }

  Widget _buildAgreementSection() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.verified_user_outlined, color: HireIQColors.teal, size: 20),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            'By confirming, you agree to HireIQ\'s fee structure and terms of service for this placement.',
            style: TextStyle(
                fontSize: 12, color: HireIQColors.textMuted, height: 1.4),
          ),
        ),
      ],
    );
  }
}
