import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class ApplicationTimelineScreen extends StatelessWidget {
  const ApplicationTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Application Status'),
        backgroundColor: HireIQTheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildJobSummary(),
            const SizedBox(height: 30),
            Text('Application Timeline', style: HireIQTheme.subtitleStyle),
            const SizedBox(height: 20),
            _buildTimelineStep(
              title: 'Applied',
              date: 'Oct 12, 2023 at 10:30 AM',
              isCompleted: true,
            ),
            _buildTimelineStep(
              title: 'Application Viewed',
              date: 'Oct 14, 2023 by Hiring Team',
              isCompleted: true,
            ),
            _buildTimelineStep(
              title: 'Interviewing',
              date: 'In Progress • Technical Round',
              isCompleted: true,
              isCurrent: true,
            ),
            _buildTimelineStep(
              title: 'Offer',
              date: 'Pending review',
              isCompleted: false,
            ),
            _buildTimelineStep(
              title: 'Hired',
              date: 'Final stage',
              isCompleted: false,
              isLast: true,
            ),
            const SizedBox(height: 30),
            _buildRecruiterCard(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildJobSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: HireIQTheme.border,
                borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.business, color: HireIQTheme.primary),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Senior Product Designer',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Stripe • San Francisco',
                    style: HireIQTheme.bodyStyle.copyWith(
                        color: HireIQTheme.textSecondary, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep({
    required String title,
    required String date,
    required bool isCompleted,
    bool isCurrent = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: isCurrent
                      ? HireIQTheme.primary
                      : (isCompleted ? Colors.green : Colors.transparent),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: isCompleted ? Colors.green : HireIQTheme.border,
                      width: 2),
                ),
                child: isCompleted && !isCurrent
                    ? const Icon(Icons.check, size: 12, color: Colors.white)
                    : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? Colors.green : HireIQTheme.border,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isCurrent
                          ? HireIQTheme.primary
                          : (isCompleted
                              ? HireIQTheme.textPrimary
                              : HireIQTheme.textSecondary),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: HireIQTheme.bodyStyle.copyWith(
                        fontSize: 12, color: HireIQTheme.textSecondary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecruiterCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.accent.withAlpha(12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.accent.withAlpha(51)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your Recruiter',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: HireIQTheme.textSecondary)),
          const SizedBox(height: 15),
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: HireIQTheme.accent,
                child: Text('SJ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Sarah Jenkins',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Technical Recruiter at Stripe',
                        style: HireIQTheme.bodyStyle.copyWith(
                            fontSize: 12, color: HireIQTheme.textSecondary)),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_bubble_outline,
                      size: 20, color: HireIQTheme.accent)),
            ],
          ),
        ],
      ),
    );
  }
}
