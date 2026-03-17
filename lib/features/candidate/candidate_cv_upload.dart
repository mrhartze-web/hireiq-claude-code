import 'package:flutter/material.dart';
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
        title: const Text('CV Processed'),
        content: const Text(
            'MatchIQ has extracted your skills. Head to your profile to see your new SkillIQ badges!'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Awesome')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload CV')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isUploading) ...[
              const CircularProgressIndicator(color: HireIQTheme.primaryTeal),
              const SizedBox(height: 24),
              const Text('MatchIQ is analyzing your CV...',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('Extracting skills and experience...',
                  style: TextStyle(color: HireIQTheme.textMuted)),
            ] else ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: HireIQTheme.surfaceWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: HireIQTheme.primaryTeal, style: BorderStyle.solid),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.upload_file_outlined,
                        size: 64, color: HireIQTheme.primaryTeal),
                    const SizedBox(height: 24),
                    const Text('Tap to upload your CV',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text('PDF, DOCX (Max 5MB)',
                        style: TextStyle(color: HireIQTheme.textMuted)),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _handleUpload,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: HireIQTheme.primaryNavy,
                          foregroundColor: Colors.white),
                      child: const Text('Select File'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Row(
                children: [
                  Icon(Icons.info_outline,
                      size: 16, color: HireIQTheme.textMuted),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Your personal data is encrypted and protected by ShieldIQ.',
                      style:
                          TextStyle(color: HireIQTheme.textMuted, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
