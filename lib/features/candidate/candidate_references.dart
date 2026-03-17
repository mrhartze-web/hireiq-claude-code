import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateReferences extends StatelessWidget {
  const CandidateReferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'References',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  'Your References',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.primaryNavy,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Verified references boost employer trust.',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: HireIQTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 20),
                const _ReferenceCard(
                  name: 'Jane Doe',
                  role: 'Engineering Manager, Apex Digital',
                  isVerified: true,
                ),
                const _ReferenceCard(
                  name: 'John Smith',
                  role: 'Lead Developer, FinTech Startup',
                  isVerified: false,
                  isLast: true,
                ),
                const SizedBox(height: 20),
                // Add button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: HireIQTheme.primaryTeal.withValues(alpha: 0.05),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg),
                      border: Border.all(
                        color: HireIQTheme.primaryTeal
                            .withValues(alpha: 0.25),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_rounded,
                          size: 18,
                          color: HireIQTheme.primaryTeal,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Add Reference',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: HireIQTheme.primaryTeal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Reference card ─────────────────────────────────────────────────────────────

class _ReferenceCard extends StatelessWidget {
  const _ReferenceCard({
    required this.name,
    required this.role,
    required this.isVerified,
    this.isLast = false,
  });

  final String name;
  final String role;
  final bool isVerified;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 14),
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
          // Avatar
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                name[0].toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.primaryTeal,
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: HireIQTheme.primaryNavy,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  role,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: HireIQTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Icon(
                      isVerified
                          ? Icons.verified_rounded
                          : Icons.schedule_rounded,
                      size: 13,
                      color: isVerified
                          ? HireIQTheme.primaryTeal
                          : HireIQTheme.warning,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isVerified
                          ? 'Verified Reference'
                          : 'Pending Verification',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isVerified
                            ? HireIQTheme.primaryTeal
                            : HireIQTheme.warning,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Actions
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: HireIQTheme.backgroundLight,
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusSm),
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    size: 15,
                    color: HireIQTheme.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: HireIQTheme.error.withValues(alpha: 0.08),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusSm),
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    size: 15,
                    color: HireIQTheme.error,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
