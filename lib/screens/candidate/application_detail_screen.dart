import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class ApplicationDetailScreen extends StatelessWidget {
  const ApplicationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/application-tracker'),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const Text(
          'Application Detail',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusHeader(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTimeline(),
                  const SizedBox(height: 32),
                  _buildInternalNote(),
                  const SizedBox(height: 32),
                  _buildNextStep(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        color: HireIQColors.navy,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: HireIQColors.teal,
            child:
                Icon(Icons.check_circle_rounded, color: Colors.white, size: 40),
          ),
          SizedBox(height: 24),
          Text(
            'Under Review',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 8),
          Text(
            'Senior Product Architect at Stripe',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Journey Tracker',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: HireIQColors.navy)),
        const SizedBox(height: 24),
        _timelineStep('Application Submitted', 'Oct 24, 2023', true),
        _timelineStep('AI Initial Screening', 'Oct 25, 2023', true),
        _timelineStep('Recruiter Review', 'In Progress', false,
            isProcess: true),
        _timelineStep('Technical Assessment', 'Locked', false),
      ],
    );
  }

  Widget _timelineStep(String title, String subtitle, bool isDone,
      {bool isProcess = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          Icon(
            isDone
                ? Icons.check_circle_rounded
                : (isProcess
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off_rounded),
            color: isDone
                ? HireIQColors.teal
                : (isProcess ? HireIQColors.teal : HireIQColors.silver),
            size: 24,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDone || isProcess
                          ? HireIQColors.navy
                          : HireIQColors.textMuted)),
              Text(subtitle,
                  style: const TextStyle(
                      color: HireIQColors.textMuted, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInternalNote() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: HireIQColors.surface, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome_rounded,
              color: HireIQColors.teal, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('HireIQ AI Insight',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: HireIQColors.teal)),
                Text(
                  'Your profile matches 98% of the core requirements. You are currently in the top 5% of all applicants.',
                  style: TextStyle(
                      color: HireIQColors.navy.withValues(alpha: 0.8),
                      fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextStep(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => context.push('/assessment-prestart'),
          child: const Text('Prepare for Assessment'),
        ),
        const SizedBox(height: 12),
        TextButton(onPressed: () {}, child: const Text('Withdraw Application')),
      ],
    );
  }
}
