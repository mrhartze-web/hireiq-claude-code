import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class CandidateCard extends StatelessWidget {
  final String name;
  final String role;
  final int matchIqScore;
  final VoidCallback onActionPressed;

  const CandidateCard({
    super.key,
    required this.name,
    required this.role,
    required this.matchIqScore,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: HireIQTheme.primaryTeal.withAlpha(25),
            child: Text(name[0],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryTeal)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy)),
                Text(role,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: HireIQTheme.textMuted)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.auto_awesome,
                        color: HireIQTheme.primaryTeal, size: 14),
                    const SizedBox(width: 4),
                    Text('$matchIqScore% Match',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: HireIQTheme.primaryTeal,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onActionPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: HireIQTheme.primaryNavy,
              foregroundColor: HireIQTheme.surfaceWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('View'),
          ),
        ],
      ),
    );
  }
}
