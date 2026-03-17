import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerInterviewDetail extends StatelessWidget {
  const EmployerInterviewDetail({super.key});

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
              'Interview Details',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          HireIQTheme.primaryNavy,
                          Color(0xFF243659),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusXl),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor:
                                  Colors.white.withValues(alpha: 0.15),
                              child: Text(
                                'E',
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Eva Green',
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Data Scientist candidate',
                                    style: GoogleFonts.inter(
                                        color: Colors.white60,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Divider(
                            color: Colors.white.withValues(alpha: 0.15),
                            height: 1),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        color: HireIQTheme.primaryTeal,
                                        size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Tomorrow, Oct 13',
                                      style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time,
                                        color: HireIQTheme.primaryTeal,
                                        size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      '10:00 AM - 11:00 AM',
                                      style: GoogleFonts.inter(
                                          color: Colors.white60,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Icon(Icons.videocam,
                                color: Colors.white, size: 32),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Preparation Notes',
                    style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg),
                      border:
                          Border.all(color: HireIQTheme.borderLight),
                      boxShadow: [
                        BoxShadow(
                          color: HireIQTheme.primaryNavy
                              .withValues(alpha: 0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      'Focus on her experience with predictive modeling at scale. Ask about the specific ML pipelines she built at her previous role. Review her WildcardIQ assessment results on advanced Python frameworks.',
                      style: GoogleFonts.inter(
                          color: HireIQTheme.textMuted, height: 1.6),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: HireIQTheme.surfaceWhite,
                              borderRadius: BorderRadius.circular(
                                  HireIQTheme.radiusMd),
                              border: Border.all(
                                  color: HireIQTheme.primaryNavy),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Reschedule',
                              style: GoogleFonts.inter(
                                  color: HireIQTheme.primaryNavy,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  HireIQTheme.primaryTeal,
                                  Color(0xFF0A7A70),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(
                                  HireIQTheme.radiusMd),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Join Call',
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
