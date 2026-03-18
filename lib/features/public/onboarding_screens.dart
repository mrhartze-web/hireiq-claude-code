import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';
import '../mobile_screens.dart';

// ── Screen ────────────────────────────────────────────────────────────────────

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 0;
  static const int _totalSteps = 5;

  // ── Step 1 ──────────────────────────────────────────────────────────────────
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  bool _hasPhoto = false;

  // ── Step 2 ──────────────────────────────────────────────────────────────────
  final _categorySearchCtrl = TextEditingController();
  String? _selectedCategory;
  String? _expLevel; // Entry, Mid, Senior, Exec

  // ── Step 3 ──────────────────────────────────────────────────────────────────
  final _cityCtrl = TextEditingController();
  final List<String> _selectedCities = [];
  bool _openToRemote = false;
  RangeValues _salaryRange = const RangeValues(8000, 35000);
  final _availCtrl = TextEditingController();

  // ── Step 4 ──────────────────────────────────────────────────────────────────
  final List<String> _skills = [];
  final _skillCtrl = TextEditingController();
  String? _expYears;
  String? _qualification;
  final _employerCtrl = TextEditingController();

  // ── Step 5 ──────────────────────────────────────────────────────────────────
  String? _referral;
  bool _jobAlerts = true;
  bool _whatsappAlerts = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _phoneCtrl.dispose();
    _categorySearchCtrl.dispose();
    _cityCtrl.dispose();
    _availCtrl.dispose();
    _skillCtrl.dispose();
    _employerCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_step < _totalSteps - 1) {
      setState(() => _step++);
    } else {
      context.go(MobileRoutes.signup);
    }
  }

  void _back() {
    if (_step > 0) {
      setState(() => _step--);
    } else {
      context.pop();
    }
  }

  void _skip() => context.go(MobileRoutes.signup);

  static String _formatSalary(double value) {
    final n = value.round();
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return 'R${buf.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            _buildTopBar(),

            // Progress bar
            _buildProgressBar(),

            // Step content
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding:
                    const EdgeInsets.fromLTRB(24, 24, 24, 32),
                child: _buildStepContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          IconButton(
            onPressed: _back,
            icon: const Icon(Icons.arrow_back_rounded,
                color: HireIQTheme.primaryNavy, size: 22),
          ),
          const Spacer(),
          TextButton(
            onPressed: _skip,
            child: Text(
              'Skip',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: HireIQTheme.textMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: Row(
        children: List.generate(_totalSteps, (i) {
          return Expanded(
            child: Container(
              margin: i < _totalSteps - 1
                  ? const EdgeInsets.only(right: 5)
                  : EdgeInsets.zero,
              height: 4,
              decoration: BoxDecoration(
                color: i <= _step
                    ? HireIQTheme.primaryTeal
                    : HireIQTheme.borderLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_step) {
      case 0:
        return _buildStep1();
      case 1:
        return _buildStep2();
      case 2:
        return _buildStep3();
      case 3:
        return _buildStep4();
      case 4:
        return _buildStep5();
      default:
        return const SizedBox.shrink();
    }
  }

  // ── Step 1 — What's your name? ───────────────────────────────────────────────

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepHeading(title: "What's your name?"),
        const SizedBox(height: 24),

        _FieldLabel('First name'),
        const SizedBox(height: 8),
        _OnboardField(
          controller: _firstNameCtrl,
          hint: 'e.g. Thabo',
          prefixIcon: Icons.person_outline_rounded,
        ),

        const SizedBox(height: 16),

        _FieldLabel('Last name'),
        const SizedBox(height: 8),
        _OnboardField(
          controller: _lastNameCtrl,
          hint: 'e.g. Nkosi',
          prefixIcon: Icons.person_outline_rounded,
        ),

        const SizedBox(height: 16),

        _FieldLabel('Phone number'),
        const SizedBox(height: 8),
        _PhoneField(controller: _phoneCtrl),

        const SizedBox(height: 24),

        _FieldLabel('Profile photo'),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => setState(() => _hasPhoto = !_hasPhoto),
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: HireIQTheme.surfaceWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomPaint(
              painter: _DashedBorderPainter(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _hasPhoto
                        ? Icons.check_circle_outline
                        : Icons.camera_alt_outlined,
                    color: _hasPhoto
                        ? HireIQTheme.primaryTeal
                        : HireIQTheme.textMuted,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _hasPhoto
                        ? 'Photo added'
                        : 'Add a profile photo (optional)',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: _hasPhoto
                          ? HireIQTheme.primaryTeal
                          : HireIQTheme.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 32),
        _ContinueButton(onTap: _next),
      ],
    );
  }

  // ── Step 2 — What kind of work? ──────────────────────────────────────────────

  Widget _buildStep2() {
    const categories = [
      (icon: Icons.computer_outlined, label: 'Technology'),
      (icon: Icons.build_outlined, label: 'Engineering'),
      (icon: Icons.account_balance_outlined, label: 'Finance'),
      (icon: Icons.local_hospital_outlined, label: 'Healthcare'),
      (icon: Icons.campaign_outlined, label: 'Marketing'),
      (icon: Icons.gavel_outlined, label: 'Legal'),
      (icon: Icons.school_outlined, label: 'Education'),
      (icon: Icons.shopping_bag_outlined, label: 'Sales & Retail'),
      (icon: Icons.more_horiz, label: 'More'),
    ];
    const levels = ['Entry', 'Mid', 'Senior', 'Exec'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepHeading(title: 'What kind of work?'),
        const SizedBox(height: 24),

        // Category search
        _OnboardField(
          controller: _categorySearchCtrl,
          hint: 'Search categories...',
          prefixIcon: Icons.search_rounded,
        ),

        const SizedBox(height: 16),

        // 3×3 category grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.05,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: categories.length,
          itemBuilder: (_, i) {
            final cat = categories[i];
            final isSelected = _selectedCategory == cat.label;
            return GestureDetector(
              onTap: () => setState(() => _selectedCategory = cat.label),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  color: isSelected
                      ? HireIQTheme.primaryTeal.withValues(alpha: 0.08)
                      : HireIQTheme.surfaceWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? HireIQTheme.primaryTeal
                        : HireIQTheme.borderLight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          HireIQTheme.primaryNavy.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      cat.icon,
                      size: 22,
                      color: isSelected
                          ? HireIQTheme.primaryTeal
                          : HireIQTheme.textMuted,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      cat.label,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? HireIQTheme.primaryTeal
                            : HireIQTheme.textMuted,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 24),

        _FieldLabel('Experience level'),
        const SizedBox(height: 12),

        Row(
          children: levels.asMap().entries.map((e) {
            final isSelected = _expLevel == e.value;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _expLevel = e.value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  margin: EdgeInsets.only(
                      right: e.key < levels.length - 1 ? 8 : 0),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? HireIQTheme.primaryTeal
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
                    e.value,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : HireIQTheme.textMuted,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 32),
        _ContinueButton(onTap: _next),
      ],
    );
  }

  // ── Step 3 — Where are you based? ────────────────────────────────────────────

  Widget _buildStep3() {
    const popularCities = ['Cape Town', 'Durban', 'Pretoria', 'Port Elizabeth'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepHeading(title: 'Where are you based?'),
        const SizedBox(height: 24),

        // City search
        _OnboardField(
          controller: _cityCtrl,
          hint: 'City or town',
          prefixIcon: Icons.location_on_outlined,
        ),

        const SizedBox(height: 20),

        _FieldLabel('Popular in South Africa'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: popularCities.map((city) {
            final isSelected = _selectedCities.contains(city);
            return GestureDetector(
              onTap: () => setState(() {
                if (isSelected) {
                  _selectedCities.remove(city);
                } else {
                  _selectedCities.add(city);
                }
              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
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
                  city,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? HireIQTheme.primaryTeal
                        : HireIQTheme.textMuted,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 16),

        // Remote toggle
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: HireIQTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: HireIQTheme.borderLight),
          ),
          child: Row(
            children: [
              const Icon(Icons.public_outlined,
                  color: HireIQTheme.primaryTeal, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Open to remote work',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: HireIQTheme.textPrimary,
                  ),
                ),
              ),
              Switch(
                value: _openToRemote,
                onChanged: (v) => setState(() => _openToRemote = v),
                activeThumbColor: Colors.white,
                activeTrackColor: HireIQTheme.primaryTeal,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        _FieldLabel('Expected monthly salary (ZAR)'),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          decoration: BoxDecoration(
            color: HireIQTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: HireIQTheme.borderLight),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatSalary(_salaryRange.start),
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy,
                    ),
                  ),
                  Text(
                    _formatSalary(_salaryRange.end),
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: HireIQTheme.primaryNavy,
                    ),
                  ),
                ],
              ),
              RangeSlider(
                values: _salaryRange,
                min: 0,
                max: 100000,
                activeColor: HireIQTheme.primaryTeal,
                inactiveColor: HireIQTheme.borderLight,
                onChanged: (v) => setState(() => _salaryRange = v),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        _FieldLabel('Available to start'),
        const SizedBox(height: 8),
        _OnboardField(
          controller: _availCtrl,
          hint: 'e.g. Immediately, 1 month notice',
          prefixIcon: Icons.calendar_today_outlined,
        ),

        const SizedBox(height: 32),
        _ContinueButton(onTap: _next),
      ],
    );
  }

  // ── Step 4 — Your skills and experience ──────────────────────────────────────

  Widget _buildStep4() {
    const expYearOptions = ['0-1yr', '1-3yrs', '4-6yrs', '7-10yrs'];
    const qualifications = [
      'Matric / Grade 12',
      'Certificate',
      'Diploma',
      "Bachelor's Degree",
      'Honours Degree',
      "Master's Degree",
      'PhD / Doctorate',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepHeading(title: 'Your skills and experience'),
        const SizedBox(height: 24),

        _FieldLabel('Skills'),
        const SizedBox(height: 8),

        // Skills chips
        if (_skills.isNotEmpty) ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _skills
                .map((skill) => _SkillChip(
                      label: skill,
                      onRemove: () => setState(() => _skills.remove(skill)),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
        ],

        // Skill input
        Row(
          children: [
            Expanded(
              child: _OnboardField(
                controller: _skillCtrl,
                hint: 'e.g. Flutter, Firebase, UI/UX Design',
                prefixIcon: Icons.add_rounded,
                onSubmitted: (_) => _addSkill(),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: _addSkill,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryTeal,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.add_rounded,
                    color: Colors.white, size: 20),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        _FieldLabel('Years of experience'),
        const SizedBox(height: 12),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: expYearOptions.map((yr) {
            final isSelected = _expYears == yr;
            return GestureDetector(
              onTap: () => setState(() => _expYears = yr),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 9),
                decoration: BoxDecoration(
                  color: isSelected
                      ? HireIQTheme.primaryTeal
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
                  yr,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color:
                        isSelected ? Colors.white : HireIQTheme.textMuted,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 20),

        _FieldLabel('Highest qualification'),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: HireIQTheme.borderLight),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _qualification,
              hint: Text(
                'Select qualification',
                style: GoogleFonts.inter(
                    fontSize: 14, color: HireIQTheme.textLight),
              ),
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: HireIQTheme.textMuted),
              items: qualifications
                  .map((q) => DropdownMenuItem(
                        value: q,
                        child: Text(
                          q,
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              color: HireIQTheme.textPrimary),
                        ),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _qualification = v),
            ),
          ),
        ),

        const SizedBox(height: 16),

        _FieldLabel('Current employer'),
        const SizedBox(height: 8),
        _OnboardField(
          controller: _employerCtrl,
          hint: 'Company name or self-employed',
          prefixIcon: Icons.business_outlined,
        ),

        const SizedBox(height: 20),

        // MatchIQ tip card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF0EDFF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF7C3AED).withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C3AED).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.bolt_rounded,
                    color: Color(0xFF7C3AED), size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'More skills = higher MatchIQ score',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF7C3AED),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),
        _ContinueButton(onTap: _next),
      ],
    );
  }

  void _addSkill() {
    final text = _skillCtrl.text.trim();
    if (text.isNotEmpty && !_skills.contains(text)) {
      setState(() {
        _skills.add(text);
        _skillCtrl.clear();
      });
    }
  }

  // ── Step 5 — One last thing ───────────────────────────────────────────────────

  Widget _buildStep5() {
    const referralOptions = [
      'Word of mouth',
      'Social media',
      'Google search',
      'LinkedIn',
      'Recruiter referred me',
      'Other',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepHeading(title: 'One last thing.'),
        const SizedBox(height: 6),
        Text(
          'Help us improve by sharing how you found us.',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: HireIQTheme.textMuted,
          ),
        ),
        const SizedBox(height: 24),

        _FieldLabel('How did you hear about us?'),
        const SizedBox(height: 12),

        // 2×3 grid of referral options
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: referralOptions.length,
          itemBuilder: (_, i) {
            final option = referralOptions[i];
            final isSelected = _referral == option;
            return GestureDetector(
              onTap: () => setState(() => _referral = option),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? HireIQTheme.primaryTeal.withValues(alpha: 0.1)
                      : HireIQTheme.surfaceWhite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected
                        ? HireIQTheme.primaryTeal
                        : HireIQTheme.borderLight,
                  ),
                ),
                child: Center(
                  child: Text(
                    option,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? HireIQTheme.primaryTeal
                          : HireIQTheme.textMuted,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 24),

        _FieldLabel('Stay updated'),
        const SizedBox(height: 12),

        // Job alerts toggle
        _ToggleRow(
          icon: Icons.work_outline_rounded,
          label: 'Job Alerts',
          subtitle: 'New job matches delivered daily',
          value: _jobAlerts,
          onChanged: (v) => setState(() => _jobAlerts = v),
        ),

        const SizedBox(height: 10),

        _ToggleRow(
          icon: Icons.chat_bubble_outline_rounded,
          label: 'WhatsApp Alerts',
          subtitle: 'Get notified via WhatsApp',
          value: _whatsappAlerts,
          onChanged: (v) => setState(() => _whatsappAlerts = v),
        ),

        const SizedBox(height: 32),

        // Complete button
        GestureDetector(
          onTap: _next,
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Complete Profile',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Shared step widgets ────────────────────────────────────────────────────────

class _StepHeading extends StatelessWidget {
  const _StepHeading({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: HireIQTheme.primaryNavy,
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: HireIQTheme.textPrimary,
      ),
    );
  }
}

class _OnboardField extends StatelessWidget {
  const _OnboardField({
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        style: GoogleFonts.inter(
            fontSize: 14, color: HireIQTheme.textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
              fontSize: 14, color: HireIQTheme.textLight),
          prefixIcon:
              Icon(prefixIcon, size: 18, color: HireIQTheme.textLight),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        ),
      ),
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.borderLight),
      ),
      child: Row(
        children: [
          // +27 prefix
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            height: 50,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: HireIQTheme.borderLight),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🇿🇦', style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 6),
                Text(
                  '+27',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: HireIQTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              style: GoogleFonts.inter(
                  fontSize: 14, color: HireIQTheme.textPrimary),
              decoration: InputDecoration(
                hintText: '82 123 4567',
                hintStyle: GoogleFonts.inter(
                    fontSize: 14, color: HireIQTheme.textLight),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.label, required this.onRemove});
  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
        border: Border.all(
          color: HireIQTheme.primaryTeal.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: HireIQTheme.primaryTeal,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close_rounded,
                size: 14, color: HireIQTheme.primaryTeal),
          ),
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: HireIQTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.borderLight),
        boxShadow: [
          BoxShadow(
            color: HireIQTheme.primaryNavy.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: HireIQTheme.primaryTeal, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: HireIQTheme.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: HireIQTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: HireIQTheme.primaryTeal,
          ),
        ],
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: HireIQTheme.primaryTeal,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'Continue',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Dashed border painter ──────────────────────────────────────────────────────

class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = HireIQTheme.borderLight
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dash = 8.0;
    const gap = 5.0;

    // Top
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + dash < size.width ? x + dash : size.width, 0),
        paint,
      );
      x += dash + gap;
    }
    // Bottom
    x = 0;
    while (x < size.width) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + dash < size.width ? x + dash : size.width, size.height),
        paint,
      );
      x += dash + gap;
    }
    // Left
    double y = 0;
    while (y < size.height) {
      canvas.drawLine(
        Offset(0, y),
        Offset(0, y + dash < size.height ? y + dash : size.height),
        paint,
      );
      y += dash + gap;
    }
    // Right
    y = 0;
    while (y < size.height) {
      canvas.drawLine(
        Offset(size.width, y),
        Offset(size.width, y + dash < size.height ? y + dash : size.height),
        paint,
      );
      y += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
