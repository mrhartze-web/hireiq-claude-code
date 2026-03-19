import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class ForgeIQCoverLetterScreen extends ConsumerWidget {
  const ForgeIQCoverLetterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Cover Letter Ready',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header row
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.description_rounded,
                    size: 32,
                    color: HireIQTheme.primaryTeal,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Your cover letter is ready',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Cover letter card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(
                  color: HireIQTheme.primaryNavy.withValues(alpha: 0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dear Hiring Manager,',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'I am excited to apply for this position at your organisation. '
                    'Having followed your company\'s growth and innovation closely, '
                    'I am confident that my background aligns strongly with your team\'s '
                    'vision and the requirements of this role. I believe this opportunity '
                    'represents an ideal next step in my career, and I am eager to '
                    'contribute meaningfully from day one.\n\n'
                    'My experience has equipped me with a robust set of skills that '
                    'directly match what you are looking for. I have consistently delivered '
                    'results in fast-paced environments, collaborating across teams to '
                    'solve complex problems and drive tangible outcomes. I am particularly '
                    'drawn to the challenge this role presents and am confident in my '
                    'ability to exceed the expectations outlined in the job description.\n\n'
                    'I would welcome the opportunity to discuss how my background, skills, '
                    'and enthusiasm can best serve your team. Thank you for considering my '
                    'application — I look forward to the possibility of contributing to '
                    'your organisation\'s continued success.',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: HireIQTheme.primaryNavy,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sincerely,\nThabo Nkosi',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Copy & Download buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Copied to clipboard')),
                      );
                    },
                    icon: const Icon(Icons.copy_outlined),
                    label: const Text('Copy'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download_outlined),
                    label: const Text('Download'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Use in Application CTA
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.amber,
                  foregroundColor: HireIQTheme.primaryNavy,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                ),
                child: Text(
                  'Use in Application',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Regenerate
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Regenerate',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: HireIQTheme.primaryTeal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
