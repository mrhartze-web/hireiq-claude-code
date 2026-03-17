import 'package:flutter/material.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:go_router/go_router.dart';

class CandidateDashboardHome extends StatelessWidget {
  const CandidateDashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        title: const Text('Dashboard',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push('/notifications'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMatchIqScore(context),
            const SizedBox(height: 24),
            Text('Quick Actions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy)),
            const SizedBox(height: 16),
            _buildActionCards(context),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recommended Jobs',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy)),
                TextButton(
                  onPressed: () => context.go('/candidate/jobs'),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildRecommendedJobs(),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchIqScore(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQTheme.primaryNavy,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: 0.85,
                  backgroundColor: Colors.white24,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal),
                  strokeWidth: 8,
                ),
              ),
              Text('85%',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('MatchIQ Score',
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 4),
                const Text('Excellent Fit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () =>
                      context.push('/candidate/matchiq-explanation'),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: HireIQTheme.primaryTeal,
                  ),
                  child: const Text('Improve score'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCards(BuildContext context) {
    return Row(
      children: [
        _buildActionCard(context, 'Saved Jobs', Icons.bookmark_outline,
            '/candidate/saved-jobs', HireIQTheme.primaryNavy),
        const SizedBox(width: 12),
        _buildActionCard(context, 'Video Pitch', Icons.videocam_outlined,
            '/candidate/video-pitch', HireIQTheme.primaryTeal),
        const SizedBox(width: 12),
        _buildActionCard(context, 'PassportIQ', Icons.verified_user_outlined,
            '/passport-iq', HireIQTheme.amber),
      ],
    );
  }

  Widget _buildActionCard(BuildContext context, String title, IconData icon,
      String route, Color color) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.push(route),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          decoration: BoxDecoration(
            color: HireIQTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: HireIQTheme.borderLight),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: HireIQTheme.primaryNavy),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendedJobs() {
    return Column(
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: HireIQTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: HireIQTheme.borderLight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: HireIQTheme.primaryTeal.withAlpha(25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.business,
                        color: HireIQTheme.primaryTeal),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: HireIQTheme.primaryTeal.withAlpha(25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.auto_awesome,
                            color: HireIQTheme.primaryTeal, size: 14),
                        SizedBox(width: 4),
                        Text('92% Match',
                            style: TextStyle(
                                color: HireIQTheme.primaryTeal,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Senior Flutter Developer',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 4),
              const Text('Apex Digital • Remote',
                  style: TextStyle(color: HireIQTheme.textMuted, fontSize: 14)),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.payments_outlined,
                      size: 16, color: HireIQTheme.textMuted),
                  const SizedBox(width: 6),
                  const Text('R45k - R60k / month',
                      style: TextStyle(
                          color: HireIQTheme.textMuted, fontSize: 13)),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text('View Details',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
