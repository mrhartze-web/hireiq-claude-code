import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerPostGig extends StatelessWidget {
  const EmployerPostGig({super.key});

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
              'Post a Gig',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            actions: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Text(
                    'Draft',
                    style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gig Details',
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                      'Project Title', 'e.g. Flutter UI Overhaul'),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Description',
                    'Describe the project scope and deliverables...',
                    maxLines: 5,
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Requirements',
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField('Required Skills',
                      'e.g. Flutter, Firebase, Riverpod'),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                      'Duration', 'Select duration'),
                  const SizedBox(height: 28),
                  Text(
                    'Budget & Payment',
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                          child: _buildTextField(
                              'Fixed Price (R)', 'e.g. 15000')),
                      const SizedBox(width: 16),
                      Expanded(
                          child: _buildDropdownField(
                              'Payment Method',
                              'Select method')),
                    ],
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: 56,
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
                        'Publish Gig',
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

  Widget _buildTextField(String label, String hint,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: HireIQTheme.primaryNavy),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          style: GoogleFonts.inter(color: HireIQTheme.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
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

  Widget _buildDropdownField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: HireIQTheme.primaryNavy),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: HireIQTheme.surfaceWhite,
            borderRadius:
                BorderRadius.circular(HireIQTheme.radiusMd),
            border: Border.all(color: HireIQTheme.borderLight),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(
                hint,
                style: GoogleFonts.inter(
                    color: HireIQTheme.textMuted),
              ),
              items: const [],
              onChanged: (val) {},
            ),
          ),
        ),
      ],
    );
  }
}
