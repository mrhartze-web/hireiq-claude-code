import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme.dart';

class CandidateGigFeed extends StatelessWidget {
  const CandidateGigFeed({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> gigs = [
      {
        'id': 'g1',
        'title': 'Flutter App — Fintech Dashboard',
        'company': 'Apex Digital',
        'budget': 'R15,000',
        'duration': '2 weeks',
        'tags': 'Flutter, Firebase',
      },
      {
        'id': 'g2',
        'title': 'Brand Identity & Design System',
        'company': 'Synergy Labs',
        'budget': 'R8,500',
        'duration': '1 week',
        'tags': 'UI/UX, Figma',
      },
      {
        'id': 'g3',
        'title': 'Data Pipeline — Firebase to BigQuery',
        'company': 'M-Pesa Africa',
        'budget': 'R25,000',
        'duration': '3 weeks',
        'tags': 'Cloud, SQL',
      },
    ];

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Gig Marketplace'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.filter_list_outlined)),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: gigs.length,
        itemBuilder: (context, index) {
          final gig = gigs[index];
          return _buildGigCard(context, gig);
        },
      ),
    );
  }

  Widget _buildGigCard(BuildContext context, Map<String, String> gig) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => context.push('/candidate/gigs/${gig['id']}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: HireIQTheme.primaryTeal.withAlpha(25),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('New Gig',
                        style: TextStyle(
                            color: HireIQTheme.primaryTeal,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ),
                  Text(gig['budget']!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: HireIQTheme.primaryNavy)),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                gig['title']!,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy),
              ),
              const SizedBox(height: 4),
              Text(gig['company']!,
                  style: const TextStyle(color: HireIQTheme.textMuted)),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.access_time,
                      size: 16, color: HireIQTheme.textMuted),
                  const SizedBox(width: 4),
                  Text(gig['duration']!,
                      style: const TextStyle(
                          fontSize: 12, color: HireIQTheme.textMuted)),
                  const SizedBox(width: 16),
                  const Icon(Icons.label_outline,
                      size: 16, color: HireIQTheme.textMuted),
                  const SizedBox(width: 4),
                  Text(gig['tags']!,
                      style: const TextStyle(
                          fontSize: 12, color: HireIQTheme.textMuted)),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () =>
                        context.push('/candidate/gigs/${gig['id']}'),
                    child: const Text('View Details'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HireIQTheme.primaryNavy,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Apply Now'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
