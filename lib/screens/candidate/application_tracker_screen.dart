import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class ApplicationTrackerScreen extends StatefulWidget {
  const ApplicationTrackerScreen({super.key});

  @override
  State<ApplicationTrackerScreen> createState() =>
      _ApplicationTrackerScreenState();
}

class _ApplicationTrackerScreenState extends State<ApplicationTrackerScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        title: Text(
          'My Applications',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: HireIQColors.navy,
              ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildApplicationCard(
              'Senior Product Designer',
              'Stripe',
              'Applied 2 days ago',
              'Under Review',
              'https://logo.clearbit.com/stripe.com',
              statusColor: Colors.orange,
            ),
            _buildApplicationCard(
              'Visual UI Engineer',
              'Linear',
              'Applied 5 days ago',
              'Interviewed',
              'https://logo.clearbit.com/linear.app',
              statusColor: HireIQColors.teal,
            ),
            _buildApplicationCard(
              'Lead UI Designer',
              'Framer',
              'Applied 1 week ago',
              'Sent',
              'https://logo.clearbit.com/framer.com',
              statusColor: HireIQColors.textMuted,
            ),
            _buildApplicationCard(
              'Creative Director',
              'Airbnb',
              'Applied 2 weeks ago',
              'Declined',
              'https://logo.clearbit.com/airbnb.com',
              statusColor: Colors.redAccent,
            ),
            const SizedBox(height: 24),
            _buildImprovePortfolio(),
          ],
        ),
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

  Widget _buildApplicationCard(
    String title,
    String company,
    String time,
    String status,
    String logoUrl, {
    required Color statusColor,
  }) {
    return GestureDetector(
      onTap: () => context.go('/application-detail'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: HireIQColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: HireIQColors.silver),
        ),
        child: Row(
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: HireIQColors.navy,
                    ),
                  ),
                  Text(
                    '$company • $time',
                    style: const TextStyle(
                      fontSize: 13,
                      color: HireIQColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImprovePortfolio() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQColors.navy,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Icon(Icons.stars_rounded, color: Colors.amber, size: 40),
          const SizedBox(height: 16),
          const Text(
            'Improve your chances',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete your portfolio to attract more recruiters.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: HireIQColors.teal,
              foregroundColor: Colors.white,
            ),
            child: const Text('Complete Now'),
          ),
        ],
      ),
    );
  }
}
