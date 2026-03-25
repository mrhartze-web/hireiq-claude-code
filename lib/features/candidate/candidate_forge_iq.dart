import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_provider.dart';
import '../../shared/theme.dart';

class CandidateForgeIq extends ConsumerStatefulWidget {
  const CandidateForgeIq({super.key});

  @override
  ConsumerState<CandidateForgeIq> createState() => _CandidateForgeIqState();
}

class _CandidateForgeIqState extends ConsumerState<CandidateForgeIq> {
  bool _generatingCV = false;
  bool _generatingCoverLetter = false;

  Future<void> _generate(String type) async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return;

    setState(() {
      if (type == 'cv') {
        _generatingCV = true;
      } else {
        _generatingCoverLetter = true;
      }
    });

    try {
      final callable = FirebaseFunctions.instanceFor(region: 'us-central1')
          .httpsCallable('forgeIQ');
      final result = await callable.call<Map<String, dynamic>>({'type': type});

      final content = result.data['content'] as String? ?? '';
      final cvId = result.data['cvId'] as String? ?? '';

      if (!mounted) return;
      context.push('/candidate/cv-preview', extra: {
        'cvContent': content,
        'cvId': cvId,
        'type': type,
      });
    } on FirebaseFunctionsException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message ?? 'Failed to generate'}'),
          backgroundColor: HireIQTheme.error,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: HireIQTheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _generatingCV = false;
          _generatingCoverLetter = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).value;

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
              'ForgeIQ CV Builder',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: _generatingCV ? null : () => _generate('cv'),
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.2),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: _generatingCV
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Save & Export',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── AI Banner ─────────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          HireIQTheme.primaryNavy,
                          Color(0xFF243659),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusXl),
                      boxShadow: [
                        BoxShadow(
                          color: HireIQTheme.primaryNavy
                              .withValues(alpha: 0.25),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: HireIQTheme.primaryTeal
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(
                                HireIQTheme.radiusMd),
                          ),
                          child: const Icon(
                            Icons.build_circle_rounded,
                            color: HireIQTheme.primaryTeal,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AI CV Optimizer',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'ForgeIQ formats and optimizes your experience for ATS systems.',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.white
                                      .withValues(alpha: 0.65),
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

                  // ── Generate buttons ────────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: _GenerateButton(
                          label: 'Generate CV',
                          icon: Icons.description_outlined,
                          isLoading: _generatingCV,
                          onTap: () => _generate('cv'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _GenerateButton(
                          label: 'Cover Letter',
                          icon: Icons.mail_outline_rounded,
                          isLoading: _generatingCoverLetter,
                          onTap: () => _generate('cover_letter'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // ── Experience ─────────────────────────────────────────
                  const _SectionHeader(title: 'Experience'),
                  const SizedBox(height: 14),
                  const _CvListItem(
                    title: 'Senior Backend Engineer',
                    subtitle: 'Apex Digital  ·  2021 – Present',
                  ),
                  const _CvListItem(
                    title: 'Software Developer',
                    subtitle: 'FinTech Startup  ·  2018 – 2021',
                  ),
                  _AddButton(label: 'Add Experience', onTap: () {}),

                  const SizedBox(height: 28),

                  // ── Education ──────────────────────────────────────────
                  const _SectionHeader(title: 'Education'),
                  const SizedBox(height: 14),
                  const _CvListItem(
                    title: 'BSc Computer Science',
                    subtitle: 'University of Cape Town  ·  2014 – 2017',
                  ),
                  _AddButton(label: 'Add Education', onTap: () {}),

                  const SizedBox(height: 28),

                  // ── Skills ─────────────────────────────────────────────
                  const _SectionHeader(title: 'Skills'),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['Flutter', 'Dart', 'Firebase', 'Go', 'AWS']
                        .map(
                          (skill) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 7),
                            decoration: BoxDecoration(
                              color: HireIQTheme.surfaceWhite,
                              borderRadius: BorderRadius.circular(
                                  HireIQTheme.radiusFull),
                              border: Border.all(
                                  color: HireIQTheme.borderLight),
                              boxShadow: [
                                BoxShadow(
                                  color: HireIQTheme.primaryNavy
                                      .withValues(alpha: 0.04),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  skill,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: HireIQTheme.textPrimary,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.close_rounded,
                                    size: 14,
                                    color: HireIQTheme.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  _AddButton(label: 'Add Skill', onTap: () {}),

                  const SizedBox(height: 36),

                  // ── Previously Generated CVs ────────────────────────────
                  if (user != null) ...[
                    const _SectionHeader(title: 'Generated Documents'),
                    const SizedBox(height: 14),
                    _GeneratedCvsList(candidateUid: user.uid),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Generate button ─────────────────────────────────────────────────────────────

class _GenerateButton extends StatelessWidget {
  const _GenerateButton({
    required this.label,
    required this.icon,
    required this.isLoading,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isLoading
              ? HireIQTheme.primaryTeal.withValues(alpha: 0.6)
              : HireIQTheme.primaryTeal,
          borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
          boxShadow: [
            BoxShadow(
              color: HireIQTheme.primaryTeal.withValues(alpha: 0.25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              )
            else
              Icon(icon, size: 18, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              isLoading ? 'Generating…' : label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Generated CVs list ──────────────────────────────────────────────────────────

class _GeneratedCvsList extends StatelessWidget {
  const _GeneratedCvsList({required this.candidateUid});
  final String candidateUid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('generated_cvs')
          .where('candidateUid', isEqualTo: candidateUid)
          .orderBy('generatedAt', descending: true)
          .limit(10)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: CircularProgressIndicator(
                  color: HireIQTheme.primaryTeal, strokeWidth: 2),
            ),
          );
        }

        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: HireIQTheme.surfaceWhite,
              borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
              border: Border.all(color: HireIQTheme.borderLight),
            ),
            child: Center(
              child: Text(
                'No generated documents yet.\nTap "Generate CV" to create your first AI-powered CV.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: HireIQTheme.textMuted,
                  height: 1.5,
                ),
              ),
            ),
          );
        }

        return Column(
          children: docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final type = data['type'] as String? ?? 'cv';
            final generatedAt = data['generatedAt'] as Timestamp?;
            final dateStr = generatedAt != null
                ? _formatDate(generatedAt.toDate())
                : 'Recently';
            final content = data['content'] as String? ?? '';

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(color: HireIQTheme.borderLight),
                boxShadow: [
                  BoxShadow(
                    color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusSm),
                    ),
                    child: Icon(
                      type == 'cover_letter'
                          ? Icons.mail_outline_rounded
                          : Icons.description_outlined,
                      size: 20,
                      color: HireIQTheme.primaryTeal,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type == 'cover_letter'
                              ? 'Cover Letter'
                              : 'AI-Generated CV',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: HireIQTheme.primaryNavy,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          dateStr,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: HireIQTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/candidate/cv-preview', extra: {
                      'cvContent': content,
                      'cvId': doc.id,
                      'type': type,
                    }),
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: HireIQTheme.backgroundLight,
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusSm),
                      ),
                      child: const Icon(
                        Icons.visibility_outlined,
                        size: 16,
                        color: HireIQTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  String _formatDate(DateTime dt) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }
}

// ── Section header ─────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: HireIQTheme.primaryNavy,
        letterSpacing: -0.3,
      ),
    );
  }
}

// ── CV list item ───────────────────────────────────────────────────────────────

class _CvListItem extends StatelessWidget {
  const _CvListItem({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: HireIQTheme.primaryNavy,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: HireIQTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: HireIQTheme.backgroundLight,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusSm),
              ),
              child: const Icon(
                Icons.edit_outlined,
                size: 16,
                color: HireIQTheme.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Add button ─────────────────────────────────────────────────────────────────

class _AddButton extends StatelessWidget {
  const _AddButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: HireIQTheme.primaryTeal.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
          border: Border.all(
            color: HireIQTheme.primaryTeal.withValues(alpha: 0.25),
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
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: HireIQTheme.primaryTeal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
