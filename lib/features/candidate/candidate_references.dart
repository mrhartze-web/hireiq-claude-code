import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../shared/components/skeleton_loader.dart';
import '../../shared/components/empty_state.dart';

// ── Providers ─────────────────────────────────────────────────────────────────

final _referencesLoadingProvider = StateProvider<bool>((ref) => false);

// ── Screen ────────────────────────────────────────────────────────────────────

class CandidateReferences extends ConsumerStatefulWidget {
  const CandidateReferences({super.key});

  @override
  ConsumerState<CandidateReferences> createState() =>
      _CandidateReferencesState();
}

class _CandidateReferencesState extends ConsumerState<CandidateReferences> {
  static const _references = [
    _Reference(
      name: 'Nomsa Dlamini',
      company: 'FinCorp SA',
      role: 'Senior HR Director',
      relationship: 'Direct Manager',
      email: 'nomsa.dlamini@fincorpsa.co.za',
      isVerified: true,
      addedDate: '12 Jan 2026',
    ),
    _Reference(
      name: 'Craig Botha',
      company: 'Apex Digital',
      role: 'Engineering Lead',
      relationship: 'Technical Supervisor',
      email: 'craig.botha@apexdigital.co.za',
      isVerified: true,
      addedDate: '20 Jan 2026',
    ),
    _Reference(
      name: 'Thabo Nkosi',
      company: 'TechFlow Solutions',
      role: 'Chief Technology Officer',
      relationship: 'Skip-level Manager',
      email: 'thabo.nkosi@techflow.co.za',
      isVerified: false,
      addedDate: '3 Feb 2026',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(_referencesLoadingProvider);

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── App Bar ──────────────────────────────────────────────────────
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
                onTap: _showAddReferenceSheet,
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
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── MatchIQ Impact Banner ─────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        HireIQTheme.primaryTeal,
                        Color(0xFF0B7A70),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.workspace_premium_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Boost your MatchIQ score',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Verified references increase your MatchIQ score by 15 points',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.85),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Heading ───────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your References',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color:
                            HireIQTheme.primaryNavy.withValues(alpha: 0.06),
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusFull),
                      ),
                      child: Text(
                        '${_references.length} of 5',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: HireIQTheme.primaryNavy,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // ── Loading / Empty / Data ────────────────────────────────
                if (isLoading)
                  const SkeletonLoader(itemCount: 3)
                else if (_references.isEmpty)
                  EmptyState(
                    icon: Icons.people_outline_rounded,
                    heading: 'No references yet',
                    body:
                        'Add your first reference — verified references increase your MatchIQ score by 15 points.',
                    ctaLabel: 'Add Reference',
                    onCtaPressed: _showAddReferenceSheet,
                  )
                else
                  ..._references.map(
                    (r) => _ReferenceCard(
                      reference: r,
                      onEdit: () {},
                      onDelete: () {},
                      onRequest: () {},
                    ),
                  ),

                const SizedBox(height: 16),

                // ── Add Reference Button ──────────────────────────────────
                if (_references.isNotEmpty)
                  GestureDetector(
                    onTap: _showAddReferenceSheet,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: HireIQTheme.primaryTeal.withValues(alpha: 0.05),
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusLg),
                        border: Border.all(
                          color:
                              HireIQTheme.primaryTeal.withValues(alpha: 0.3),
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

      // ── FAB ────────────────────────────────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddReferenceSheet,
        backgroundColor: HireIQTheme.amber,
        foregroundColor: HireIQTheme.primaryNavy,
        icon: const Icon(Icons.person_add_rounded),
        label: Text(
          'Add Reference',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  void _showAddReferenceSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const _AddReferenceSheet(),
    );
  }
}

// ── Reference model ───────────────────────────────────────────────────────────

class _Reference {
  const _Reference({
    required this.name,
    required this.company,
    required this.role,
    required this.relationship,
    required this.email,
    required this.isVerified,
    required this.addedDate,
  });

  final String name;
  final String company;
  final String role;
  final String relationship;
  final String email;
  final bool isVerified;
  final String addedDate;
}

