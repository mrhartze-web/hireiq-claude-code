import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class BriefUploadScreen extends StatefulWidget {
  const BriefUploadScreen({super.key});

  @override
  State<BriefUploadScreen> createState() => _BriefUploadScreenState();
}

class _BriefUploadScreenState extends State<BriefUploadScreen> {
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const Text(
          'AI Brief Upload',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Icon(Icons.auto_awesome_rounded,
                color: HireIQColors.teal, size: 64),
            const SizedBox(height: 24),
            const Text(
              'Upload Hiring Brief',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: HireIQColors.navy),
            ),
            const SizedBox(height: 12),
            const Text(
              'Upload your job description or hiring brief, and our AI will source the top 1% from our CV Vault.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: HireIQColors.textMuted, fontSize: 15, height: 1.5),
            ),
            const SizedBox(height: 48),
            _buildUploadArea(),
            const SizedBox(height: 48),
            _buildBenefit('Instant Shortlist generation'),
            _buildBenefit('98% skill-matching accuracy'),
            _buildBenefit('Automated interview scheduling'),
            const SizedBox(height: 48),
            _isUploading
                ? const CircularProgressIndicator(color: HireIQColors.teal)
                : _buildActionButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadArea() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48),
      decoration: BoxDecoration(
        color: HireIQColors.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
            color: HireIQColors.teal, width: 2, style: BorderStyle.solid),
      ),
      child: const Column(
        children: [
          Icon(Icons.cloud_upload_rounded, color: HireIQColors.teal, size: 48),
          SizedBox(height: 16),
          Text('Drag & drop or Click to browse',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: HireIQColors.navy)),
          Text('PDF, DOCX up to 10MB',
              style: TextStyle(color: HireIQColors.textMuted, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildBenefit(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_rounded,
              color: HireIQColors.teal, size: 18),
          const SizedBox(width: 12),
          Text(text,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: HireIQColors.navy)),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        setState(() => _isUploading = true);
        await Future.delayed(const Duration(seconds: 2));
        if (!context.mounted) return;

        context.push('/crm-pipeline');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('AI Shortlist Generated!'),
              backgroundColor: HireIQColors.teal),
        );
      },
      child: const Text('Analyze Brief & Source'),
    );
  }
}
