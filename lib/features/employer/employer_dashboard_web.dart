import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class EmployerDashboardWeb extends StatelessWidget {
  const EmployerDashboardWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Employer Dashboard',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 20),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: HireIQTheme.surfaceWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: const Border(
                      left:
                          BorderSide(color: HireIQTheme.primaryTeal, width: 6),
                      top: BorderSide(color: HireIQTheme.borderLight),
                      right: BorderSide(color: HireIQTheme.borderLight),
                      bottom: BorderSide(color: HireIQTheme.borderLight)),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text('Direct hire or recruiter',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: HireIQTheme.primaryNavy)),
                            SizedBox(height: 8),
                            Text(
                                'Use HireIQ directly for volume and standard roles. Engage a HireIQ recruiter for senior, specialist, or hard-to-fill positions. Both options work together on your account.',
                                style: TextStyle(color: HireIQTheme.textMuted)),
                          ])),
                      IconButton(
                          icon: const Icon(Icons.close), onPressed: () {})
                    ])),
          ],
        ),
      ),
    );
  }
}
