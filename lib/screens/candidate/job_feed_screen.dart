import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class JobFeedScreen extends StatefulWidget {
  const JobFeedScreen({super.key});

  @override
  State<JobFeedScreen> createState() => _JobFeedScreenState();
}

class _JobFeedScreenState extends State<JobFeedScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        title: Text(
          'HireIQ',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: HireIQColors.navy,
                letterSpacing: -1,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.go('/notifications'),
            icon: const Icon(Icons.notifications_none_rounded,
                color: HireIQColors.navy),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommended for you',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: HireIQColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 20),
                  _buildJobCard(
                    'Senior UX Designer',
                    'Google Inc.',
                    'Mountain View, CA',
                    '\$150k - \$200k',
                    'Full-time',
                    'https://logo.clearbit.com/google.com',
                  ),
                  _buildJobCard(
                    'Product Manager',
                    'Airbnb',
                    'Remote',
                    '\$140k - \$180k',
                    'Full-time',
                    'https://logo.clearbit.com/airbnb.com',
                  ),
                  _buildJobCard(
                    'Backend Engineer',
                    'Stripe',
                    'San Francisco, CA',
                    '\$160k - \$210k',
                    'Contract',
                    'https://logo.clearbit.com/stripe.com',
                  ),
                  _buildJobCard(
                    'Content Strategist',
                    'Notion',
                    'Remote',
                    '\$110k - \$150k',
                    'Full-time',
                    'https://logo.clearbit.com/notion.so',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 0) context.go('/job-feed');
          if (index == 1) context.go('/application-tracker');
          if (index == 2) context.go('/candidate-profile');
          if (index == 3) context.go('/settings');
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: HireIQColors.teal,
        unselectedItemColor: HireIQColors.textMuted,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.business_center_rounded), label: 'Applications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    final filters = ['All', 'Remote', 'Full-time', 'Contract'];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            final isSelected = index == 0;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? HireIQColors.teal : HireIQColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? HireIQColors.teal : HireIQColors.silver,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: HireIQColors.teal.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  filters[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : HireIQColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildJobCard(
    String title,
    String company,
    String location,
    String salary,
    String type,
    String logoUrl,
  ) {
    return GestureDetector(
      onTap: () => context.go('/job-detail'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: HireIQColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: HireIQColors.silver),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: HireIQColors.silver.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(logoUrl),
                      fit: BoxFit.cover,
                      onError: (_, __) {},
                    ),
                  ),
                  child: logoUrl.isEmpty ? const Icon(Icons.business) : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HireIQColors.navy,
                        ),
                      ),
                      Text(
                        company,
                        style: const TextStyle(
                          fontSize: 14,
                          color: HireIQColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.bookmark_border_rounded,
                    color: HireIQColors.silver),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildTag(Icons.location_on_outlined, location),
                const SizedBox(width: 12),
                _buildTag(Icons.access_time_rounded, type),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  salary,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: HireIQColors.teal,
                  ),
                ),
                const Text(
                  '2h ago',
                  style: TextStyle(
                    fontSize: 12,
                    color: HireIQColors.textMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: HireIQColors.silver.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: HireIQColors.textMuted),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: HireIQColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
