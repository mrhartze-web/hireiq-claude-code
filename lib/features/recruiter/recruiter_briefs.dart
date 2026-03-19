import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../providers/recruiter_provider.dart';
import '../../shared/components/skeleton_loader.dart';
import '../../shared/components/empty_state.dart';

class RecruiterBriefs extends ConsumerWidget {
  const RecruiterBriefs({super.key});

  static Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return HireIQTheme.primaryTeal;
      case 'active':
        return HireIQTheme.primaryNavy;
      case 'filled':
        return HireIQTheme.success;
      default:
        return HireIQTheme.textMuted;
    }
  }

  static String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(authStateProvider).value?.uid ?? '';
    final briefsAsync = ref.watch(recruiterBriefsProvider(uid));

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Active Briefs',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          if (briefsAsync.isLoading)
            const SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: SkeletonLoader(itemCount: 3),
              ),
            )
          else if (briefsAsync.hasError)
            SliverFillRemaining(
              child: Center(
                child: Text(
                  'Could not load briefs',
                  style: GoogleFonts.inter(color: HireIQTheme.textMuted),
                ),
              ),
            )
          else if ((briefsAsync.valueOrNull ?? []).isEmpty)
            SliverFillRemaining(
              child: EmptyState(
                icon: Icons.assignment_outlined,
                heading: 'No briefs yet',
                body: 'Create your first brief to start matching candidates',
                ctaLabel: 'New Brief',
                onCtaPressed: () => context.push('/recruiter/brief-builder'),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final brief = briefsAsync.valueOrNull![index];
                    final statusColor = _statusColor(brief.status);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: HireIQTheme.surfaceWhite,
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusLg),
                        border: Border.all(color: HireIQTheme.borderLight),
                        boxShadow: [
                          BoxShadow(
                            color: HireIQTheme.primaryNavy
                                .withValues(alpha: 0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color:
                                      statusColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(
                                      HireIQTheme.radiusFull),
                                ),
                                child: Text(
                                  brief.status[0].toUpperCase() +
                                      brief.status.substring(1),
                                  style: GoogleFonts.inter(
                                    color: statusColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Icon(Icons.more_horiz,
                                  color: HireIQTheme.textMuted),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            brief.roleName,
                            style: GoogleFonts.inter(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: HireIQTheme.textPrimary),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Created ${_formatDate(brief.createdAt)}',
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                color: HireIQTheme.textMuted),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              _buildStat('Submissions',
                                  '${brief.submissionsCount}'),
                              _buildStat('Industry', brief.industry),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        HireIQTheme.primaryTeal,
                                        Color(0xFF0A7A70),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        HireIQTheme.radiusMd),
                                  ),
                                  child: Text(
                                    'View Brief',
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: briefsAsync.valueOrNull!.length,
                ),
              ),
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
            style: GoogleFonts.inter(
                fontSize: 11, color: HireIQTheme.textMuted)),
        const SizedBox(height: 2),
        Text(value,
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.textPrimary)),
      ],
    );
  }
}
