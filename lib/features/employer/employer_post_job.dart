import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class EmployerPostJob extends ConsumerStatefulWidget {
  const EmployerPostJob({super.key});

  @override
  ConsumerState<EmployerPostJob> createState() => _EmployerPostJobState();
}

class _EmployerPostJobState extends ConsumerState<EmployerPostJob> {
  int _currentStep = 0;

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
              'Post a New Job',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStepIndicator(),
                  const SizedBox(height: 28),
                  _buildCurrentStep(),
                  const SizedBox(height: 32),
                  _buildNavigationButtons(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    final steps = ['Title', 'Details', 'Review'];
    return Row(
      children: List.generate(steps.length, (i) {
        final isActive = i == _currentStep;
        final isDone = i < _currentStep;
        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isDone
                            ? HireIQTheme.primaryTeal
                            : isActive
                                ? HireIQTheme.primaryNavy
                                : HireIQTheme.borderLight,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: isDone
                          ? const Icon(Icons.check,
                              color: Colors.white, size: 16)
                          : Text(
                              '${i + 1}',
                              style: GoogleFonts.inter(
                                color: isActive
                                    ? Colors.white
                                    : HireIQTheme.textMuted,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      steps[i],
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: isActive
                            ? HireIQTheme.primaryNavy
                            : HireIQTheme.textMuted,
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              if (i < steps.length - 1)
                Expanded(
                  child: Container(
                    height: 2,
                    margin: const EdgeInsets.only(bottom: 20),
                    color: isDone
                        ? HireIQTheme.primaryTeal
                        : HireIQTheme.borderLight,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildBasicInfoStep();
      case 1:
        return _buildDetailsStep();
      case 2:
        return _buildReviewStep();
      default:
        return _buildBasicInfoStep();
    }
  }

  Widget _buildBasicInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Information',
          style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.textPrimary),
        ),
        const SizedBox(height: 20),
        _buildInputField('Job Title', 'e.g. Senior Flutter Developer'),
        const SizedBox(height: 16),
        _buildInputField('Location', 'e.g. Cape Town (Remote)'),
        const SizedBox(height: 16),
        _buildDropdownField('Employment Type',
            ['Full-time', 'Contract', 'Part-time', 'Freelance']),
      ],
    );
  }

  Widget _buildDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Job Details',
          style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: HireIQTheme.textPrimary),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Job Description',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: HireIQTheme.textPrimary),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      HireIQTheme.primaryTeal,
                      Color(0xFF0A7A70),
                    ],
                  ),
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusFull),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.auto_awesome,
                        size: 14, color: Colors.white),
                    const SizedBox(width: 6),
                    Text(
                      'AI Generate',
                      style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _buildInputField(
          '',
          'Describe the role, responsibilities, and requirements...',
          maxLines: 6,
          showLabel: false,
        ),
        const SizedBox(height: 16),
        _buildInputField('Salary Range (Optional)', 'e.g. R60k - R80k'),
      ],
    );
  }

  Widget _buildReviewStep() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: HireIQTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(HireIQTheme.radiusXl),
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
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_outline,
                    size: 48, color: HireIQTheme.primaryTeal),
              ),
              const SizedBox(height: 20),
              Text(
                'Ready to Publish?',
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: HireIQTheme.textPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                'Review your posting details before making it live to candidates.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: HireIQTheme.textMuted, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [HireIQTheme.primaryTeal, Color(0xFF0A7A70)],
              ),
              borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
            ),
            alignment: Alignment.center,
            child: Text(
              'Publish Listing',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    if (_currentStep == 2) return const SizedBox.shrink();
    return Row(
      children: [
        if (_currentStep > 0) ...[
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _currentStep--),
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
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.textPrimary),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              if (_currentStep < 2) setState(() => _currentStep++);
            },
            child: Container(
              height: 52,
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
                'Continue',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(String label, String hint,
      {int maxLines = 1, bool showLabel = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel && label.isNotEmpty) ...[
          Text(
            label,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: HireIQTheme.textPrimary),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          maxLines: maxLines,
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

  Widget _buildDropdownField(String label, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: HireIQTheme.textPrimary),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
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
          hint: Text(
            'Select type',
            style: GoogleFonts.inter(color: HireIQTheme.textMuted),
          ),
          items: options
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e,
                        style: GoogleFonts.inter(
                            color: HireIQTheme.textPrimary)),
                  ))
              .toList(),
          onChanged: (val) {},
        ),
      ],
    );
  }
}
