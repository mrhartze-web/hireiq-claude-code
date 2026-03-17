import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
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
              const Text(
                'Setup Your Company Profile',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text(
                "Let's get your company ready to start hiring top talent with MatchIQ.",
                style:
                    TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 48),
              Expanded(
                child: ListView(
                  children: [
                    _buildStep(context, '01', 'Company Details',
                        'Name, industry, and size.', true, true),
                    _buildStep(context, '02', 'Culture & Perks',
                        'What makes your company great.', false, false),
                    _buildStep(context, '03', 'Billing Information',
                        'Set up payment method for placements.', false, false),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/employer-dashboard'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  backgroundColor: HireIQTheme.primaryTeal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Start Connecting',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCompleted
                  ? HireIQTheme.primaryTeal
                  : (isActive ? Colors.white : Colors.white24),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white)
                : Text(number,
                    style: TextStyle(
                        color:
                            isActive ? HireIQTheme.primaryNavy : Colors.white,
                        fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: isActive || isCompleted
                            ? Colors.white
                            : Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(description,
                    style: TextStyle(
                        color: isActive || isCompleted
                            ? Colors.white70
                            : Colors.white38,
                        fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
