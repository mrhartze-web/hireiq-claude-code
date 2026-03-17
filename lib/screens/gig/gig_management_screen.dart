import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class GigManagementScreen extends StatelessWidget {
  const GigManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        title: const Text(
          'My Gigs',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildActiveGig(context, 'Design System Audit', 'Linear Pro',
              'In Progress', 0.65),
          const SizedBox(height: 24),
          _buildSection('Drafts & Pending'),
          _buildGigItem('Frontend Performance', 'Stripe', 'Awaiting Proposals'),
          _buildGigItem('Fintech Researcher', 'Revolut', 'Draft'),
          const SizedBox(height: 32),
          _buildSection('Completed'),
          _buildGigItem('Logo Refresh', 'Airbnb', 'Paid', isDone: true),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/post-job'),
        label: const Text('Post New Gig'),
        icon: const Icon(Icons.add_rounded),
        backgroundColor: HireIQColors.navy,
      ),
    );
  }

  Widget _buildActiveGig(BuildContext context, String title, String company,
      String status, double progress) {
    return GestureDetector(
      onTap: () => context.push('/active-contract'),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(status.toUpperCase(),
                    style: const TextStyle(
                        color: HireIQColors.teal,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                        letterSpacing: 1.2)),
                const Icon(Icons.more_vert_rounded, color: HireIQColors.silver),
              ],
            ),
            const SizedBox(height: 8),
            Text(title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HireIQColors.navy)),
            Text(company,
                style: const TextStyle(color: HireIQColors.textMuted)),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: HireIQColors.surface,
                  color: HireIQColors.teal,
                  minHeight: 8),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${(progress * 100).toInt()}% towards milestone',
                    style: const TextStyle(
                        color: HireIQColors.textMuted, fontSize: 12)),
                const Text('Due in 2 days',
                    style: TextStyle(
                        color: HireIQColors.navy,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Opacity(
        opacity: 0.6,
        child: Text(title,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: HireIQColors.navy)),
      ),
    );
  }

  Widget _buildGigItem(String title, String company, String status,
      {bool isDone = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
              isDone
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: isDone ? HireIQColors.teal : HireIQColors.silver),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: HireIQColors.navy)),
                Text(company,
                    style: const TextStyle(
                        color: HireIQColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
          Text(status,
              style: TextStyle(
                  color: isDone ? HireIQColors.navy : HireIQColors.textMuted,
                  fontSize: 12)),
        ],
      ),
    );
  }
}
