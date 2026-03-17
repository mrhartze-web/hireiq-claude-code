import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';

class ReleasePaymentScreen extends StatelessWidget {
  const ReleasePaymentScreen({super.key});

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
              'Release Payment',
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
                  _buildCandidateHeader(),
                  const SizedBox(height: 24),
                  _buildMilestoneInfo(),
                  const SizedBox(height: 24),
                  _buildDeliverableCard(),
                  const SizedBox(height: 28),
                  _buildPaymentSummary(),
                  const SizedBox(height: 28),
                  _buildReviewChecklist(),
                  const SizedBox(height: 32),
                  _buildActionButtons(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCandidateHeader() {
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
          const CircleAvatar(
            radius: 24,
            backgroundImage:
                NetworkImage('https://i.pravatar.cc/150?u=thabo'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thabo Nkosi',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600, fontSize: 15),
                ),
                Text(
                  'Expert Developer',
                  style: GoogleFonts.inter(
                      color: HireIQTheme.textMuted, fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
              borderRadius:
                  BorderRadius.circular(HireIQTheme.radiusSm),
            ),
            child: Text(
              'Verified',
              style: GoogleFonts.inter(
                  color: HireIQTheme.primaryTeal,
                  fontSize: 11,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutter App UI Fix • Milestone 2',
          style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.primaryNavy),
        ),
        const SizedBox(height: 4),
        Text(
          'Final UI adjustments and responsiveness fixes.',
          style: GoogleFonts.inter(color: HireIQTheme.textMuted),
        ),
      ],
    );
  }

  Widget _buildDeliverableCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Submitted deliverable:',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: HireIQTheme.surfaceWhite,
            borderRadius:
                BorderRadius.circular(HireIQTheme.radiusMd),
            border: Border.all(color: HireIQTheme.borderLight),
          ),
          child: Row(
            children: [
              const Icon(Icons.folder_zip_outlined,
                  color: Color(0xFFD97706), size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'flutter_ui_fix_final.zip',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '4.2 MB • Zip Archive',
                      style: GoogleFonts.inter(
                          color: HireIQTheme.textMuted,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.download,
                    color: HireIQTheme.primaryTeal),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [HireIQTheme.primaryNavy, Color(0xFF243659)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Currently held in escrow',
                style: GoogleFonts.inter(color: Colors.white70),
              ),
              const Icon(Icons.lock_outline,
                  color: Colors.white70, size: 16),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Release amount',
                style: GoogleFonts.inter(
                    color: Colors.white, fontSize: 15),
              ),
              Text(
                'R5,000.00',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Divider(
              color: Colors.white.withValues(alpha: 0.15), height: 28),
          Row(
            children: [
              const Icon(Icons.security,
                  color: HireIQTheme.primaryTeal, size: 14),
              const SizedBox(width: 8),
              Text(
                'Payments are protected by ShieldIQ',
                style: GoogleFonts.inter(
                    color: Colors.white70, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewChecklist() {
    return Column(
      children: [
        _buildCheckItem('I have reviewed and tested the code provided.'),
        _buildCheckItem(
            'The deliverables meet the project requirements.'),
        _buildCheckItem(
            'I am ready to finalize this milestone payment.'),
      ],
    );
  }

  Widget _buildCheckItem(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Checkbox(
            value: true,
            onChanged: (v) {},
            activeColor: HireIQTheme.primaryTeal,
          ),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: HireIQTheme.surfaceWhite,
                borderRadius:
                    BorderRadius.circular(HireIQTheme.radiusMd),
                border: Border.all(color: HireIQTheme.borderLight),
              ),
              alignment: Alignment.center,
              child: Text(
                'Back',
                style: GoogleFonts.inter(
                    color: HireIQTheme.primaryNavy,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Payment released successfully!')),
              );
              context.pop();
            },
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    HireIQTheme.primaryTeal,
                    Color(0xFF0A7A70),
                  ],
                ),
                borderRadius:
                    BorderRadius.circular(HireIQTheme.radiusMd),
              ),
              alignment: Alignment.center,
              child: Text(
                'Confirm Release',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
