import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerCompanyProfile extends StatelessWidget {
  const EmployerCompanyProfile({super.key});

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
              'Company Profile',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusXl),
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
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: HireIQTheme.primaryNavy
                                .withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(
                                HireIQTheme.radiusLg),
                            border: Border.all(
                                color: HireIQTheme.borderLight),
                          ),
                          child: const Icon(Icons.business,
                              size: 48,
                              color: HireIQTheme.primaryTeal),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Apex Digital Solutions',
                          style: GoogleFonts.inter(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: HireIQTheme.primaryNavy),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Technology • 50-200 Employees',
                          style: GoogleFonts.inter(
                              color: HireIQTheme.textMuted),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on,
                                color: HireIQTheme.primaryTeal,
                                size: 16),
                            const SizedBox(width: 6),
                            Text(
                              'Johannesburg, SA',
                              style: GoogleFonts.inter(
                                  color: HireIQTheme.primaryNavy),
                            ),
                            const SizedBox(width: 16),
                            const Icon(Icons.link,
                                color: HireIQTheme.primaryTeal,
                                size: 16),
                            const SizedBox(width: 6),
                            Text(
                              'apexdigital.co.za',
                              style: GoogleFonts.inter(
                                  color: HireIQTheme.primaryTeal,
                                  decoration:
                                      TextDecoration.underline),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Divider(color: HireIQTheme.borderLight),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'About Us',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: HireIQTheme.primaryNavy),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Apex Digital is an innovative technology consulting firm specializing in digital transformation, cloud infrastructure, and AI-driven solutions for enterprise clients.',
                          style: GoogleFonts.inter(
                              color: HireIQTheme.textMuted,
                              height: 1.6),
                        ),
                        const SizedBox(height: 24),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Culture & Perks',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: HireIQTheme.primaryNavy),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            'Remote Work',
                            'Flexible Hours',
                            'Health Insurance',
                            'Learning Budget',
                            'Gym Membership',
                          ]
                              .map(
                                (perk) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: HireIQTheme.primaryTeal
                                        .withValues(alpha: 0.08),
                                    borderRadius:
                                        BorderRadius.circular(
                                            HireIQTheme.radiusFull),
                                    border: Border.all(
                                        color: HireIQTheme.primaryTeal
                                            .withValues(alpha: 0.2)),
                                  ),
                                  child: Text(
                                    perk,
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: HireIQTheme.primaryNavy,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
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
