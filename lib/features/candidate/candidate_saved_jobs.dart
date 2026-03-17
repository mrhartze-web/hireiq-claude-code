import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:go_router/go_router.dart';

class CandidateSavedJobs extends StatelessWidget {
  const CandidateSavedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Saved Jobs'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Senior Backend Engineer',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      IconButton(
                        icon: const Icon(Icons.bookmark_remove,
                            color: HireIQTheme.error),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const Text('FinTech Startup • Johannesburg (Hybrid)',
                      style: TextStyle(color: HireIQTheme.textMuted)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('R800k - R1.2m / year',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: HireIQTheme.primaryNavy)),
                      ElevatedButton(
                        onPressed: () => context.push('/candidate/smart-apply'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HireIQTheme.primaryTeal,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Apply'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
