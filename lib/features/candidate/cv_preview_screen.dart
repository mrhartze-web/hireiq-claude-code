import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import '../../shared/theme.dart';

class CVPreviewScreen extends StatelessWidget {
  const CVPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final extra =
        GoRouterState.of(context).extra as Map<String, dynamic>? ?? {};
    final cvContent = extra['cvContent'] as String? ?? '';
    final cvId = extra['cvId'] as String? ?? '';
    final type = extra['type'] as String? ?? 'cv';
    final isCoverLetter = type == 'cover_letter';

    return Scaffold(
      backgroundColor: HireIQTheme.backgroundLight,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              isCoverLetter ? 'Cover Letter Preview' : 'CV Preview',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                tooltip: 'Download PDF',
                onPressed: cvContent.isEmpty
                    ? null
                    : () => _downloadPdf(context, cvContent, isCoverLetter),
                icon: const Icon(
                  Icons.download_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              IconButton(
                tooltip: 'Share',
                onPressed: cvContent.isEmpty
                    ? null
                    : () => Share.share(cvContent,
                        subject: isCoverLetter
                            ? 'My Cover Letter'
                            : 'My CV — HireIQ'),
                icon: const Icon(
                  Icons.share_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // CV document card
                  Container(
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusMd),
                      boxShadow: [
                        BoxShadow(
                          color: HireIQTheme.primaryNavy
                              .withValues(alpha: 0.12),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(28),
                    child: cvContent.isEmpty
                        ? _EmptyCvFallback(isCoverLetter: isCoverLetter)
                        : _ParsedCvContent(
                            content: cvContent,
                            isCoverLetter: isCoverLetter,
                          ),
                  ),

                  const SizedBox(height: 20),

                  // Regenerate button
                  if (cvId.isNotEmpty)
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: HireIQTheme.primaryNavy,
                          borderRadius: BorderRadius.circular(
                              HireIQTheme.radiusLg),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.refresh_rounded,
                                color: Colors.white, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Regenerate',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadPdf(
      BuildContext context, String content, bool isCoverLetter) async {
    final doc = pw.Document();

    // Split content into lines and build PDF
    final lines = content.split('\n');

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context ctx) {
          final widgets = <pw.Widget>[];
          for (final line in lines) {
            final trimmed = line.trim();
            if (trimmed.isEmpty) {
              widgets.add(pw.SizedBox(height: 8));
              continue;
            }
            // ALL CAPS line = section header
            final isHeader =
                trimmed == trimmed.toUpperCase() && trimmed.length > 2;
            if (isHeader) {
              widgets.add(pw.SizedBox(height: 6));
              widgets.add(
                pw.Text(
                  trimmed,
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('0D9488'),
                    letterSpacing: 1.5,
                  ),
                ),
              );
              widgets.add(pw.Divider(
                  color: PdfColor.fromHex('E2E8F0'), thickness: 0.5));
              widgets.add(pw.SizedBox(height: 4));
            } else {
              widgets.add(
                pw.Text(
                  trimmed,
                  style: const pw.TextStyle(fontSize: 12),
                ),
              );
            }
          }
          return widgets;
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (_) async => doc.save(),
      name: isCoverLetter ? 'cover_letter.pdf' : 'cv.pdf',
    );
  }
}

// ── Parsed CV content ──────────────────────────────────────────────────────────

class _ParsedCvContent extends StatelessWidget {
  const _ParsedCvContent(
      {required this.content, required this.isCoverLetter});

  final String content;
  final bool isCoverLetter;

  @override
  Widget build(BuildContext context) {
    final lines = content.split('\n');
    final widgets = <Widget>[];

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final trimmed = line.trim();

      if (trimmed.isEmpty) {
        widgets.add(const SizedBox(height: 8));
        continue;
      }

      // Detect ALL CAPS section header (length > 2 to avoid "CV" etc.)
      final isHeader =
          trimmed == trimmed.toUpperCase() && trimmed.length > 2 && !isCoverLetter;

      if (isHeader) {
        if (i > 0) widgets.add(const SizedBox(height: 16));
        widgets.add(_CvSectionTitle(title: trimmed));
        widgets.add(const SizedBox(height: 4));
        widgets.add(const Divider(color: HireIQTheme.borderLight));
        widgets.add(const SizedBox(height: 10));
      } else {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              trimmed,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: HireIQTheme.textSecondary,
                height: 1.55,
              ),
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}

// ── Empty fallback ─────────────────────────────────────────────────────────────

class _EmptyCvFallback extends StatelessWidget {
  const _EmptyCvFallback({required this.isCoverLetter});
  final bool isCoverLetter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header placeholder
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'THABO NKOSI',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.primaryNavy,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Senior Flutter Developer',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: HireIQTheme.primaryTeal,
                  ),
                ),
              ],
            ),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: HireIQTheme.backgroundLight,
                borderRadius:
                    BorderRadius.circular(HireIQTheme.radiusSm),
              ),
              child: const Icon(
                Icons.contact_mail_outlined,
                size: 22,
                color: HireIQTheme.textMuted,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
        const Divider(color: HireIQTheme.borderLight),
        const SizedBox(height: 20),

        const _CvSectionTitle(title: 'EXPERIENCE'),
        const SizedBox(height: 12),
        const _CvExperienceItem(
          company: 'FinServ SA',
          role: 'Senior Flutter Developer',
          period: '2021 – Present',
          description:
              'Led cross-platform mobile development for flagship banking apps with 1M+ active users.',
        ),
        const _CvExperienceItem(
          company: 'TechFlow',
          role: 'Mobile Developer',
          period: '2019 – 2021',
          description:
              'Developed and maintained the core mobile application using Flutter and Dart.',
        ),

        const SizedBox(height: 8),
        const Divider(color: HireIQTheme.borderLight),
        const SizedBox(height: 20),

        const _CvSectionTitle(title: 'EXPERTISE'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            'Flutter',
            'Dart',
            'Riverpod',
            'Firebase',
            'Clean Architecture',
          ]
              .map(
                (label) => Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: HireIQTheme.backgroundLight,
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusSm),
                    border:
                        Border.all(color: HireIQTheme.borderLight),
                  ),
                  child: Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: HireIQTheme.textSecondary,
                    ),
                  ),
                ),
              )
              .toList(),
        ),

        const SizedBox(height: 24),
        const Divider(color: HireIQTheme.borderLight),
        const SizedBox(height: 20),

        const _CvSectionTitle(title: 'EDUCATION'),
        const SizedBox(height: 12),
        Text(
          'BSc Computer Science',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: HireIQTheme.primaryNavy,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          'University of Cape Town',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: HireIQTheme.textMuted,
          ),
        ),
      ],
    );
  }
}

// ── CV section title ───────────────────────────────────────────────────────────

class _CvSectionTitle extends StatelessWidget {
  const _CvSectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: HireIQTheme.primaryTeal,
        letterSpacing: 1.5,
      ),
    );
  }
}

// ── CV experience item ─────────────────────────────────────────────────────────

class _CvExperienceItem extends StatelessWidget {
  const _CvExperienceItem({
    required this.company,
    required this.role,
    required this.period,
    required this.description,
  });

  final String company;
  final String role;
  final String period;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                company,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: HireIQTheme.primaryNavy,
                ),
              ),
              Text(
                period,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: HireIQTheme.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            role,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: HireIQTheme.primaryTeal,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: HireIQTheme.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