// ── Reference card ────────────────────────────────────────────────────────────

class _ReferenceCard extends StatelessWidget {
  const _ReferenceCard({
    required this.reference,
    required this.onEdit,
    required this.onDelete,
    required this.onRequest,
  });

  final _Reference reference;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onRequest;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(
          color: reference.isVerified
              ? HireIQTheme.primaryTeal.withValues(alpha: 0.3)
              : HireIQTheme.borderLight,
        ),
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
                    reference.name[0].toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryTeal,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reference.name,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${reference.role} • ${reference.company}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: HireIQTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              // Status badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (reference.isVerified
                          ? HireIQTheme.success
                          : HireIQTheme.warning)
                      .withValues(alpha: 0.12),
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      reference.isVerified
                          ? Icons.verified_rounded
                          : Icons.schedule_rounded,
                      size: 11,
                      color: reference.isVerified
                          ? HireIQTheme.success
                          : HireIQTheme.warning,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      reference.isVerified ? 'Verified' : 'Pending',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: reference.isVerified
                            ? HireIQTheme.success
                            : HireIQTheme.warning,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Details row
          Row(
            children: [
              const Icon(Icons.badge_outlined,
                  size: 13, color: HireIQTheme.textMuted),
              const SizedBox(width: 5),
              Text(
                reference.relationship,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: HireIQTheme.textMuted,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.mail_outline_rounded,
                  size: 13, color: HireIQTheme.textMuted),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  reference.email,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: HireIQTheme.textMuted,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: HireIQTheme.borderLight),
          const SizedBox(height: 10),

          // Actions
          Row(
            children: [
              if (!reference.isVerified)
                Expanded(
                  child: GestureDetector(
                    onTap: onRequest,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: HireIQTheme.amber,
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusSm),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Request Verification',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: HireIQTheme.primaryNavy,
                        ),
                      ),
                    ),
                  ),
                ),
              if (!reference.isVerified) const SizedBox(width: 8),
              GestureDetector(
                onTap: onEdit,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: HireIQTheme.backgroundLight,
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusSm),
                  ),
                  child: const Icon(Icons.edit_outlined,
                      size: 15, color: HireIQTheme.textSecondary),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onDelete,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: HireIQTheme.error.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusSm),
                  ),
                  child: const Icon(Icons.delete_outline_rounded,
                      size: 15, color: HireIQTheme.error),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Add Reference Bottom Sheet ────────────────────────────────────────────────

class _AddReferenceSheet extends StatelessWidget {
  const _AddReferenceSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(HireIQTheme.radiusXl)),
      ),
      padding: EdgeInsets.fromLTRB(
          24, 16, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: HireIQTheme.borderLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Add Reference',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: HireIQTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'We\'ll send them a verification request automatically.',
            style: GoogleFonts.inter(
                fontSize: 13, color: HireIQTheme.textMuted),
          ),
          const SizedBox(height: 20),
          _buildField('Full Name', 'e.g. Nomsa Dlamini'),
          const SizedBox(height: 12),
          _buildField('Company', 'e.g. FinCorp SA'),
          const SizedBox(height: 12),
          _buildField('Job Title', 'e.g. HR Director'),
          const SizedBox(height: 12),
          _buildField('Email Address', 'e.g. nomsa@fincorpsa.co.za'),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: HireIQTheme.amber,
                foregroundColor: HireIQTheme.primaryNavy,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusLg)),
              ),
              child: Text(
                'Send Verification Request',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: HireIQTheme.textPrimary)),
        const SizedBox(height: 6),
        TextFormField(
          style: GoogleFonts.inter(
              fontSize: 14, color: HireIQTheme.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                GoogleFonts.inter(color: HireIQTheme.textMuted, fontSize: 13),
            filled: true,
            fillColor: HireIQTheme.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
              borderSide: const BorderSide(color: HireIQTheme.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
              borderSide: const BorderSide(color: HireIQTheme.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
              borderSide:
                  const BorderSide(color: HireIQTheme.primaryTeal, width: 1.5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
      ],
    );
  }
}
