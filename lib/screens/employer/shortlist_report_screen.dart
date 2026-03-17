import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class ShortlistReportScreen extends StatelessWidget {
  const ShortlistReportScreen({super.key});

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
          'Shortlist Report',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildCandidateList(),
            const SizedBox(height: 32),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQColors.navy,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Senior Product Architect',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Generated Oct 28, 2023 • AI Score: 98%',
              style: TextStyle(color: Colors.white70, fontSize: 12)),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Stat(label: 'CANDIDATES', value: '12'),
              _Stat(label: 'TOP MATCHES', value: '4'),
              _Stat(label: 'TIME SAVED', value: '24h'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCandidateList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Key Recommendations',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: HireIQColors.navy)),
        const SizedBox(height: 16),
        _candidateItem('Sarah Connor', '99%', 'Tech Lead at Cyberdyne'),
        _candidateItem('John Smith', '96%', 'Senior Dev at Stripe'),
        _candidateItem('Elena Fisher', '94%', 'Lead Eng at Naughty Dog'),
      ],
    );
  }

  Widget _candidateItem(String name, String match, String info) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQColors.silver),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: HireIQColors.surface, shape: BoxShape.circle),
            child: const Icon(Icons.person, color: HireIQColors.navy, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: HireIQColors.navy)),
                Text(info,
                    style: const TextStyle(
                        color: HireIQColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
          Text(match,
              style: const TextStyle(
                  color: HireIQColors.teal, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.share_rounded),
            label: const Text('Share Report'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Start Interviews'),
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
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
                fontSize: 18,
                fontWeight: FontWeight.w900)),
      ],
    );
  }
}
