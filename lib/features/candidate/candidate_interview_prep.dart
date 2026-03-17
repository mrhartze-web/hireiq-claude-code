import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:go_router/go_router.dart';

class CandidateInterviewPrep extends StatelessWidget {
  const CandidateInterviewPrep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Interview Prep'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Acing Your Interview',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 8),
            const Text(
              'Resources and tips to help you land the role.',
              style: TextStyle(color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 32),
            _buildTipCard(
              title: 'Mastering the STAR Method',
              description:
                  'Situation, Task, Action, Result. Crucial for behavioral questions.',
              icon: Icons.star_border,
            ),
            _buildTipCard(
              title: 'Technical Whiteboarding',
              description:
                  'Practice talking through your code out loud while writing it on a whiteboard.',
              icon: Icons.edit_note,
            ),
            _buildTipCard(
              title: 'Questions to Ask the Employer',
              description:
                  'Show engagement by asking about company culture, team structure, and growth opportunities.',
              icon: Icons.question_answer_outlined,
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withAlpha(25),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: HireIQTheme.primaryTeal),
              ),
              child: const Column(
                children: [
                  Icon(Icons.videocam_outlined,
                      color: HireIQTheme.primaryTeal, size: 48),
                  SizedBox(height: 16),
                  Text('Video Pitch Practice',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: HireIQTheme.primaryNavy)),
                  SizedBox(height: 8),
                  Text(
                    'Ensure your background is clean, lighting is good, and you speak clearly and confidently.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: HireIQTheme.textMuted, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.push('/candidate/video-pitch'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: HireIQTheme.primaryNavy,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Practice Video Pitch',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(
      {required String title,
      required String description,
      required IconData icon}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: HireIQTheme.primaryNavy.withAlpha(25),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: HireIQTheme.primaryNavy),
        ),
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(description,
              style:
                  const TextStyle(color: HireIQTheme.textMuted, height: 1.4)),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 16, color: HireIQTheme.textMuted),
        onTap: () {},
      ),
    );
  }
}
