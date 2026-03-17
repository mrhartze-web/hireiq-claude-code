import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class CandidateGigDetail extends StatelessWidget {
  final String gigId;
  const CandidateGigDetail({super.key, required this.gigId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Gig Details'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share_outlined,
                  color: HireIQTheme.primaryNavy)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border,
                  color: HireIQTheme.primaryNavy)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildStatsRow(),
            const SizedBox(height: 32),
            _buildSectionTitle('Required Skills'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSkillChip('Flutter'),
                _buildSkillChip('Dart'),
                _buildSkillChip('Figma'),
                _buildSkillChip('State Management'),
              ],
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('About this gig'),
            const SizedBox(height: 12),
            const Text(
              'We are looking for an experienced Flutter developer to troubleshoot and fix UI inconsistencies across our mobile application. You will be responsible for ensuring pixel-perfect delivery of designs from Figma and optimizing performance for low-end devices.',
              style: TextStyle(
                  fontSize: 15, height: 1.6, color: HireIQTheme.textPrimary),
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('Payment Milestones'),
            const SizedBox(height: 16),
            _buildMilestone('1. UI Audit & Strategy', 'R3,000'),
            _buildMilestone('2. Core UI Fixes', 'R7,000'),
            _buildMilestone('3. Optimization & Final Polish', 'R5,000'),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.primaryNavy,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Submit Proposal',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Flutter App UI Fix',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.primaryNavy),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const CircleAvatar(
              radius: 12,
              backgroundColor: HireIQTheme.primaryNavy,
              child: Text('A',
                  style: TextStyle(color: Colors.white, fontSize: 10)),
            ),
            const SizedBox(width: 8),
            const Text('Apex Digital',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: HireIQTheme.textPrimary)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                  color: HireIQTheme.success.withAlpha(25),
                  borderRadius: BorderRadius.circular(4)),
              child: const Text('Verified',
                  style: TextStyle(
                      color: HireIQTheme.success,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatItem('Proposals', '7'),
        _buildStatItem('Duration', '2-4 wks'),
        _buildStatItem('MatchIQ', '87%', color: HireIQTheme.primaryTeal),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, {Color? color}) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(fontSize: 12, color: HireIQTheme.textMuted)),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color ?? HireIQTheme.primaryNavy)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: HireIQTheme.primaryNavy),
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        border: Border.all(color: HireIQTheme.borderLight),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 12, color: HireIQTheme.textPrimary)),
    );
  }

  Widget _buildMilestone(String title, String amount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(amount,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        ],
      ),
    );
  }
}
