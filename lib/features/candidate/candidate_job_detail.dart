import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../mobile_screens.dart';

class CandidateJobDetail extends StatelessWidget {
  const CandidateJobDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Job header card ────────────────────────────────────────
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: _JobHeaderCard(),
                ),

                // ── Tabs ──────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: _buildTabRow(),
                ),

                // ── Body copy ─────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle('About the Role'),
                      const SizedBox(height: 10),
                      Text(
                        'HireIQ is looking for a Senior Full-Stack Developer to lead our core engineering team. You will be responsible for architecting and building scalable solutions that power the future of recruitment tech.',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: HireIQTheme.textSecondary,
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 28),
                      _sectionTitle('Key Responsibilities'),
                      const SizedBox(height: 14),
                      _bullet(
                        'Design and implement high-performance web applications using modern frameworks.',
                      ),
                      _bullet(
                        'Collaborate with product managers and designers to translate requirements into technical specs.',
                      ),
                      _bullet(
                        'Conduct code reviews and maintain high standards for code quality and testing.',
                      ),
                      _bullet(
                        'Optimize application for maximum speed and scalability.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: _ApplySheet(
        onTap: () => context.push(MobileRoutes.candidatePassportProcessing),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: HireIQTheme.primaryNavy,
      foregroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined, size: 20),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.bookmark_border_rounded, size: 20),
          onPressed: () {},
        ),
      ],
      title: Text(
        'Job Details',
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTabRow() {
    return const Row(
      children: [
        _TabItem(label: 'Description', isActive: true),
        SizedBox(width: 24),
        _TabItem(label: 'Requirements'),
        SizedBox(width: 24),
        _TabItem(label: 'Company'),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: HireIQTheme.primaryNavy,
        letterSpacing: -0.2,
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: HireIQTheme.primaryTeal,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: HireIQTheme.textSecondary,
                height: 1.65,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Job header card ───────────────────────────────────────────────────────────

class _JobHeaderCard extends StatelessWidget {
  const _JobHeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company row
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                ),
                child: const Icon(
                  Icons.rocket_launch_rounded,
                  color: HireIQTheme.primaryTeal,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Innovative Tech Solutions',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: HireIQTheme.textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'HireIQ',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy,
                      ),
                    ),
                  ],
                ),
              ),
              // Match badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      size: 12,
                      color: HireIQTheme.primaryTeal,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '94% Match',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryTeal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Job title
          Text(
            'Senior Full-Stack Developer',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: HireIQTheme.primaryNavy,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 14),

          // Info chips
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _InfoChip(
                icon: Icons.location_on_outlined,
                label: 'Johannesburg (Remote)',
              ),
              _InfoChip(
                icon: Icons.payments_outlined,
                label: 'R120k – R160k / yr',
              ),
              _InfoChip(
                icon: Icons.schedule_outlined,
                label: 'Full-time',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Info chip ─────────────────────────────────────────────────────────────────

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: HireIQTheme.backgroundLight,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: HireIQTheme.textMuted),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: HireIQTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tab item ──────────────────────────────────────────────────────────────────

class _TabItem extends StatelessWidget {
  const _TabItem({required this.label, this.isActive = false});

  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
            color:
                isActive ? HireIQTheme.primaryNavy : HireIQTheme.textMuted,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 2,
          width: 20,
          decoration: BoxDecoration(
            color: isActive ? HireIQTheme.primaryTeal : Colors.transparent,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ],
    );
  }
}

// ── Apply bottom sheet ────────────────────────────────────────────────────────

class _ApplySheet extends StatelessWidget {
  const _ApplySheet({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        16 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [HireIQTheme.primaryTeal, Color(0xFF0A7A70)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
            boxShadow: [
              BoxShadow(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.35),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Apply Now with PassportIQ',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
