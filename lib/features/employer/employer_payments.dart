import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';

class ReleasePaymentScreen extends StatelessWidget {
  const ReleasePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Release Payment',
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
            _buildCandidateHeader(),
            const SizedBox(height: 24),
            _buildMilestoneInfo(),
            const SizedBox(height: 24),
            _buildDeliverableCard(),
            const SizedBox(height: 32),
            _buildPaymentSummary(),
            const SizedBox(height: 32),
            _buildReviewChecklist(),
            const SizedBox(height: 40),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCandidateHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=thabo'),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Thabo Nkosi',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Expert Developer',
                    style:
                        TextStyle(color: HireIQTheme.textMuted, fontSize: 13)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal.withAlpha(25),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('Verified',
                style: TextStyle(
                    color: HireIQTheme.primaryTeal,
                    fontSize: 11,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneInfo() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutter App UI Fix • Milestone 2',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.primaryNavy),
        ),
        SizedBox(height: 4),
        Text(
          'Final UI adjustments and responsiveness fixes.',
          style: TextStyle(color: HireIQTheme.textMuted),
        ),
      ],
    );
  }

  Widget _buildDeliverableCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Submitted deliverable:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: HireIQTheme.borderLight),
          ),
          child: Row(
            children: [
              const Icon(Icons.folder_zip_outlined,
                  color: Colors.orange, size: 32),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('flutter_ui_fix_final.zip',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('4.2 MB • Zip Archive',
                        style: TextStyle(
                            color: HireIQTheme.textMuted, fontSize: 12)),
                  ],
                ),
              ),
              IconButton(
                icon:
                    const Icon(Icons.download, color: HireIQTheme.primaryTeal),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.primaryNavy,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Currently held in escrow',
                  style: TextStyle(color: Colors.white70)),
              Icon(Icons.lock_outline, color: Colors.white70, size: 16),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Release amount',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              Text('R5,000.00',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          Divider(color: Colors.white24, height: 32),
          Row(
            children: [
              Icon(Icons.security, color: HireIQTheme.primaryTeal, size: 14),
              SizedBox(width: 8),
              Text('Payments are protected by ShieldIQ',
                  style: TextStyle(color: Colors.white70, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewChecklist() {
    return Column(
      children: [
        _buildCheckItem('I have reviewed and tested the code provided.'),
        _buildCheckItem('The deliverables meet the project requirements.'),
        _buildCheckItem('I am ready to finalize this milestone payment.'),
      ],
    );
  }

  Widget _buildCheckItem(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Checkbox(
              value: true,
              onChanged: (v) {},
              activeColor: HireIQTheme.primaryTeal),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => context.pop(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              side: const BorderSide(color: HireIQTheme.borderLight),
            ),
            child: const Text('Back',
                style: TextStyle(color: HireIQTheme.primaryNavy)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              // Proceed to release payment
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment released successfully!')),
              );
              context.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: HireIQTheme.primaryTeal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Confirm Release',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
