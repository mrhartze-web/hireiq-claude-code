import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class EmployerInterviewDetail extends StatelessWidget {
  const EmployerInterviewDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Interview Details'),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryNavy,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white24,
                        child: Text('E',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Eva Green',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text('Data Scientist candidate',
                                style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Divider(color: Colors.white24, height: 1),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  color: HireIQTheme.primaryTeal, size: 16),
                              SizedBox(width: 8),
                              Text('Tomorrow, Oct 13',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.access_time,
                                  color: HireIQTheme.primaryTeal, size: 16),
                              SizedBox(width: 8),
                              Text('10:00 AM - 11:00 AM',
                                  style: TextStyle(color: Colors.white70)),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.videocam, color: Colors.white, size: 32),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Preparation Notes',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: const Text(
                'Focus on her experience with predictive modeling at scale. Ask about the specific ML pipelines she built at her previous role. Review her WildcardIQ assessment results on advanced Python frameworks.',
                style: TextStyle(color: HireIQTheme.textMuted, height: 1.5),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: HireIQTheme.primaryNavy),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Reschedule',
                        style: TextStyle(color: HireIQTheme.primaryNavy)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: HireIQTheme.primaryTeal,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Join Call',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
