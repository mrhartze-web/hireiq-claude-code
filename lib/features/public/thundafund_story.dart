import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class ThundafundStory extends StatelessWidget {
  const ThundafundStory({super.key});

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Story',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Why we built HireIQ — and why we need your help to grow it.',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: HireIQTheme.textMuted,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),

            _buildTimelineItem(
              year: '2023',
              title: 'The Problem',
              body:
                  'Our founders spent years watching talented South Africans get passed over because their CVs "didn\'t look right" — despite exceptional skills. Traditional ATS tools were designed for Western markets and failed local talent.',
              iconColor: HireIQTheme.error,
              icon: Icons.warning_amber_outlined,
              isLast: false,
            ),
            _buildTimelineItem(
              year: '2024',
              title: 'The Idea',
              body:
                  'We asked: what if AI could evaluate skill, not presentation? What if every candidate started on equal footing? HireIQ was born — six AI modules, one platform, zero compromises on fairness.',
              iconColor: HireIQTheme.amber,
              icon: Icons.lightbulb_outline,
              isLast: false,
            ),
            _buildTimelineItem(
              year: '2025',
              title: 'The Build',
              body:
                  'A small team of engineers, recruiters, and data scientists built MatchIQ, PassportIQ, ForgeIQ, SignalIQ, WildcardIQ, and UpliftIQ from the ground up. Beta launched in Cape Town with 12 hiring companies.',
              iconColor: HireIQTheme.primaryTeal,
              icon: Icons.build_outlined,
              isLast: false,
            ),
            _buildTimelineItem(
              year: '2026',
              title: 'The Campaign',
              body:
                  'Now we\'re scaling — and we want the community that inspired us to be part of it. Your backing funds server infrastructure, AI model training, and the team needed to expand across Africa.',
              iconColor: HireIQTheme.primaryNavy,
              icon: Icons.rocket_launch_outlined,
              isLast: true,
            ),

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
                  const Icon(Icons.construction_outlined,
                      color: HireIQTheme.primaryTeal, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Full founder video and extended story coming soon.',
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

  Widget _buildTimelineItem({
    required String year,
    required String title,
    required String body,
    required Color iconColor,
    required IconData icon,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: HireIQTheme.borderLight,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 24),
              padding: const EdgeInsets.all(20),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: iconColor.withValues(alpha: 0.1),
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusFull),
                        ),
                        child: Text(
                          year,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: iconColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: HireIQTheme.primaryNavy,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    body,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: HireIQTheme.textMuted,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
