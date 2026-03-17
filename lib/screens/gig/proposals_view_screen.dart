import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class ProposalsViewScreen extends StatelessWidget {
  const ProposalsViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        title: const Text(
          'Active Proposals',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildProposalCard(context, 'Senior UX Audit', 'Naughty Dog',
              '\$3,200', 'Pending Review'),
          _buildProposalCard(context, 'React Conversion', 'Linear', '\$1,500',
              'Under Discussion'),
          _buildProposalCard(context, 'Brand Identity', 'Stripe', '\$4,500',
              'Interview Scheduled'),
        ],
      ),
    );
  }

  Widget _buildProposalCard(BuildContext context, String title, String company,
      String bid, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: HireIQColors.silver),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: HireIQColors.surface,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(status.toUpperCase(),
                    style: const TextStyle(
                        color: HireIQColors.navy,
                        fontWeight: FontWeight.w900,
                        fontSize: 9,
                        letterSpacing: 0.5)),
              ),
              const Icon(Icons.info_outline_rounded,
                  color: HireIQColors.silver, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: HireIQColors.navy)),
          Text(company,
              style:
                  const TextStyle(color: HireIQColors.textMuted, fontSize: 13)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('YOUR BID',
                      style: TextStyle(
                          color: HireIQColors.textMuted,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                  Text(bid,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: HireIQColors.navy)),
                ],
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('View Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
