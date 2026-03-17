import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class RecruiterBriefs extends StatelessWidget {
  const RecruiterBriefs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Briefs'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildBriefCard(
            title: 'Senior Frontend Developer',
            company: 'TechFlow Solutions',
            candidates: 12,
            matchRate: 85,
            priority: 'High',
          ),
          _buildBriefCard(
            title: 'Product Designer (Contract)',
            company: 'Creative Labs',
            candidates: 4,
            matchRate: 72,
            priority: 'Medium',
          ),
          _buildBriefCard(
            title: 'Data Engineer',
            company: 'DataScale Inc.',
            candidates: 8,
            matchRate: 91,
            priority: 'High',
          ),
        ],
      ),
    );
  }

  Widget _buildBriefCard({
    required String title,
    required String company,
    required int candidates,
    required int matchRate,
    required String priority,
  }) {
    final bool isHighPriority = priority == 'High';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
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
                  color: isHighPriority
                      ? HireIQTheme.error.withAlpha(25)
                      : HireIQTheme.amber.withAlpha(25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  priority,
                  style: TextStyle(
                    color:
                        isHighPriority ? HireIQTheme.error : HireIQTheme.amber,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.more_horiz, color: HireIQTheme.textMuted),
            ],
          ),
          const SizedBox(height: 12),
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(company, style: const TextStyle(color: HireIQTheme.textMuted)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStat('Matched', candidates.toString()),
              _buildStat('Match IQ', '$matchRate%'),
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HireIQTheme.primaryTeal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child:
                      const Text('View Match', style: TextStyle(fontSize: 12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 11, color: HireIQTheme.textMuted)),
        Text(value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
