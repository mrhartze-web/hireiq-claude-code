import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/theme.dart';
import '../../providers/auth_provider.dart';
import '../../providers/candidate_provider.dart';
import '../../shared/components/skeleton_loader.dart';
import '../../shared/components/error_state.dart';

class CandidateProfile extends ConsumerWidget {
  const CandidateProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () => const Scaffold(
        body: Center(child: SkeletonLoader()),
      ),
      error: (e, _) => const Scaffold(
        body: ErrorState(message: 'Could not load profile'),
      ),
      data: (user) {
        if (user == null) {
          return const Scaffold(
            body: Center(child: Text('Not signed in')),
          );
        }
        final profileAsync = ref.watch(candidateProfileProvider(user.uid));
        return profileAsync.when(
          loading: () => const Scaffold(
            body: Center(child: SkeletonLoader()),
          ),
          error: (e, _) => const Scaffold(
            body: ErrorState(message: 'Could not load profile'),
          ),
          data: (profile) => Scaffold(
            backgroundColor: HireIQTheme.background,
            appBar: AppBar(
              title: const Text('My Profile'),
              backgroundColor: HireIQTheme.surfaceWhite,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(HireIQTheme.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: HireIQTheme.primaryTeal,
                      child: Text(
                        user.displayName?.substring(0, 1).toUpperCase() ?? 'C',
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: HireIQTheme.spacingMd),
                  Center(
                    child: Text(
                      user.displayName ?? 'Candidate',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  if (profile != null) ...[
                    const SizedBox(height: HireIQTheme.spacingSm),
                    Center(
                      child: Text(
                        profile.headline,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: HireIQTheme.textMuted),
                      ),
                    ),
                    const SizedBox(height: HireIQTheme.spacingLg),
                    _buildSection(context, 'Location', profile.location),
                    _buildSection(context, 'Experience',
                        '${profile.yearsExperience} years'),
                    _buildSection(context, 'Availability',
                        profile.availabilityStatus),
                    _buildSection(context, 'MatchIQ Score',
                        '${profile.matchIQScore.toStringAsFixed(0)}%'),
                    const SizedBox(height: HireIQTheme.spacingMd),
                    Text('Skills',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: HireIQTheme.spacingSm),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: profile.skills
                          .map((skill) => Chip(
                                label: Text(skill),
                                backgroundColor: HireIQTheme.backgroundLight,
                              ))
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSection(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: HireIQTheme.spacingMd),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: HireIQTheme.textMuted,
                  fontWeight: FontWeight.w500)),
          Text(value,
              style: const TextStyle(
                  color: HireIQTheme.textPrimary,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
