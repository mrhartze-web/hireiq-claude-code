import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class GigFreelancerProfileScreen extends ConsumerWidget {
  const GigFreelancerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            expandedHeight: 200,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      HireIQTheme.primaryNavy,
                      Color(0xFF1A3A5C),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 36,
                              backgroundColor: HireIQTheme.primaryTeal,
                              child: Text(
                                'TN',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Thabo Nkosi',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    'Senior Flutter Developer · Johannesburg',
                                    style: GoogleFonts.inter(
                                      color: Colors.white
                                          .withValues(alpha: 0.8),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(value: '24', label: 'Projects'),
                      _StatItem(value: '98%', label: 'On-time'),
                      _StatItem(value: '< 2hrs', label: 'Response'),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Badges row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: HireIQTheme.primaryTeal
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(
                              HireIQTheme.radiusFull),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.verified_rounded,
                              size: 14,
                              color: HireIQTheme.primaryTeal,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'PassportIQ Verified',
                              style: GoogleFonts.inter(
                                color: HireIQTheme.primaryTeal,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: HireIQTheme.amber.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(
                              HireIQTheme.radiusFull),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 14,
                              color: HireIQTheme.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Top Rated',
                              style: GoogleFonts.inter(
                                color: HireIQTheme.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Skills',
                    style: GoogleFonts.inter(
                      color: HireIQTheme.primaryNavy,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      'Flutter',
                      'Dart',
                      'Firebase',
                      'Riverpod',
                      'GoRouter',
                      'REST APIs',
                      'UI/UX',
                      'Testing',
                    ]
                        .map(
                          (skill) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: HireIQTheme.primaryTeal
                                  .withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(
                                  HireIQTheme.radiusFull),
                              border:
                                  Border.all(color: HireIQTheme.borderLight),
                            ),
                            child: Text(
                              skill,
                              style: GoogleFonts.inter(
                                color: HireIQTheme.primaryNavy,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Portfolio',
                    style: GoogleFonts.inter(
                      color: HireIQTheme.primaryNavy,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),

                  _PortfolioCard(
                    title: 'FinTech Dashboard',
                    description: 'React-style financial analytics app',
                    techTags: 'Flutter · Firebase',
                    amount: 'R28,000',
                  ),
                  _PortfolioCard(
                    title: 'E-Commerce App',
                    description: 'Full shopping experience with payments',
                    techTags: 'Flutter · Stripe',
                    amount: 'R22,000',
                  ),
                  _PortfolioCard(
                    title: 'Health Tracker',
                    description: 'Wearable data sync app',
                    techTags: 'Flutter · BLE',
                    amount: 'R18,000',
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Reviews',
                    style: GoogleFonts.inter(
                      color: HireIQTheme.primaryNavy,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),

                  _ReviewCard(
                    initial: 'F',
                    name: 'FinCorp SA',
                    review:
                        'Exceptional developer. Delivered ahead of schedule with outstanding quality.',
                  ),
                  _ReviewCard(
                    initial: 'T',
                    name: 'TechFlow Ltd',
                    review:
                        'Highly recommended. Thabo went above and beyond on every milestone.',
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Proposal sent to Thabo Nkosi!'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HireIQTheme.amber,
                        foregroundColor: HireIQTheme.primaryNavy,
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              HireIQTheme.radiusLg),
                        ),
                      ),
                      child: Text(
                        'Hire this Freelancer',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            color: HireIQTheme.primaryNavy,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            color: HireIQTheme.textMuted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _PortfolioCard extends StatelessWidget {
  final String title;
  final String description;
  final String techTags;
  final String amount;

  const _PortfolioCard({
    required this.title,
    required this.description,
    required this.techTags,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: HireIQTheme.primaryNavy,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: GoogleFonts.inter(
              color: HireIQTheme.textMuted,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                techTags,
                style: GoogleFonts.inter(
                  color: HireIQTheme.primaryTeal,
                  fontSize: 11,
                ),
              ),
              const Spacer(),
              Text(
                amount,
                style: GoogleFonts.inter(
                  color: HireIQTheme.primaryNavy,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String initial;
  final String name;
  final String review;

  const _ReviewCard({
    required this.initial,
    required this.name,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: HireIQTheme.primaryNavy,
                child: Text(
                  initial,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                name,
                style: GoogleFonts.inter(
                  color: HireIQTheme.primaryNavy,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  5,
                  (_) => const Icon(
                    Icons.star_rounded,
                    size: 14,
                    color: HireIQTheme.amber,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            review,
            style: GoogleFonts.inter(
              color: HireIQTheme.textMuted,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
