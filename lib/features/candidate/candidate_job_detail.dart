import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';
import '../mobile_screens.dart';

class CandidateJobDetail extends StatelessWidget {
  const CandidateJobDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildTabs(),
                  const SizedBox(height: 24),
                  _buildSectionTitle('About the Role'),
                  const SizedBox(height: 8),
                  const Text(
                    'HireIQ is looking for a Senior Full-Stack Developer to lead our core engineering team. You will be responsible for architecting and building scalable solutions that power the future of recruitment tech.',
                    style:
                        TextStyle(color: HireIQTheme.primaryNavy, height: 1.6),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Key Responsibilities'),
                  const SizedBox(height: 12),
                  _buildBulletPoint(
                      'Design and implement high-performance web applications using modern frameworks.'),
                  _buildBulletPoint(
                      'Collaborate with product managers and designers to translate requirements into technical specs.'),
                  _buildBulletPoint(
                      'Conduct code reviews and maintain high standards for code quality and testing.'),
                  _buildBulletPoint(
                      'Optimize application for maximum speed and scalability.'),
                  const SizedBox(height: 100), // Space for action button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _buildApplyButton(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: HireIQTheme.primaryTeal,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.bookmark_border, color: Colors.white),
          onPressed: () {},
        ),
      ],
      flexibleSpace: const FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 56, bottom: 16),
        title: Text('Job Details',
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: HireIQTheme.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.rocket_launch,
                  color: HireIQTheme.primaryTeal, size: 32),
            ),
            const SizedBox(width: 16),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Innovative Tech Solutions',
                  style: TextStyle(color: HireIQTheme.textMuted, fontSize: 14),
                ),
                Text(
                  'HireIQ',
                  style: TextStyle(
                      color: HireIQTheme.primaryNavy,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Senior Full-Stack Developer',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.primaryNavy),
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(Icons.location_on_outlined,
                size: 16, color: HireIQTheme.textMuted),
            SizedBox(width: 4),
            Text('Johannesburg (Remote)',
                style: TextStyle(color: HireIQTheme.textMuted)),
            SizedBox(width: 16),
            Icon(Icons.payments_outlined,
                size: 16, color: HireIQTheme.textMuted),
            SizedBox(width: 4),
            Text('R120k - R160k',
                style: TextStyle(color: HireIQTheme.textMuted)),
          ],
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        _buildTab('Description', isActive: true),
        _buildTab('Requirements'),
        _buildTab('Company'),
      ],
    );
  }

  Widget _buildTab(String label, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 24),
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isActive ? HireIQTheme.primaryTeal : Colors.transparent,
            width: 2,
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive ? HireIQTheme.primaryTeal : HireIQTheme.textMuted,
        ),
      ),
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

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ',
              style: TextStyle(
                  color: HireIQTheme.primaryTeal,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    color: HireIQTheme.primaryNavy, height: 1.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(12),
              blurRadius: 10,
              offset: const Offset(0, -5)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Open Application Flow
                context.push(MobileRoutes.candidatePassportProcessing);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: HireIQTheme.primaryTeal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Apply Now with PassportIQ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
