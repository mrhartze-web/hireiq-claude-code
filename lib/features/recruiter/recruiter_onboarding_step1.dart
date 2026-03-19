import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class RecruiterOnboardingStep1 extends ConsumerStatefulWidget {
  const RecruiterOnboardingStep1({super.key});

  @override
  ConsumerState<RecruiterOnboardingStep1> createState() =>
      _RecruiterOnboardingStep1State();
}

class _RecruiterOnboardingStep1State
    extends ConsumerState<RecruiterOnboardingStep1> {
  bool _isAgency = false;
  final TextEditingController _agencyNameController =
      TextEditingController();
  final Set<String> _specialisations = {};
  final Set<String> _regions = {};
  String _experience = '1-3 years';

  static const List<String> _specOptions = [
    'Technology',
    'Finance',
    'Engineering',
    'Healthcare',
    'Legal',
    'Marketing',
    'Sales',
    'Executive',
    'Other',
  ];

  static const List<String> _regionOptions = [
    'Gauteng',
    'Western Cape',
    'KwaZulu-Natal',
    'Eastern Cape',
    'All South Africa',
    'Remote',
  ];

  static const List<String> _experienceOptions = [
    '<1 year',
    '1-3 years',
    '3-5 years',
    '5-10 years',
    '10+ years',
  ];

  @override
  void dispose() {
    _agencyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.surfaceWhite,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        title: Text(
          'Get Started',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress
            LinearProgressIndicator(
              value: 0.33,
              backgroundColor: HireIQTheme.borderLight,
              valueColor: const AlwaysStoppedAnimation<Color>(
                  HireIQTheme.primaryTeal),
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Step 1 of 3',
                style: GoogleFonts.inter(
                  color: HireIQTheme.textMuted,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Text(
              'Tell us about your practice',
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Help us set up your recruiter profile.',
              style: GoogleFonts.inter(
                color: HireIQTheme.textMuted,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 24),

            // Practice type
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isAgency = false),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: !_isAgency
                            ? HireIQTheme.primaryNavy
                            : HireIQTheme.surfaceWhite,
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd),
                        border: Border.all(
                          color: !_isAgency
                              ? HireIQTheme.primaryNavy
                              : HireIQTheme.borderLight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_outline,
                            color: !_isAgency
                                ? Colors.white
                                : HireIQTheme.textMuted,
                            size: 24,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Independent',
                            style: GoogleFonts.inter(
                              color: !_isAgency
                                  ? Colors.white
                                  : HireIQTheme.textMuted,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isAgency = true),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _isAgency
                            ? HireIQTheme.primaryNavy
                            : HireIQTheme.surfaceWhite,
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd),
                        border: Border.all(
                          color: _isAgency
                              ? HireIQTheme.primaryNavy
                              : HireIQTheme.borderLight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.business_outlined,
                            color: _isAgency
                                ? Colors.white
                                : HireIQTheme.textMuted,
                            size: 24,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Agency',
                            style: GoogleFonts.inter(
                              color: _isAgency
                                  ? Colors.white
                                  : HireIQTheme.textMuted,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            if (_isAgency) ...[
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _agencyNameController,
                      decoration: InputDecoration(
                        labelText: 'Agency name',
                        labelStyle: GoogleFonts.inter(
                            color: HireIQTheme.textMuted, fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusMd),
                          borderSide: const BorderSide(
                              color: HireIQTheme.borderLight),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusMd),
                          borderSide: const BorderSide(
                              color: HireIQTheme.borderLight),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusMd),
                          borderSide: const BorderSide(
                              color: HireIQTheme.primaryTeal),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 20),
            Text(
              'Specialisations',
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _specOptions.map((spec) {
                final isSelected = _specialisations.contains(spec);
                return GestureDetector(
                  onTap: () => setState(() {
                    if (isSelected) {
                      _specialisations.remove(spec);
                    } else {
                      _specialisations.add(spec);
                    }
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? HireIQTheme.primaryTeal.withValues(alpha: 0.1)
                          : HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusFull),
                      border: Border.all(
                        color: isSelected
                            ? HireIQTheme.primaryTeal
                            : HireIQTheme.borderLight,
                      ),
                    ),
                    child: Text(
                      spec,
                      style: GoogleFonts.inter(
                        color: isSelected
                            ? HireIQTheme.primaryTeal
                            : HireIQTheme.textMuted,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
            Text(
              'Regions',
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _regionOptions.map((region) {
                final isSelected = _regions.contains(region);
                return GestureDetector(
                  onTap: () => setState(() {
                    if (isSelected) {
                      _regions.remove(region);
                    } else {
                      _regions.add(region);
                    }
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? HireIQTheme.primaryTeal.withValues(alpha: 0.1)
                          : HireIQTheme.surfaceWhite,
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusFull),
                      border: Border.all(
                        color: isSelected
                            ? HireIQTheme.primaryTeal
                            : HireIQTheme.borderLight,
                      ),
                    ),
                    child: Text(
                      region,
                      style: GoogleFonts.inter(
                        color: isSelected
                            ? HireIQTheme.primaryTeal
                            : HireIQTheme.textMuted,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
            Text(
              'Years of experience',
              style: GoogleFonts.inter(
                color: HireIQTheme.primaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _experience,
              decoration: InputDecoration(
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
              items: _experienceOptions
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(
                        e,
                        style: GoogleFonts.inter(
                          color: HireIQTheme.textPrimary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _experience = v);
              },
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HireIQTheme.amber,
                  foregroundColor: HireIQTheme.primaryNavy,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusMd),
                  ),
                ),
                onPressed: () =>
                    context.go('/recruiter/onboarding/step-2'),
                child: Text(
                  'Continue',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
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
