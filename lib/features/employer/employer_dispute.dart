import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';

class OpenDisputeScreen extends StatelessWidget {
  const OpenDisputeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Open Dispute',
            style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Raise a dispute',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: HireIQTheme.primaryNavy),
            ),
            const SizedBox(height: 8),
            const Text(
              'Mediation will be initiated if a resolution isn\'t reached within 48 hours.',
              style: TextStyle(color: HireIQTheme.textMuted),
            ),
            const SizedBox(height: 32),
            _buildMilestoneContext(),
            const SizedBox(height: 32),
            _buildDisputeReasonField(),
            const SizedBox(height: 24),
            _buildAttachmentSection(),
            const SizedBox(height: 32),
            _buildHowItWorks(),
            const SizedBox(height: 40),
            _buildSubmitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMilestoneContext() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: const Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 32),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flutter App UI Fix • Milestone 2',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy),
                ),
                Text(
                  'Thabo Nkosi to Apex Digital',
                  style: TextStyle(color: HireIQTheme.textMuted, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisputeReasonField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Dispute Reason',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        const SizedBox(height: 12),
        TextField(
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Describe the issue in detail...',
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
      ],
    );
  }

  Widget _buildAttachmentSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: HireIQTheme.borderLight, style: BorderStyle.solid),
      ),
      child: const Center(
        child: Column(
          children: [
            Icon(Icons.cloud_upload_outlined,
                color: HireIQTheme.primaryTeal, size: 32),
            SizedBox(height: 12),
            Text('Attach screenshots or documents',
                style: TextStyle(fontWeight: FontWeight.w500)),
            Text('PDF, JPG, PNG (Max 10MB)',
                style: TextStyle(color: HireIQTheme.textMuted, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildHowItWorks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('How it works',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: HireIQTheme.primaryNavy)),
        const SizedBox(height: 16),
        _buildStep(1,
            'Submit this form to notify the other party and our dispute team.'),
        _buildStep(
            2, 'You have 48 hours to reach an amicable solution together.'),
        _buildStep(3,
            'If no agreement is reached, an independent mediator will be assigned.'),
      ],
    );
  }

  Widget _buildStep(int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
                color: HireIQTheme.primaryNavy, shape: BoxShape.circle),
            child: Text('$number',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Text(text,
                  style: const TextStyle(fontSize: 13, height: 1.4))),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Dispute raised. The escrow funds (R5,000.00) have been frozen.')),
            );
            context.pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 55),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Submit Dispute',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 16),
        const Text(
          'By submitting, the R5,000.00 in escrow will be frozen until a resolution is reached.',
          textAlign: TextAlign.center,
          style: TextStyle(color: HireIQTheme.textMuted, fontSize: 11),
        ),
      ],
    );
  }
}
