import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerSignalIq extends StatelessWidget {
  const EmployerSignalIq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'SignalIQ Alerts',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildAlertTile(
                'Top Candidate Available',
                'Alex, a 94% MatchIQ fit for your Backend Role, just updated their status to "Actively Looking".',
                '10m ago',
                true,
              ),
              _buildAlertTile(
                'Offer Update',
                'Sarah accepted the offer for Product Designer. Start onboarding process.',
                '45m ago',
                true,
              ),
              _buildAlertTile(
                'Competitor Activity',
                'Salary trends for "Flutter Developer" in Johannesburg increased by 5% this month.',
                'Yesterday',
                false,
              ),
              _buildAlertTile(
                'Pipeline Warning',
                "You haven't reviewed candidates for the QA Engineer role in 3 days.",
                'Yesterday',
                false,
              ),
              const SizedBox(height: 40),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertTile(
    String title,
    String detail,
    String time,
    bool isNew,
  ) {
    return Container(
      color: isNew
          ? HireIQTheme.primaryTeal.withValues(alpha: 0.05)
          : Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isNew
                  ? HireIQTheme.primaryTeal.withValues(alpha: 0.1)
                  : HireIQTheme.surfaceWhite,
              shape: BoxShape.circle,
              border: Border.all(
                color: isNew
                    ? Colors.transparent
                    : HireIQTheme.borderLight,
              ),
            ),
            child: Icon(
              isNew
                  ? Icons.notifications_active
                  : Icons.notifications_none,
              color:
                  isNew ? HireIQTheme.primaryTeal : HireIQTheme.textMuted,
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
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.inter(
                            fontWeight: isNew
                                ? FontWeight.bold
                                : FontWeight.w600,
                            fontSize: 15,
                            color: HireIQTheme.primaryNavy),
                      ),
                    ),
                    if (isNew)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: HireIQTheme.primaryTeal,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: GoogleFonts.inter(
                      color: HireIQTheme.textMuted, height: 1.5),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: GoogleFonts.inter(
                      color: HireIQTheme.primaryTeal,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
