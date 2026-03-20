import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class RecruiterBriefBuilder extends ConsumerStatefulWidget {
  const RecruiterBriefBuilder({super.key});

  @override
  ConsumerState<RecruiterBriefBuilder> createState() =>
      _RecruiterBriefBuilderState();
}

class _RecruiterBriefBuilderState extends ConsumerState<RecruiterBriefBuilder> {
  int _step = 0;
  bool _isGenerating = false;
  bool _briefGenerated = false;

  final _titleController = TextEditingController();
  final _requirementsController = TextEditingController();
  String _location = 'Cape Town';
  String _salaryRange = 'R60k – R80k';

  static const _locations = [
    'Cape Town', 'Johannesburg', 'Pretoria', 'Durban', 'Port Elizabeth', 'Remote'
  ];
  static const _salaryRanges = [
    'R30k – R50k', 'R50k – R70k', 'R60k – R80k', 'R80k – R110k', 'R110k+'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _requirementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      appBar: AppBar(
        backgroundColor: HireIQTheme.primaryNavy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Brief Builder',
          style: GoogleFonts.inter(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Container(
            height: 4,
            color: Colors.white.withValues(alpha: 0.1),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (_step + 1) / 3,
              child: Container(color: HireIQTheme.amber),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Step Indicator ────────────────────────────────────────────
            Row(
              children: List.generate(3, (i) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
                    child: Column(
                      children: [
                        Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: i <= _step
                                ? HireIQTheme.primaryNavy
                                : HireIQTheme.borderLight,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ['Role Details', 'Requirements', 'Generate'][i],
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: i <= _step
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: i <= _step
                                  ? HireIQTheme.primaryNavy
                                  : HireIQTheme.textMuted),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            if (_step == 0) ...[
              Text('Role Details',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 16),
              _FieldLabel('Job Title'),
              TextFormField(
                controller: _titleController,
                style: GoogleFonts.inter(
                    fontSize: 14, color: HireIQTheme.textPrimary),
                decoration: _inputDec('e.g. Senior Flutter Developer'),
              ),
              const SizedBox(height: 16),
              _FieldLabel('Location'),
              DropdownButtonFormField<String>(
                value: _location,
                decoration: _inputDec('Select location'),
                style: GoogleFonts.inter(
                    fontSize: 14, color: HireIQTheme.textPrimary),
                items: _locations
                    .map((l) =>
                        DropdownMenuItem(value: l, child: Text(l)))
                    .toList(),
                onChanged: (v) => setState(() => _location = v ?? _location),
              ),
              const SizedBox(height: 16),
              _FieldLabel('Salary Range'),
              DropdownButtonFormField<String>(
                value: _salaryRange,
                decoration: _inputDec('Select range'),
                style: GoogleFonts.inter(
                    fontSize: 14, color: HireIQTheme.textPrimary),
                items: _salaryRanges
                    .map((s) =>
                        DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => _salaryRange = v ?? _salaryRange),
              ),
            ] else if (_step == 1) ...[
              Text('Requirements',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 16),
              _FieldLabel('Role Requirements'),
              TextFormField(
                controller: _requirementsController,
                maxLines: 6,
                style: GoogleFonts.inter(
                    fontSize: 14, color: HireIQTheme.textPrimary),
                decoration: _inputDec(
                    'Describe the key requirements, must-have skills, and nice-to-haves...'),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome_rounded,
                        size: 16, color: HireIQTheme.primaryTeal),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'AI will enrich your brief with market-fit suggestions, ShieldIQ compliance checks, and MatchIQ optimisation.',
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: HireIQTheme.primaryTeal,
                            height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Text('AI-Generated Brief',
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy)),
              const SizedBox(height: 16),
              if (!_briefGenerated)
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: HireIQTheme.primaryNavy.withValues(alpha: 0.06),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.auto_awesome_rounded,
                            size: 40, color: HireIQTheme.primaryNavy),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _isGenerating
                            ? 'Generating your brief...'
                            : 'Ready to generate your brief',
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryNavy),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: _isGenerating
                              ? null
                              : () async {
                                  setState(() => _isGenerating = true);
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  setState(() {
                                    _isGenerating = false;
                                    _briefGenerated = true;
                                  });
                                },
                          icon: _isGenerating
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white))
                              : const Icon(Icons.auto_awesome_rounded),
                          label: Text(
                            _isGenerating ? 'Generating...' : 'Generate with AI',
                            style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HireIQTheme.amber,
                            foregroundColor: HireIQTheme.primaryNavy,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    HireIQTheme.radiusLg)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: HireIQTheme.surfaceWhite,
                        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
                        border: Border.all(color: HireIQTheme.borderLight),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Senior Flutter Developer',
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: HireIQTheme.primaryNavy),
                          ),
                          const SizedBox(height: 4),
                          Text('$_location • $_salaryRange',
                              style: GoogleFonts.inter(
                                  fontSize: 12, color: HireIQTheme.textMuted)),
                          const SizedBox(height: 14),
                          Text(
                            'We are looking for an experienced Flutter developer to lead mobile development at TechFlow Solutions. The ideal candidate has 5+ years of Flutter experience, proven architecture knowledge, and a passion for crafting seamless user experiences.\n\nMust-haves: Flutter/Dart • Firebase • Riverpod/BLoC • CI/CD • Clean Architecture\n\nNice-to-have: Kotlin/Swift • UI Animation • AWS/GCP',
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                color: HireIQTheme.textMuted,
                                height: 1.6),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: HireIQTheme.success.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.shield_rounded,
                              size: 16, color: HireIQTheme.primaryTeal),
                          const SizedBox(width: 8),
                          Text(
                            'ShieldIQ Note: Brief is POPIA compliant and B-BBEE aligned.',
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: HireIQTheme.primaryTeal),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HireIQTheme.primaryNavy,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  HireIQTheme.radiusLg)),
                        ),
                        child: Text(
                          'Save & Share Brief',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
            const SizedBox(height: 24),

            // ── Navigation Buttons ────────────────────────────────────────
            if (!(_step == 2 && _briefGenerated))
              Row(
                children: [
                  if (_step > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => _step--),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: HireIQTheme.primaryNavy,
                          side: const BorderSide(color: HireIQTheme.borderMedium),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(HireIQTheme.radiusLg)),
                        ),
                        child: Text('Back',
                            style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  if (_step > 0) const SizedBox(width: 12),
                  if (_step < 2)
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () => setState(() => _step++),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HireIQTheme.primaryNavy,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(HireIQTheme.radiusLg)),
                        ),
                        child: Text('Continue',
                            style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

InputDecoration _inputDec(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: GoogleFonts.inter(color: HireIQTheme.textMuted, fontSize: 13),
    filled: true,
    fillColor: HireIQTheme.surfaceWhite,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
      borderSide: const BorderSide(color: HireIQTheme.borderLight),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
      borderSide: const BorderSide(color: HireIQTheme.borderLight),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
      borderSide: const BorderSide(color: HireIQTheme.primaryTeal, width: 1.5),
    ),
    contentPadding: const EdgeInsets.all(14),
  );
}

Widget _FieldLabel(String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      label,
      style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: HireIQTheme.textPrimary),
    ),
  );
}
