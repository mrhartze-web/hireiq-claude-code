import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class CandidateDetailScreen extends StatelessWidget {
  const CandidateDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: HireIQColors.navy,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            NetworkImage('https://i.pravatar.cc/150?u=alex'),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Alex Rivera',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMatchInsight(),
                  const SizedBox(height: 32),
                  const Text('About Candidate',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HireIQColors.navy)),
                  const SizedBox(height: 12),
                  const Text(
                    'Senior Product Designer with 6+ years of experience in creating scalable design systems and intuitive user interfaces at top-tier tech companies like Stripe and Linear.',
                    style:
                        TextStyle(color: HireIQColors.textMuted, height: 1.6),
                  ),
                  const SizedBox(height: 32),
                  const Text('Top Skills',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HireIQColors.navy)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _skillChip('Product Design'),
                      _skillChip('UX Architecture'),
                      _skillChip('Design Systems'),
                      _skillChip('Figma Expert'),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text('Experience',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HireIQColors.navy)),
                  const SizedBox(height: 16),
                  _experienceItem(
                      'Senior Product Designer', 'Stripe', '2020 - Present'),
                  _experienceItem('UI Designer', 'Framer', '2018 - 2020'),
                  const SizedBox(height: 100), // Space for footer CTA
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomCTA(context),
    );
  }

  Widget _buildMatchInsight() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQColors.teal.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: HireIQColors.teal),
      ),
      child: const Row(
        children: [
          Icon(Icons.auto_awesome_rounded, color: HireIQColors.teal),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Match Insight',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: HireIQColors.teal)),
                Text(
                  'Alex is in the top 1% for design systems architectural proficiency based on their assessment.',
                  style: TextStyle(fontSize: 12, color: HireIQColors.navy),
                ),
              ],
            ),
          ),
          Text('92%',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: HireIQColors.teal)),
        ],
      ),
    );
  }

  Widget _skillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQColors.silver),
      ),
      child: Text(label,
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: HireIQColors.navy)),
    );
  }

  Widget _experienceItem(String role, String company, String date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: HireIQColors.surface,
                borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.business, color: HireIQColors.textMuted),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(role,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: HireIQColors.navy)),
                Text('$company • $date',
                    style: const TextStyle(
                        color: HireIQColors.textMuted, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCTA(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(color: Colors.white),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Move to Pipeline'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => context.push('/confirm-hire'),
                child: const Text('Hire Alex'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
