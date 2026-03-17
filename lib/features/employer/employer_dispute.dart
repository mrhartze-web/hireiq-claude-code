import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';

class OpenDisputeScreen extends StatelessWidget {
  const OpenDisputeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Open Dispute',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Raise a dispute',
                    style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Mediation will be initiated if a resolution isn't reached within 48 hours.",
                    style: GoogleFonts.inter(
                        color: HireIQTheme.textMuted),
                  ),
                  const SizedBox(height: 28),
                  _buildMilestoneContext(),
                  const SizedBox(height: 28),
                  _buildDisputeReasonField(),
                  const SizedBox(height: 24),
                  _buildAttachmentSection(),
                  const SizedBox(height: 28),
                  _buildHowItWorks(),
                  const SizedBox(height: 32),
                  _buildSubmitButton(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneContext() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded,
              color: Color(0xFFD97706), size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flutter App UI Fix • Milestone 2',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.primaryNavy),
                ),
                Text(
                  'Thabo Nkosi to Apex Digital',
                  style: GoogleFonts.inter(
                      color: HireIQTheme.textMuted, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisputeReasonField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dispute Reason',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: HireIQTheme.primaryNavy),
        ),
        const SizedBox(height: 12),
        TextField(
          maxLines: 5,
          style: GoogleFonts.inter(color: HireIQTheme.textPrimary),
          decoration: InputDecoration(
            hintText: 'Describe the issue in detail...',
            hintStyle:
                GoogleFonts.inter(color: HireIQTheme.textMuted),
            filled: true,
            fillColor: HireIQTheme.surfaceWhite,
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
              borderSide:
                  const BorderSide(color: HireIQTheme.primaryTeal),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttachmentSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: HireIQTheme.backgroundLight,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.cloud_upload_outlined,
                color: HireIQTheme.primaryTeal, size: 32),
            const SizedBox(height: 12),
            Text(
              'Attach screenshots or documents',
              style: GoogleFonts.inter(fontWeight: FontWeight.w500),
            ),
            Text(
              'PDF, JPG, PNG (Max 10MB)',
              style: GoogleFonts.inter(
                  color: HireIQTheme.textMuted, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHowItWorks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How it works',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: HireIQTheme.primaryNavy,
              fontSize: 15),
        ),
        const SizedBox(height: 16),
        _buildStepItem(1,
            'Submit this form to notify the other party and our dispute team.'),
        _buildStepItem(2,
            'You have 48 hours to reach an amicable solution together.'),
        _buildStepItem(3,
            'If no agreement is reached, an independent mediator will be assigned.'),
      ],
    );
  }

  Widget _buildStepItem(int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              color: HireIQTheme.primaryNavy,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$number',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                  fontSize: 13,
                  color: HireIQTheme.textSecondary,
                  height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Dispute raised. The escrow funds (R5,000.00) have been frozen.')),
            );
            context.pop();
          },
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  HireIQTheme.primaryNavy,
                  Color(0xFF243659),
                ],
              ),
              borderRadius:
                  BorderRadius.circular(HireIQTheme.radiusMd),
            ),
            alignment: Alignment.center,
            child: Text(
              'Submit Dispute',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'By submitting, the R5,000.00 in escrow will be frozen until a resolution is reached.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              color: HireIQTheme.textMuted, fontSize: 11),
        ),
      ],
    );
  }
}
