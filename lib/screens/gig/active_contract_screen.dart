import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class ActiveContractScreen extends StatelessWidget {
  const ActiveContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const Text(
          'Active Contract',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildStatusHeader(),
            const SizedBox(height: 32),
            _buildMilestoneTracker(),
            const SizedBox(height: 32),
            _buildCommunicationToolbar(),
            const SizedBox(height: 32),
            _buildContractDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQColors.navy,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Design Audit',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Icon(Icons.more_horiz_rounded, color: Colors.white),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statusCol('REMAINING', '2 Days'),
              _statusCol('FUNDS ESCROWED', '\$2,500'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusCol(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: Colors.white60,
                fontSize: 10,
                fontWeight: FontWeight.bold)),
        Text(value,
            style: const TextStyle(
                color: HireIQColors.teal,
                fontSize: 20,
                fontWeight: FontWeight.w900)),
      ],
    );
  }

  Widget _buildMilestoneTracker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Milestones',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQColors.navy)),
        const SizedBox(height: 16),
        _milestoneItem('Phase 1: Component Audit', true),
        _milestoneItem('Phase 2: Unification', false),
        _milestoneItem('Final: Handover', false),
      ],
    );
  }

  Widget _milestoneItem(String label, bool isDone) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
              isDone
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: isDone ? HireIQColors.teal : HireIQColors.silver),
          const SizedBox(width: 12),
          Text(label,
              style: TextStyle(
                  fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
                  color: HireIQColors.navy)),
        ],
      ),
    );
  }

  Widget _buildCommunicationToolbar() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.chat_bubble_rounded),
            label: const Text('Message Client'),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: HireIQColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: HireIQColors.silver)),
          child: const Icon(Icons.video_call_rounded, color: HireIQColors.navy),
        ),
      ],
    );
  }

  Widget _buildContractDetails() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: HireIQColors.silver),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Legal Info',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: HireIQColors.navy)),
          SizedBox(height: 8),
          Text('Contract ID: #HI-9201-UX',
              style: TextStyle(color: HireIQColors.textMuted, fontSize: 12)),
          Text('Signed: Oct 20, 2023',
              style: TextStyle(color: HireIQColors.textMuted, fontSize: 12)),
        ],
      ),
    );
  }
}
