import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';

class RecruiterCandidateSubmission extends StatelessWidget {
  const RecruiterCandidateSubmission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Submit Candidate'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Client Brief',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Apex Digital - Senior Developer',
                      style: TextStyle(color: HireIQTheme.primaryNavy)),
                  items: const [],
                  onChanged: (val) {},
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Submission Notes',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText:
                    'Add context about why this candidate is a strong fit...',
                hintStyle: const TextStyle(color: HireIQTheme.textMuted),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: HireIQTheme.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: HireIQTheme.borderLight),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: HireIQTheme.primaryTeal.withAlpha(25),
                    child: const Text('A',
                        style: TextStyle(
                            color: HireIQTheme.primaryTeal,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Alice Johnson',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: HireIQTheme.primaryNavy,
                                fontSize: 16)),
                        Text('MatchIQ: 94%',
                            style: TextStyle(
                                color: HireIQTheme.primaryTeal,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send),
              label: const Text('Submit to Client'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: HireIQTheme.primaryTeal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
