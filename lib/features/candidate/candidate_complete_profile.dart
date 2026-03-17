import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:go_router/go_router.dart';

class CandidateCompleteProfile extends StatelessWidget {
  const CandidateCompleteProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Complete Profile'),
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
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Profile Completion',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Text('75%',
                          style: TextStyle(
                              color: HireIQTheme.primaryTeal.withAlpha(229),
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: 0.75,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        HireIQTheme.primaryTeal),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                      'Complete the remaining steps to access MatchIQ and start applying.',
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Remaining Tasks',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 16),
            _buildTaskTile(context, 'Verify PassportIQ',
                'Upload your ID and get verified', false, '/passport-iq'),
            _buildTaskTile(context, 'Add References',
                'Build trust with employers', false, '/candidate/references'),
            _buildTaskTile(context, 'Record Video Pitch',
                'Stand out from the crowd', false, '/candidate/video-pitch'),
            const SizedBox(height: 32),
            const Text(
              'Completed',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 16),
            _buildTaskTile(
                context, 'Basic Details', 'Name, contact, location', true, ''),
            _buildTaskTile(context, 'Experience & Skills',
                'CV parsed successfully', true, ''),
            _buildTaskTile(context, 'Career Goals',
                'Salary and role expectations', true, ''),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskTile(BuildContext context, String title, String subtitle,
      bool isCompleted, String route) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: ListTile(
        leading: Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCompleted ? HireIQTheme.primaryTeal : HireIQTheme.textMuted,
        ),
        title: Text(title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isCompleted
                    ? HireIQTheme.textMuted
                    : HireIQTheme.primaryNavy)),
        subtitle: Text(subtitle,
            style: const TextStyle(color: HireIQTheme.textMuted)),
        trailing:
            isCompleted ? null : const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: isCompleted || route.isEmpty ? null : () => context.push(route),
      ),
    );
  }
}
