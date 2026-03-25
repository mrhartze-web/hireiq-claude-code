import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme.dart';
import '../../providers/auth_provider.dart';
import '../../providers/recruiter_provider.dart';
import '../../models/brief_model.dart';
import '../../shared/components/skeleton_loader.dart';
import '../../shared/components/empty_state.dart';

class RecruiterDashboard extends ConsumerWidget {
  const RecruiterDashboard({super.key});

  static String _rands(double v) {
    if (v >= 1000000) return 'R${(v / 1000000).toStringAsFixed(1)}m';
    if (v >= 1000) return 'R${(v / 1000).round()}k';
    return 'R${v.toInt()}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final uid = authState.value?.uid ?? '';
    final firstName =
        authState.value?.displayName?.split(' ').first ?? 'there';
    final briefsAsync = ref.watch(recruiterBriefsProvider(uid));
    final placementsAsync = ref.watch(recruiterPlacementsProvider(uid));

    final briefs = briefsAsync.valueOrNull ?? [];
    final placements = placementsAsync.valueOrNull ?? [];
    final totalEarnings =
        placements.fold(0.0, (sum, p) => sum + p.feeAmount * 0.80);

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
              'Recruiter Console',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.white),
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor:
                      HireIQTheme.primaryTeal.withValues(alpha: 0.2),
                  child: Text(
                    firstName.isNotEmpty
                        ? firstName[0].toUpperCase()
                        : 'R',
                    style: GoogleFonts.inter(
                        color: HireIQTheme.primaryTeal,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, $firstName',
                    style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Here's your performance overview for today.",
                    style: GoogleFonts.inter(
                        fontSize: 14, color: HireIQTheme.textMuted),
                  ),
                  const SizedBox(height: 24),

                  // ── Stats grid ──────────────────────────────────────────
                  if (briefsAsync.isLoading || placementsAsync.isLoading)
                    const SkeletonLoader(itemCount: 2)
                  else
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                      children: [
                        _buildStatCard('Total Earnings',
                            _rands(totalEarnings), Icons.account_tree_outlined),
                        _buildStatCard('Active Briefs', '${briefs.length}',
                            Icons.assignment_outlined),
                        _buildStatCard('Placements', '${placements.length}',
                            Icons.check_circle_outline),
                        _buildStatCard('Platform Cut', '20%', Icons.percent),
                      ],
                    ),

                  const SizedBox(height: 32),
                  _buildSectionHeader('Quick Actions'),
                  const SizedBox(height: 16),
                  _buildQuickActions(context),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Recent Briefs'),
                  const SizedBox(height: 16),

                  // ── Recent briefs ───────────────────────────────────────
                  if (briefsAsync.isLoading)
                    const SkeletonLoader(itemCount: 2)
                  else if (briefs.isEmpty)
                    EmptyState(
                      icon: Icons.assignment_outlined,
                      heading: 'No briefs yet',
                      body:
                          'Create your first brief to start matching candidates',
                      ctaLabel: 'New Brief',
                      onCtaPressed: () =>
                          context.push('/recruiter/brief-builder'),
                    )
                  else
                    ...briefs.take(3).map(_buildBriefCard),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBriefCard(BriefModel brief) {
    final Color statusColor;
    switch (brief.status.toLowerCase()) {
      case 'open':
        statusColor = HireIQTheme.primaryTeal;
        break;
      case 'active':
        statusColor = HireIQTheme.primaryNavy;
        break;
      case 'filled':
        statusColor = HireIQTheme.success;
        break;
      default:
        statusColor = HireIQTheme.textMuted;
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
            child: Text(
              brief.roleName.isNotEmpty ? brief.roleName[0] : 'B',
              style: GoogleFonts.inter(
                  color: HireIQTheme.primaryTeal,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brief.roleName,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: HireIQTheme.textPrimary),
                ),
                Text(
                  '${brief.submissionsCount} submissions',
                  style: GoogleFonts.inter(
                      color: HireIQTheme.textMuted, fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius:
                  BorderRadius.circular(HireIQTheme.radiusFull),
            ),
            child: Text(
              brief.status,
              style: GoogleFonts.inter(
                  color: statusColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: HireIQTheme.primaryTeal, size: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy)),
              Text(label,
                  style: GoogleFonts.inter(
                      fontSize: 12, color: HireIQTheme.textMuted)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy)),
        GestureDetector(
          onTap: () {},
          child: Text(
            'View All',
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: HireIQTheme.primaryTeal),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(
            context, 'New Brief', Icons.add_box, HireIQTheme.primaryTeal),
        _buildActionButton(
            context, 'Search', Icons.search, const Color(0xFFF59E0B)),
        _buildActionButton(
            context, 'Signals', Icons.bolt, HireIQTheme.primaryNavy),
        _buildActionButton(
            context, 'Report', Icons.bar_chart, HireIQTheme.primaryTeal),
      ],
    );
  }

  Widget _buildActionButton(
      BuildContext context, String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: HireIQTheme.textPrimary)),
      ],
    );
  }
}
