import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../providers/recruiter_provider.dart';
import '../../shared/components/skeleton_loader.dart';
import '../../shared/components/empty_state.dart';

class RecruiterPlacementTracker extends ConsumerWidget {
  const RecruiterPlacementTracker({super.key});

  static Color _paymentColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return HireIQTheme.success;
      case 'invoiced':
        return const Color(0xFF3B82F6);
      default:
        return HireIQTheme.amber;
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
    final placementsAsync = ref.watch(recruiterPlacementsProvider(uid));

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Placement Pipeline',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.white),
              onPressed: () {}),
        ],
      ),
      body: placementsAsync.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(20),
          child: SkeletonLoader(itemCount: 3),
        ),
        error: (_, __) => const Center(child: Text('Could not load placements')),
        data: (placements) {
          if (placements.isEmpty) {
            return const EmptyState(
              icon: Icons.people_outline,
              heading: 'No placements yet',
              body: 'Your active placements will appear here',
            );
          }
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Active Submissions',
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.primaryNavy),
              ),
              const SizedBox(height: 16),
              ...placements.map((placement) {
                final statusColor = _paymentColor(placement.paymentStatus);
                final initial = placement.roleName.isNotEmpty
                    ? placement.roleName[0].toUpperCase()
                    : 'P';
                final candidateShort = placement.candidateUid.length > 8
                    ? placement.candidateUid.substring(0, 8)
                    : placement.candidateUid;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: HireIQTheme.surfaceWhite,
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusLg),
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
                        backgroundColor:
                            HireIQTheme.primaryNavy.withValues(alpha: 0.08),
                        child: Text(
                          initial,
                          style: GoogleFonts.inter(
                              color: HireIQTheme.primaryNavy,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              placement.roleName,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: HireIQTheme.primaryNavy),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Candidate #$candidateShort',
                              style: GoogleFonts.inter(
                                  color: HireIQTheme.textMuted, fontSize: 13),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Placed ${_formatDate(placement.placedAt)}',
                              style: GoogleFonts.inter(
                                  color: HireIQTheme.textLight, fontSize: 11),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                    HireIQTheme.radiusFull),
                              ),
                              child: Text(
                                placement.paymentStatus[0].toUpperCase() +
                                    placement.paymentStatus.substring(1),
                                style: GoogleFonts.inter(
                                    color: statusColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          size: 14, color: HireIQTheme.textMuted),
                    ],
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
