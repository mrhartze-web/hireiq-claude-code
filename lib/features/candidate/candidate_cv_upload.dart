import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateCvUpload extends ConsumerStatefulWidget {
  const CandidateCvUpload({super.key});

  @override
  ConsumerState<CandidateCvUpload> createState() => _CandidateCvUploadState();
}

class _CandidateCvUploadState extends ConsumerState<CandidateCvUpload> {
  bool _hasCv = true;

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
              'CV & Documents',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Current CV ────────────────────────────────────────────
                if (_hasCv) ...[
                  Text(
                    'Current CV',
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg),
                      border: Border.all(
                        color: HireIQTheme.primaryTeal.withValues(alpha: 0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              HireIQTheme.primaryNavy.withValues(alpha: 0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 56,
                          decoration: BoxDecoration(
                            color:
                                HireIQTheme.error.withValues(alpha: 0.1),
                            borderRadius:
                                BorderRadius.circular(HireIQTheme.radiusSm),
                          ),
                          child: const Center(
                            child: Text(
                              'PDF',
                              style: TextStyle(
                                color: HireIQTheme.error,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Thabo_Nkosi_CV_2026.pdf',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: HireIQTheme.primaryNavy),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Uploaded 15 Jan 2026 • 2.4 MB',
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: HireIQTheme.textMuted),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: HireIQTheme.success
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(
                                      HireIQTheme.radiusFull),
                                ),
                                child: Text(
                                  '✓ ATS Optimised',
                                  style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: HireIQTheme.success),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_red_eye_outlined,
                                  size: 20, color: HireIQTheme.primaryTeal),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline_rounded,
                                  size: 20, color: HireIQTheme.error),
                              onPressed: () =>
                                  setState(() => _hasCv = false),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // ── Upload Area ───────────────────────────────────────────
                Text(
                  _hasCv ? 'Upload New CV' : 'Upload Your CV',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 36),
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusLg),
                      border: Border.all(
                        color: HireIQTheme.borderMedium,
                        width: 1.5,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: HireIQTheme.primaryTeal
                                .withValues(alpha: 0.08),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.upload_file_rounded,
                              size: 36, color: HireIQTheme.primaryTeal),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Drag & drop or tap to upload',
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: HireIQTheme.primaryNavy),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Maximum file size: 10 MB',
                          style: GoogleFonts.inter(
                              fontSize: 12, color: HireIQTheme.textMuted),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: ['PDF', 'DOC', 'DOCX'].map((fmt) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: HireIQTheme.borderLight,
                                borderRadius: BorderRadius.circular(
                                    HireIQTheme.radiusFull),
                              ),
                              child: Text(
                                fmt,
                                style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: HireIQTheme.textMuted),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ── Upload Button ─────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.upload_rounded),
                    label: Text(
                      'Upload CV',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HireIQTheme.amber,
                      foregroundColor: HireIQTheme.primaryNavy,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusLg)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // ── ForgeIQ Tip ───────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1A2B4A), Color(0xFF243659)],
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
                          color: HireIQTheme.amber.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.auto_awesome_rounded,
                            size: 20, color: HireIQTheme.amber),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ForgeIQ AI CV Builder',
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Let AI generate a tailored CV for each role you apply to',
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color:
                                      Colors.white.withValues(alpha: 0.75),
                                  height: 1.4),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Try ForgeIQ →',
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: HireIQTheme.amber),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
