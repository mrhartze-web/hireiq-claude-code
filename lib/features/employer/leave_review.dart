import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class LeaveReviewScreen extends StatefulWidget {
  const LeaveReviewScreen({super.key});

  @override
  State<LeaveReviewScreen> createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState extends State<LeaveReviewScreen> {
  int _rating = 0;
  bool _wouldHireAgain = true;

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
              'Leave a Review',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildCandidateProfile(),
                  const SizedBox(height: 36),
                  Text(
                    'How was your experience?',
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: HireIQTheme.textMuted),
                  ),
                  const SizedBox(height: 20),
                  _buildStarRating(),
                  const SizedBox(height: 8),
                  Text(
                    _getRatingText(),
                    style: GoogleFonts.inter(
                        color: HireIQTheme.primaryNavy,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 36),
                  _buildHireAgainSection(),
                  const SizedBox(height: 36),
                  _buildReviewField(),
                  const SizedBox(height: 36),
                  GestureDetector(
                    onTap: () {},
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
                        borderRadius: BorderRadius.circular(
                            HireIQTheme.radiusMd),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Submit Review',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCandidateProfile() {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor:
              HireIQTheme.primaryNavy.withValues(alpha: 0.1),
          child: Text(
            'TN',
            style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Thabo Nkosi',
          style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: HireIQTheme.textPrimary),
        ),
        Text(
          'Flutter Developer',
          style: GoogleFonts.inter(
              color: HireIQTheme.textSecondary, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
          },
          icon: Icon(
            index < _rating
                ? Icons.star_rounded
                : Icons.star_outline_rounded,
            color: index < _rating
                ? const Color(0xFFF59E0B)
                : HireIQTheme.borderMedium,
            size: 48,
          ),
        );
      }),
    );
  }

  String _getRatingText() {
    switch (_rating) {
      case 1:
        return 'Needs improvement';
      case 2:
        return 'Below expectations';
      case 3:
        return 'Met expectations';
      case 4:
        return 'Above average';
      case 5:
        return 'Outstanding';
      default:
        return 'Select rating';
    }
  }

  Widget _buildHireAgainSection() {
    return Column(
      children: [
        Text(
          'Would you hire Thabo again?',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: HireIQTheme.textPrimary),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildChoiceChip(
                'Yes, absolutely', true, _wouldHireAgain),
            const SizedBox(width: 14),
            _buildChoiceChip(
                'Maybe, not sure', false, !_wouldHireAgain),
          ],
        ),
      ],
    );
  }

  Widget _buildChoiceChip(
      String label, bool value, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _wouldHireAgain = value),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? HireIQTheme.primaryNavy.withValues(alpha: 0.1)
              : HireIQTheme.surfaceWhite,
          borderRadius:
              BorderRadius.circular(HireIQTheme.radiusFull),
          border: Border.all(
            color: isSelected
                ? HireIQTheme.primaryNavy
                : HireIQTheme.borderLight,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected
                ? HireIQTheme.primaryNavy
                : HireIQTheme.textSecondary,
            fontWeight: isSelected
                ? FontWeight.w600
                : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detailed feedback (optional)',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: HireIQTheme.textPrimary),
        ),
        const SizedBox(height: 10),
        TextField(
          maxLines: 4,
          style: GoogleFonts.inter(color: HireIQTheme.textPrimary),
          decoration: InputDecoration(
            hintText: 'Share more details about working with Thabo...',
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
}
