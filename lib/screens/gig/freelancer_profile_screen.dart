import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class FreelancerProfileScreen extends StatelessWidget {
  const FreelancerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBioSection(),
                  const SizedBox(height: 32),
                  _buildSkillsSection(),
                  const SizedBox(height: 32),
                  _buildPortfolioPreview(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildActionMenu(),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: HireIQColors.navy,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon:
            const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: HireIQColors.teal,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text('Alex Thompson',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900)),
                Text('Senior Product Architect',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBioSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQColors.navy)),
        SizedBox(height: 12),
        Text(
          'Digital architect with a decade of experience building scalable design systems and full-stack applications. Expert in React, Node.js, and UX strategy.',
          style: TextStyle(color: HireIQColors.textMuted, height: 1.6),
        ),
      ],
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Core Tech',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQColors.navy)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _skillChip('Design Systems'),
            _skillChip('React Architecture'),
            _skillChip('Node.js Scalability'),
            _skillChip('Figma Expert'),
          ],
        ),
      ],
    );
  }

  Widget _skillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: HireIQColors.surface, borderRadius: BorderRadius.circular(12)),
      child: Text(label,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: HireIQColors.navy,
              fontSize: 12)),
    );
  }

  Widget _buildPortfolioPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Portfolio',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQColors.navy)),
        const SizedBox(height: 16),
        Row(
          children: [
            _portfolioItem('Linear Audit'),
            const SizedBox(width: 16),
            _portfolioItem('Stripe UX'),
          ],
        ),
      ],
    );
  }

  Widget _portfolioItem(String title) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            color: HireIQColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: HireIQColors.silver)),
        child: Center(
            child: Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: HireIQColors.navy))),
      ),
    );
  }

  Widget _buildActionMenu() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(color: Colors.white),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
                child: OutlinedButton(
                    onPressed: () {}, child: const Text('Save Profile'))),
            const SizedBox(width: 16),
            Expanded(
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('Send Offer'))),
          ],
        ),
      ),
    );
  }
}
