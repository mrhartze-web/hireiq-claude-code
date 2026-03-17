import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class EmployerSignalIq extends StatelessWidget {
  const EmployerSignalIq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('SignalIQ Alerts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _buildAlertTile(
            context,
            'Top Candidate Available',
            'Alex, a 94% MatchIQ fit for your Backend Role, just updated their status to "Actively Looking".',
            '10m ago',
            true,
          ),
          _buildAlertTile(
            context,
            'Offer Update',
            'Sarah accepted the offer for Product Designer. Start onboarding process.',
            '45m ago',
            true,
          ),
          _buildAlertTile(
            context,
            'Competitor Activity',
            'Salary trends for "Flutter Developer" in Johannesburg increased by 5% this month.',
            'Yesterday',
            false,
          ),
          _buildAlertTile(
            context,
            'Pipeline Warning',
            'You haven\'t reviewed candidates for the QA Engineer role in 3 days.',
            'Yesterday',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildAlertTile(
    BuildContext context,
    String title,
    String detail,
    String time,
    bool isNew,
  ) {
    return Container(
      color: isNew ? HireIQTheme.primaryTeal.withAlpha(12) : Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isNew
                  ? HireIQTheme.primaryTeal.withAlpha(25)
                  : HireIQTheme.surfaceWhite,
              shape: BoxShape.circle,
              border: Border.all(
                  color: isNew ? Colors.transparent : HireIQTheme.borderLight),
            ),
            child: Icon(
              isNew ? Icons.notifications_active : Icons.notifications_none,
              color: isNew ? HireIQTheme.primaryTeal : HireIQTheme.textMuted,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontWeight:
                                isNew ? FontWeight.bold : FontWeight.w600,
                            fontSize: 16,
                            color: HireIQTheme.primaryNavy)),
                    if (isNew)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                            color: HireIQTheme.primaryTeal,
                            shape: BoxShape.circle),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(detail,
                    style: const TextStyle(
                        color: HireIQTheme.textMuted, height: 1.4)),
                const SizedBox(height: 8),
                Text(time,
                    style: const TextStyle(
                        color: HireIQTheme.primaryTeal,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
