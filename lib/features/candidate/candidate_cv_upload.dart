import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class CandidateCVUpload extends StatefulWidget {
  const CandidateCVUpload({super.key});

  @override
  State<CandidateCVUpload> createState() => _CandidateCVUploadState();
}

class _CandidateCVUploadState extends State<CandidateCVUpload> {
  bool _isUploading = false;

  void _handleUpload() {
    setState(() => _isUploading = true);
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _isUploading = false);
        _showSuccessDialog();
      }
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
        ),
        title: Text(
          'CV Processed',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            color: HireIQTheme.primaryNavy,
          ),
        ),
        content: Text(
          'MatchIQ has extracted your skills. Head to your profile to see your new SkillIQ badges!',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: HireIQTheme.textSecondary,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Awesome',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                color: HireIQTheme.primaryTeal,
              ),
            ),
          ),
        ],
      ),
    );
  }

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
              'Upload CV',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),

          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isUploading) ...[
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: HireIQTheme.primaryTeal
                            .withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(
                          color: HireIQTheme.primaryTeal,
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'MatchIQ is analyzing your CV...',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Extracting skills and experience...',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: HireIQTheme.textMuted,
                      ),
                    ),
                  ] else ...[
                    // Upload drop zone
                    GestureDetector(
                      onTap: _handleUpload,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 48, horizontal: 32),
                        decoration: BoxDecoration(
                          color: HireIQTheme.primaryTeal
                              .withValues(alpha: 0.04),
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusXl),
                          border: Border.all(
                            color: HireIQTheme.primaryTeal
                                .withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: HireIQTheme.primaryTeal
                                    .withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.upload_file_outlined,
                                size: 32,
                                color: HireIQTheme.primaryTeal,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Tap to upload your CV',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: HireIQTheme.primaryNavy,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'PDF, DOCX · Max 5 MB',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: HireIQTheme.textMuted,
                              ),
                            ),
                            const SizedBox(height: 24),
                            GestureDetector(
                              onTap: _handleUpload,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 13),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      HireIQTheme.primaryNavy,
                                      Color(0xFF243659),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      HireIQTheme.radiusMd),
                                  boxShadow: [
                                    BoxShadow(
                                      color: HireIQTheme.primaryNavy
                                          .withValues(alpha: 0.3),
                                      blurRadius: 14,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Select File',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 15,
                          color: HireIQTheme.textMuted,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Your personal data is encrypted and protected by ShieldIQ.',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: HireIQTheme.textMuted,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
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
