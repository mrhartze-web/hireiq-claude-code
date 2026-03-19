import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class GigActiveContractScreen extends ConsumerWidget {
  const GigActiveContractScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: HireIQTheme.primaryNavy),
        title: Text(
          'Active Contract',
          style: GoogleFonts.inter(
            color: HireIQTheme.primaryNavy,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: HireIQTheme.success.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
            ),
            child: Text(
              'Active',
              style: GoogleFonts.inter(
                color: HireIQTheme.success,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Client card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(color: HireIQTheme.borderLight),
                boxShadow: [
                  BoxShadow(
                    color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: HireIQTheme.primaryTeal,
                    child: Text(
                      'FC',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FinCorp SA',
                          style: GoogleFonts.inter(
                            color: HireIQTheme.primaryNavy,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Mobile App Development',
                          style: GoogleFonts.inter(
                            color: HireIQTheme.textMuted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Contract value
            Center(
              child: Column(
                children: [
                  Text(
                    'Contract Value',
                    style: GoogleFonts.inter(
                      color: HireIQTheme.textMuted,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'R45,000',
                    style: GoogleFonts.inter(
                      color: HireIQTheme.primaryNavy,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Milestones',
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),

            _MilestoneCard(
              number: '1',
              title: 'UI Wireframes',
              subtitle: 'Due 10 Feb · R8,000',
              status: 'Paid',
              milestoneState: _MilestoneState.completed,
            ),
            _MilestoneCard(
              number: '2',
              title: 'Frontend Build',
              subtitle: 'Due 28 Feb · R15,000',
              status: 'Paid',
              milestoneState: _MilestoneState.completed,
            ),
            _MilestoneCard(
              number: '3',
              title: 'API Integration',
              subtitle: 'Due 20 Mar · R15,000',
              status: 'In Progress',
              milestoneState: _MilestoneState.active,
            ),
            _MilestoneCard(
              number: '4',
              title: 'Testing & Launch',
              subtitle: 'Due 10 Apr · R7,000',
              status: 'Pending',
              milestoneState: _MilestoneState.pending,
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Milestone submitted for review.'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.amber,
                  foregroundColor: HireIQTheme.primaryNavy,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                  ),
                ),
                child: Text(
                  'Submit Milestone 3',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.message_outlined,
                    color: HireIQTheme.primaryNavy),
                label: Text(
                  'Message Client',
                  style: GoogleFonts.inter(color: HireIQTheme.primaryNavy),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: HireIQTheme.primaryNavy),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Center(
              child: TextButton(
                onPressed: () => context.push('/candidate/gig/dispute'),
                child: Text(
                  'Raise a dispute',
                  style: GoogleFonts.inter(color: HireIQTheme.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _MilestoneState { completed, active, pending }

class _MilestoneCard extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  final String status;
  final _MilestoneState milestoneState;

  const _MilestoneCard({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.milestoneState,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = milestoneState == _MilestoneState.active;
    final isCompleted = milestoneState == _MilestoneState.completed;
    final isPending = milestoneState == _MilestoneState.pending;

    Color borderColor = isActive
        ? HireIQTheme.primaryTeal.withValues(alpha: 0.3)
        : HireIQTheme.borderLight;

    Color bgColor = isActive
        ? HireIQTheme.primaryTeal.withValues(alpha: 0.03)
        : HireIQTheme.surfaceWhite;

    Color numBg = isCompleted
        ? HireIQTheme.success.withValues(alpha: 0.1)
        : isActive
            ? HireIQTheme.primaryTeal.withValues(alpha: 0.1)
            : HireIQTheme.background;

    Color numColor = isCompleted
        ? HireIQTheme.success
        : isActive
            ? HireIQTheme.primaryTeal
            : HireIQTheme.textMuted;

    Color tagBg;
    Color tagColor;
    if (isCompleted) {
      tagBg = HireIQTheme.success.withValues(alpha: 0.1);
      tagColor = HireIQTheme.success;
    } else if (isActive) {
      tagBg = HireIQTheme.primaryTeal.withValues(alpha: 0.1);
      tagColor = HireIQTheme.primaryTeal;
    } else if (status == 'Paid') {
      tagBg = HireIQTheme.amber.withValues(alpha: 0.1);
      tagColor = HireIQTheme.amber;
    } else {
      tagBg = HireIQTheme.background;
      tagColor = HireIQTheme.textMuted;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: numBg,
              borderRadius: BorderRadius.circular(HireIQTheme.radiusSm),
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: GoogleFonts.inter(
                color: numColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: HireIQTheme.primaryNavy,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: HireIQTheme.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: tagBg,
              borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
            ),
            child: Text(
              status,
              style: GoogleFonts.inter(
                color: tagColor,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
