import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class CandidatePublicProfile extends StatelessWidget {
  const CandidatePublicProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Public Profile Viewer'),
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
                  const Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: HireIQTheme.primaryNavy,
                        child: Text('D',
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.verified,
                              color: HireIQTheme.primaryTeal, size: 24),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Dwayne Johnson',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: HireIQTheme.primaryNavy)),
                  const Text('Senior Backend Engineer',
                      style: TextStyle(color: HireIQTheme.textMuted)),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on,
                          color: HireIQTheme.primaryTeal, size: 16),
                      const SizedBox(width: 6),
                      const Text('Johannesburg • Remote OK',
                          style: TextStyle(color: HireIQTheme.primaryNavy)),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                            color: HireIQTheme.primaryTeal.withAlpha(25),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text('Top 5% MatchIQ',
                            style: TextStyle(
                                color: HireIQTheme.primaryTeal,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('About',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: HireIQTheme.primaryNavy)),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Experienced software engineer specializing in scalable backend systems, microservices architecture, and cloud infrastructure.',
                    style: TextStyle(color: HireIQTheme.textMuted, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Top Skills',
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
                      'Go',
                      'PostgreSQL',
                      'Docker',
                      'Kubernetes',
                      'AWS',
                      'Python'
                    ]
                        .map((skill) => Chip(
                              label: Text(skill),
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
