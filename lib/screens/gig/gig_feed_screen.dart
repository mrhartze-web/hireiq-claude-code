import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class GigFeedScreen extends StatelessWidget {
  const GigFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        title: const Text(
          'Gig Market',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.tune_rounded)),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildQuickFilters(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildGigCard(context, 'Build a Design System', 'High Priority',
                    '\$2,500', '3-5 Days'),
                _buildGigCard(context, 'React Native Performance Audit',
                    'Urgent', '\$1,800', '2 Days'),
                _buildGigCard(context, 'Brand Identity for SaaS', 'Creative',
                    '\$3,200', '1 Week'),
                _buildGigCard(context, 'Market Research - Fintech', 'Strategic',
                    '\$900', '3 Days'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          _filterChip('All Gigs', true),
          _filterChip('Design', false),
          _filterChip('Engineering', false),
          _filterChip('Marketing', false),
          _filterChip('Project Management', false),
        ],
      ),
    );
  }

  Widget _filterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? HireIQColors.navy : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isSelected ? HireIQColors.navy : HireIQColors.silver),
      ),
      child: Text(
        label,
        style: TextStyle(
            color: isSelected ? Colors.white : HireIQColors.textMuted,
            fontWeight: FontWeight.bold,
            fontSize: 12),
      ),
    );
  }

  Widget _buildGigCard(BuildContext context, String title, String tag,
      String price, String duration) {
    return GestureDetector(
      onTap: () => context.push('/gig-detail'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: HireIQColors.silver),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: HireIQColors.teal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(tag,
                      style: const TextStyle(
                          color: HireIQColors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 10)),
                ),
                Text(price,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: HireIQColors.navy)),
              ],
            ),
            const SizedBox(height: 16),
            Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: HireIQColors.navy)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.timer_outlined,
                    size: 14, color: HireIQColors.textMuted),
                const SizedBox(width: 4),
                Text(duration,
                    style: const TextStyle(
                        color: HireIQColors.textMuted, fontSize: 12)),
                const SizedBox(width: 16),
                const Icon(Icons.bolt_rounded, size: 14, color: Colors.orange),
                const SizedBox(width: 4),
                const Text('Instant Match',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
