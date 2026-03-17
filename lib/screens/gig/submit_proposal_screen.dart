import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class SubmitProposalScreen extends StatefulWidget {
  const SubmitProposalScreen({super.key});

  @override
  State<SubmitProposalScreen> createState() => _SubmitProposalScreenState();
}

class _SubmitProposalScreenState extends State<SubmitProposalScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.close_rounded),
        ),
        title: const Text(
          'Submit Proposal',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildJobSnippet(),
              const SizedBox(height: 32),
              const Text('Your Pitch',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: HireIQColors.navy)),
              const SizedBox(height: 8),
              const Text(
                'Explain why you are the best fit for this urgent mission.',
                style: TextStyle(color: HireIQColors.textMuted, fontSize: 13),
              ),
              const SizedBox(height: 12),
              TextFormField(
                maxLines: 8,
                decoration: const InputDecoration(
                    hintText:
                        'I have built over 12 design systems for top-tier SaaS...'),
              ),
              const SizedBox(height: 32),
              const Text('Your Bid',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: HireIQColors.navy)),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: '2500',
                  prefixIcon: Icon(Icons.attach_money_rounded),
                  suffixText: 'USD',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  context.go('/job-feed');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Proposal Submitted Successfully!'),
                        backgroundColor: HireIQColors.teal),
                  );
                },
                child: const Text('Send Proposal'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobSnippet() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          Icon(Icons.work_rounded, color: HireIQColors.teal),
          SizedBox(width: 12),
          Text(
            'Build a Design System',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: HireIQColors.navy),
          ),
        ],
      ),
    );
  }
}
