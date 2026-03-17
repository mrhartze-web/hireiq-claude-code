import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final String? salary;
  final String? matchScore;
  final VoidCallback onTap;

  const JobCard({
    super.key,
    required this.title,
    required this.company,
    required this.location,
    this.salary,
    this.matchScore,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: HireIQTheme.primaryNavy,
                          ),
                    ),
                  ),
                  if (matchScore != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: HireIQTheme.primaryTeal.withAlpha(25),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$matchScore% Match',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: HireIQTheme.primaryTeal,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                company,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: HireIQTheme.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined,
                      size: 14, color: HireIQTheme.textMuted),
                  const SizedBox(width: 4),
                  Text(
                    location,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (salary != null) ...[
                    const SizedBox(width: 12),
                    const Icon(Icons.payments_outlined,
                        size: 14, color: HireIQTheme.textMuted),
                    const SizedBox(width: 4),
                    Text(
                      salary!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildTag(context, 'Full-time'),
                  const SizedBox(width: 8),
                  _buildTag(context, 'Remote'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: HireIQTheme.borderLight.withAlpha(127),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 10,
              color: HireIQTheme.textMuted,
            ),
      ),
    );
  }
}
