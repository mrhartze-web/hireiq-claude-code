import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';

class EmployerOnboardingSteps extends StatelessWidget {
  const EmployerOnboardingSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.primaryNavy,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Setup Your Company Profile',
                style: GoogleFonts.inter(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 12),
              Text(
                "Let's get your company ready to start hiring top talent with MatchIQ.",
                style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.5),
              ),
              const SizedBox(height: 48),
              Expanded(
                child: ListView(
                  children: [
                    _buildStep(
                        context,
                        '01',
                        'Company Details',
                        'Name, industry, and size.',
                        true,
                        true),
                    _buildStep(
                        context,
                        '02',
                        'Culture & Perks',
                        'What makes your company great.',
                        false,
                        false),
                    _buildStep(
                        context,
                        '03',
                        'Billing Information',
                        'Set up payment method for placements.',
                        false,
                        false),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => context.go('/employer-dashboard'),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        HireIQTheme.primaryTeal,
                        Color(0xFF0A7A70),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Start Connecting',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, String number, String title,
      String description, bool isActive, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isCompleted
                  ? HireIQTheme.primaryTeal
                  : (isActive
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.15)),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 20)
                : Text(
                    number,
                    style: GoogleFonts.inter(
                        color: isActive
                            ? HireIQTheme.primaryNavy
                            : Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  title,
                  style: GoogleFonts.inter(
                      color: isActive || isCompleted
                          ? Colors.white
                          : Colors.white60,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.inter(
                      color: isActive || isCompleted
                          ? Colors.white60
                          : Colors.white38,
                      fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
