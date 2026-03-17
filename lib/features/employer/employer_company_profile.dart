import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class EmployerCompanyProfile extends StatelessWidget {
  const EmployerCompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Company Profile'),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: HireIQTheme.primaryNavy.withAlpha(12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: HireIQTheme.borderLight),
                    ),
                    child: const Icon(Icons.business,
                        size: 48, color: HireIQTheme.primaryTeal),
                  ),
                  const SizedBox(height: 16),
                  const Text('Apex Digital Solutions',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: HireIQTheme.primaryNavy)),
                  const Text('Technology • 50-200 Employees',
                      style: TextStyle(color: HireIQTheme.textMuted)),
                  const SizedBox(height: 24),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on,
                          color: HireIQTheme.primaryTeal, size: 16),
                      SizedBox(width: 6),
                      Text('Johannesburg, SA',
                          style: TextStyle(color: HireIQTheme.primaryNavy)),
                      SizedBox(width: 16),
                      Icon(Icons.link,
                          color: HireIQTheme.primaryTeal, size: 16),
                      SizedBox(width: 6),
                      Text('apexdigital.co.za',
                          style: TextStyle(
                              color: HireIQTheme.primaryTeal,
                              decoration: TextDecoration.underline)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('About Us',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: HireIQTheme.primaryNavy)),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Apex Digital is an innovative technology consulting firm specializing in digital transformation, cloud infrastructure, and AI-driven solutions for enterprise clients.',
                    style: TextStyle(color: HireIQTheme.textMuted, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Culture & Perks',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: HireIQTheme.primaryNavy)),
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
                      'Gym Membership'
                    ]
                        .map((perk) => Chip(
                              label: Text(perk),
                              backgroundColor:
                                  HireIQTheme.primaryTeal.withAlpha(12),
                              labelStyle: const TextStyle(
                                  color: HireIQTheme.primaryNavy),
                              side: BorderSide.none,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
