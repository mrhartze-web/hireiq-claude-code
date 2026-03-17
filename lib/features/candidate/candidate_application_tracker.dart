import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/theme.dart';

class ApplicationTracker extends ConsumerWidget {
  const ApplicationTracker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Applications'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildApplicationItem(
            context,
            'Senior Flutter Developer',
            'Apex Digital',
            'Interview Scheduled',
            3,
            HireIQTheme.primaryTeal,
          ),
          _buildApplicationItem(
            context,
            'UX Designer',
            'Synergy Labs',
            'CV Under Review',
            1,
            HireIQTheme.amber,
          ),
          _buildApplicationItem(
            context,
            'Backend Engineer',
            'M-Pesa Africa',
            'Applied',
            0,
            HireIQTheme.textMuted,
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationItem(
    BuildContext context,
    String role,
    String company,
    String status,
    int stage,
    Color statusColor,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(role, style: Theme.of(context).textTheme.titleLarge),
                    Text(company,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Progress Steps
            Row(
              children: List.generate(5, (index) {
                final isActive = index <= stage;
                final isLast = index == 4;
                return Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isActive
                              ? HireIQTheme.primaryTeal
                              : HireIQTheme.borderLight,
                          shape: BoxShape.circle,
                        ),
                      ),
                      if (!isLast)
                        Expanded(
                          child: Container(
                            height: 2,
                            color: isActive
                                ? HireIQTheme.primaryTeal
                                : HireIQTheme.borderLight,
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Applied', style: Theme.of(context).textTheme.bodySmall),
                Text('Interview', style: Theme.of(context).textTheme.bodySmall),
                Text('Hired', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
