import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import 'package:go_router/go_router.dart';

class EmployerCandidateSearch extends StatelessWidget {
  const EmployerCandidateSearch({super.key});

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
              'Advanced Search',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
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
                    'Filter Candidates',
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                      'Skills (comma separated)',
                      'e.g. Flutter, Dart, Firebase'),
                  const SizedBox(height: 20),
                  _buildTextField(
                      'Location', 'e.g. Remote, Johannesburg'),
                  const SizedBox(height: 24),
                  Text(
                    'Minimum MatchIQ Score',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: HireIQTheme.primaryNavy),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusMd),
                      border:
                          Border.all(color: HireIQTheme.borderLight),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Slider(
                            value: 80,
                            min: 0,
                            max: 100,
                            divisions: 10,
                            activeColor: HireIQTheme.primaryTeal,
                            inactiveColor: HireIQTheme.borderLight,
                            onChanged: (val) {},
                          ),
                        ),
                        Text(
                          '80%',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: HireIQTheme.primaryNavy),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusMd),
                      border:
                          Border.all(color: HireIQTheme.borderLight),
                    ),
                    child: SwitchListTile(
                      title: Text(
                        'PassportIQ Verified Only',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: HireIQTheme.primaryNavy),
                      ),
                      subtitle: Text(
                        'Only show candidates with verified identity and qualifications.',
                        style: GoogleFonts.inter(
                            color: HireIQTheme.textMuted, fontSize: 13),
                      ),
                      value: true,
                      onChanged: (val) {},
                      activeThumbColor: HireIQTheme.primaryTeal,
                    ),
                  ),
                  const SizedBox(height: 48),
                  GestureDetector(
                    onTap: () => context.pop(),
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
                        'Apply Filters',
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

  Widget _buildTextField(String label, String hint) {
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
          style: GoogleFonts.inter(color: HireIQTheme.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: HireIQTheme.textMuted),
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
