import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
              'Edit Profile',
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.2),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: Text(
                    'Save',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 48),
              child: Column(
                children: [
                  // ── Avatar ────────────────────────────────────────────
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: HireIQTheme.primaryTeal,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor:
                              HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                          child: const Icon(
                            Icons.person_rounded,
                            size: 44,
                            color: HireIQTheme.primaryTeal,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: HireIQTheme.primaryTeal,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // ── Personal info ─────────────────────────────────────
                  const _EditSection(
                    title: 'Personal Info',
                    children: [
                      _EditField(
                        label: 'Full Name',
                        initialValue: 'Thabo Nkosi',
                      ),
                      _EditField(
                        label: 'Bio',
                        initialValue:
                            'Senior Flutter Developer with 5+ years of experience in fintech and mobile commerce.',
                        maxLines: 3,
                      ),
                      _EditField(
                        label: 'Location',
                        initialValue: 'Johannesburg, South Africa',
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Work experience ───────────────────────────────────
                  _EditSection(
                    title: 'Work Experience',
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: HireIQTheme.surfaceWhite,
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusMd),
                          border:
                              Border.all(color: HireIQTheme.borderLight),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Senior Flutter Developer',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: HireIQTheme.primaryNavy,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'FinServ SA  ·  2021 – Present',
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
                              child: const Icon(
                                Icons.edit_outlined,
                                size: 18,
                                color: HireIQTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            color: HireIQTheme.primaryTeal
                                .withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(
                                HireIQTheme.radiusMd),
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
                                size: 16,
                                color: HireIQTheme.primaryTeal,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Add Experience',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: HireIQTheme.primaryTeal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Skills ────────────────────────────────────────────
                  _EditSection(
                    title: 'Skills',
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          'Flutter',
                          'Dart',
                          'Riverpod',
                          'Firebase',
                          'Clean Architecture',
                          'CI/CD',
                        ]
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
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      skill,
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: HireIQTheme.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Icon(
                                      Icons.close_rounded,
                                      size: 13,
                                      color: HireIQTheme.textMuted,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Edit section ───────────────────────────────────────────────────────────────

class _EditSection extends StatelessWidget {
  const _EditSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: HireIQTheme.primaryNavy,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 14),
        ...children,
      ],
    );
  }
}

// ── Edit field ─────────────────────────────────────────────────────────────────

class _EditField extends StatelessWidget {
  const _EditField({
    required this.label,
    required this.initialValue,
    this.maxLines = 1,
  });

  final String label;
  final String initialValue;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: HireIQTheme.textMuted,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: TextEditingController(text: initialValue),
            maxLines: maxLines,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: HireIQTheme.textPrimary,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: HireIQTheme.surfaceWhite,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(HireIQTheme.radiusMd),
                borderSide:
                    const BorderSide(color: HireIQTheme.borderLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(HireIQTheme.radiusMd),
                borderSide:
                    const BorderSide(color: HireIQTheme.borderLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(HireIQTheme.radiusMd),
                borderSide: const BorderSide(
                    color: HireIQTheme.primaryTeal, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
