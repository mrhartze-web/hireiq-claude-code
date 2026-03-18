import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  static const List<_BlogPost> _posts = [
    _BlogPost(
      category: 'Product',
      title: 'Introducing WildcardIQ: Bias-Free Shortlisting at Scale',
      excerpt:
          'Our new scoring engine anonymises candidate profiles before recruiters see them, resulting in 40% more diverse shortlists in beta testing.',
      date: 'March 2026',
      readTime: '5 min read',
      categoryColor: 0xFF0D9488,
    ),
    _BlogPost(
      category: 'Insights',
      title: 'The State of Tech Hiring in South Africa — Q1 2026',
      excerpt:
          'SignalIQ data reveals a 23% rise in Flutter and React Native demand, while mid-level backend salaries have plateaued for the first time in three years.',
      date: 'February 2026',
      readTime: '8 min read',
      categoryColor: 0xFF1A2B4A,
    ),
    _BlogPost(
      category: 'Guide',
      title: 'How to Build a Verified HireIQ Profile That Gets Noticed',
      excerpt:
          'Candidates with PassportIQ-verified profiles receive 3× more recruiter views. Here is your step-by-step guide to standing out.',
      date: 'January 2026',
      readTime: '6 min read',
      categoryColor: 0xFFF59E0B,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HireIQ Blog',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Insights, product updates, and hiring guides from the HireIQ team.',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: HireIQTheme.textMuted,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            ..._posts.map((post) => _buildPostCard(post)),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.construction_outlined,
                      color: HireIQTheme.primaryTeal, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Full blog with search and categories coming soon.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: HireIQTheme.primaryTeal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildPostCard(_BlogPost post) {
    final color = Color(post.categoryColor);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Text(
                  post.category,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '${post.date}  ·  ${post.readTime}',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: HireIQTheme.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            post.title,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.primaryNavy,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            post.excerpt,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: HireIQTheme.textMuted,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Read article →',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: HireIQTheme.primaryTeal,
            ),
          ),
        ],
      ),
    );
  }
}

class _BlogPost {
  const _BlogPost({
    required this.category,
    required this.title,
    required this.excerpt,
    required this.date,
    required this.readTime,
    required this.categoryColor,
  });
  final String category;
  final String title;
  final String excerpt;
  final String date;
  final String readTime;
  final int categoryColor;
}
