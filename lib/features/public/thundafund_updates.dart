import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class ThundafundUpdates extends StatelessWidget {
  const ThundafundUpdates({super.key});

  static const List<_Update> _updates = [
    _Update(
      date: '14 March 2026',
      badge: 'Milestone',
      badgeColor: 0xFF0D9488,
      title: '57% funded — thank you!',
      body:
          'We hit R142,500 today. An enormous thank you to every one of our 284 backers. We\'re on track to close the campaign fully funded. The team is heads-down building — here\'s a sneak peek at the new SignalIQ salary heatmap.',
    ),
    _Update(
      date: '1 March 2026',
      badge: 'Product',
      badgeColor: 0xFF1A2B4A,
      title: 'PassportIQ verification now live for beta backers',
      body:
          'Early-access backers at Champion tier and above now have access to PassportIQ ID verification. Verified candidates are already seeing 3× more recruiter profile views in our beta cohort.',
    ),
    _Update(
      date: '14 February 2026',
      badge: 'Launch',
      badgeColor: 0xFFF59E0B,
      title: 'Campaign live on Thundafund!',
      body:
          'We\'re officially live. The first 50 backers receive a special "Founding 50" badge on their HireIQ profile. Thank you for believing in fairer hiring for Africa.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Campaign Updates',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Follow our progress and stay in the loop.',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: HireIQTheme.textMuted,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            ..._updates.map((u) => _buildUpdateCard(u)),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.notifications_outlined,
                      color: HireIQTheme.primaryTeal, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Back the campaign to receive update notifications directly.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: HireIQTheme.primaryTeal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateCard(_Update u) {
    final color = Color(u.badgeColor);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  u.badge,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                u.date,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: HireIQTheme.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            u.title,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.primaryNavy,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            u.body,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: HireIQTheme.textMuted,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _Update {
  const _Update({
    required this.date,
    required this.badge,
    required this.badgeColor,
    required this.title,
    required this.body,
  });
  final String date;
  final String badge;
  final int badgeColor;
  final String title;
  final String body;
}
