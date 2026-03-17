import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class GigDetailScreen extends StatelessWidget {
  const GigDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios_new,
                  size: 20, color: HireIQColors.navy),
            ),
            title: const Text('Gig Details',
                style: TextStyle(
                    color: HireIQColors.navy, fontWeight: FontWeight.bold)),
            backgroundColor: HireIQColors.background,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleSection(),
                  const SizedBox(height: 32),
                  const Text('The Mission',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HireIQColors.navy)),
                  const SizedBox(height: 12),
                  const Text(
                    'We are looking for a world-class designer to audit and unify our disparate design systems into a single, cohesive Figma library. This project requires precision and an eye for scalability.',
                    style:
                        TextStyle(color: HireIQColors.textMuted, height: 1.6),
                  ),
                  const SizedBox(height: 32),
                  const Text('Requirements',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HireIQColors.navy)),
                  const SizedBox(height: 16),
                  _buildRequirement('5+ years experience in Design Systems'),
                  _buildRequirement('Expert proficiency in Figma & Tokens'),
                  _buildRequirement('Ability to deliver in under 5 days'),
                  const SizedBox(height: 32),
                  _buildCompanyPreview(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Build a Design System',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: HireIQColors.navy),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _infoTag(Icons.monetization_on_outlined, '\$2,500'),
            const SizedBox(width: 12),
            _infoTag(Icons.timer_outlined, '3-5 Days'),
            const SizedBox(width: 12),
            _infoTag(Icons.bolt_rounded, 'Urgent'),
          ],
        ),
      ],
    );
  }

  Widget _infoTag(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: HireIQColors.surface, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(icon, size: 14, color: HireIQColors.textMuted),
          const SizedBox(width: 4),
          Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: HireIQColors.navy)),
        ],
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded,
              color: HireIQColors.teal, size: 18),
          const SizedBox(width: 12),
          Text(text,
              style: const TextStyle(
                  color: HireIQColors.navy, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildCompanyPreview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                color: HireIQColors.navy,
                borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.business_rounded, color: Colors.white),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Linear Pro',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: HireIQColors.navy)),
              Text('Fintech • 50-100 employees',
                  style:
                      TextStyle(color: HireIQColors.textMuted, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(color: Colors.white),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: () => context.push('/submit-proposal'),
          child: const Text('Submit Proposal'),
        ),
      ),
    );
  }
}
