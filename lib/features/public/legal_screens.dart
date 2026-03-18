import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LegalScreen(
      title: 'Terms of Service',
      sections: [
        _LegalSection(
          heading: '1. Acceptance of Terms',
          body:
              'By accessing and using HireIQ, you agree to be bound by these Terms of Service and all applicable laws and regulations. If you do not agree with any of these terms, you are prohibited from using or accessing this platform.',
        ),
        _LegalSection(
          heading: '2. User Responsibilities',
          body:
              'You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You agree to notify HireIQ immediately of any unauthorised use of your account.',
        ),
        _LegalSection(
          heading: '3. Service Description',
          body:
              'HireIQ provides a platform for recruitment and job searching using AI-powered matching technologies including MatchIQ, WildcardIQ, SignalIQ, PassportIQ, ForgeIQ, and UpliftIQ. These services are subject to change at any time.',
        ),
        _LegalSection(
          heading: '4. Disclaimer',
          body:
              'The services are provided "as is" without warranty of any kind, express or implied. HireIQ does not warrant that the service will be uninterrupted, error-free, or that defects will be corrected.',
        ),
        _LegalSection(
          heading: '5. Governing Law',
          body:
              'These terms are governed by the laws of the Republic of South Africa. Any disputes arising under these terms shall be subject to the exclusive jurisdiction of the South African courts.',
        ),
      ],
    );
  }
}

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LegalScreen(
      title: 'Privacy Policy',
      sections: [
        _LegalSection(
          heading: '1. Information We Collect',
          body:
              'We collect information you provide directly to us, such as your name, email address, CV data, employment history, and identity verification documents. We also collect usage data and device information automatically.',
        ),
        _LegalSection(
          heading: '2. How We Use Information',
          body:
              'We use your information to facilitate matches between candidates and employers, provide personalised job recommendations via MatchIQ, verify your identity through PassportIQ, and improve our AI systems.',
        ),
        _LegalSection(
          heading: '3. Data Protection',
          body:
              'We implement industry-standard security measures including encryption at rest and in transit to protect your personal data. We comply with the Protection of Personal Information Act (POPIA) of South Africa.',
        ),
        _LegalSection(
          heading: '4. Third-Party Sharing',
          body:
              'We do not sell your personal information to third parties. We may share data with verified employers and recruiters as part of the placement process, only with your explicit consent.',
        ),
        _LegalSection(
          heading: '5. Your Rights',
          body:
              'You have the right to access, correct, or delete your personal data at any time. You may submit a request through your account settings or by contacting our support team at privacy@hireiq.co.za.',
        ),
      ],
    );
  }
}

// ── Shared legal screen layout ────────────────────────────────────────────────

class _LegalSection {
  const _LegalSection({required this.heading, required this.body});
  final String heading;
  final String body;
}

class _LegalScreen extends StatelessWidget {
  const _LegalScreen({required this.title, required this.sections});
  final String title;
  final List<_LegalSection> sections;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          title,
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                border: Border.all(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      color: HireIQTheme.primaryTeal, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Last updated: January 2026',
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          color: HireIQTheme.primaryTeal,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ...sections.map((s) => _buildSection(s)),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(_LegalSection section) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
        border: Border.all(color: HireIQTheme.borderLight),
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
          Text(
            section.heading,
            style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy),
          ),
          const SizedBox(height: 10),
          Text(
            section.body,
            style: GoogleFonts.inter(
                fontSize: 14,
                color: HireIQTheme.textMuted,
                height: 1.6),
          ),
        ],
      ),
    );
  }
}
