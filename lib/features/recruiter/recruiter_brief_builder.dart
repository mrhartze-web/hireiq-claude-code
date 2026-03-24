import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/brief_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/job_provider.dart';
import '../../shared/theme.dart';
import '../mobile_screens.dart';

class RecruiterBriefBuilder extends ConsumerStatefulWidget {
  const RecruiterBriefBuilder({super.key});

  @override
  ConsumerState<RecruiterBriefBuilder> createState() =>
      _RecruiterBriefBuilderState();
}

class _RecruiterBriefBuilderState extends ConsumerState<RecruiterBriefBuilder> {
  int _step = 0;
  bool _isSubmitting = false;

  // ── Form keys ──────────────────────────────────────────────────────────────
  final _step0Key = GlobalKey<FormState>();
  final _step1Key = GlobalKey<FormState>();

  // ── Step 1 controllers ────────────────────────────────────────────────────
  final _roleNameCtrl = TextEditingController();
  final _employerCompanyCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  String _industry = 'Technology';
  String _contractType = 'Permanent';

  // ── Step 2 controllers ────────────────────────────────────────────────────
  String _experienceLevel = 'Mid-level';
  final _qualificationsCtrl = TextEditingController();
  final _skillsCtrl = TextEditingController();
  final _salaryMinCtrl = TextEditingController();
  final _salaryMaxCtrl = TextEditingController();

  // ── Step 3 state ──────────────────────────────────────────────────────────
  final _annualSalaryCtrl = TextEditingController();
  double _feePercentage = 12.0;

  double get _annualSalary =>
      double.tryParse(_annualSalaryCtrl.text.trim()) ?? 0.0;
  double get _feeAmount => _annualSalary * _feePercentage / 100;
  double get _hireIQCut => _feeAmount * 0.20;
  double get _recruiterEarnings => _feeAmount * 0.80;

  @override
  void dispose() {
    _roleNameCtrl.dispose();
    _employerCompanyCtrl.dispose();
    _locationCtrl.dispose();
    _qualificationsCtrl.dispose();
    _skillsCtrl.dispose();
    _salaryMinCtrl.dispose();
    _salaryMaxCtrl.dispose();
    _annualSalaryCtrl.dispose();
    super.dispose();
  }

  void _advance() {
    if (_step == 0 && !(_step0Key.currentState?.validate() ?? false)) return;
    if (_step == 1 && !(_step1Key.currentState?.validate() ?? false)) return;
    if (_step < 3) setState(() => _step++);
  }

  Future<void> _submit() async {
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not authenticated — please sign in again.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final requirements = _buildRequirements();
      final brief = BriefModel(
        briefId: '',
        recruiterUid: uid,
        employerUid: _employerCompanyCtrl.text.trim(),
        roleName: _roleNameCtrl.text.trim(),
        industry: _industry,
        salaryMin: int.tryParse(_salaryMinCtrl.text.trim()) ?? 0,
        salaryMax: int.tryParse(_salaryMaxCtrl.text.trim()) ?? 0,
        annualSalary: _annualSalary.toInt(),
        feePercentage: _feePercentage,
        feeAmount: _feeAmount,
        requirements: requirements,
        timeline: _contractType,
        status: 'open',
        createdAt: DateTime.now(),
        submissionsCount: 0,
      );

      await ref.read(firestoreServiceProvider).createBrief(brief);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Brief created successfully'),
            backgroundColor: HireIQTheme.primaryTeal,
          ),
        );
        context.go(MobileRoutes.recruiterBriefs);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create brief: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  String _buildRequirements() {
    final parts = <String>[];
    parts.add('Location: ${_locationCtrl.text.trim()}');
    parts.add('Contract Type: $_contractType');
    parts.add('Experience Level: $_experienceLevel');
    if (_qualificationsCtrl.text.trim().isNotEmpty) {
      parts.add('Qualifications: ${_qualificationsCtrl.text.trim()}');
    }
    if (_skillsCtrl.text.trim().isNotEmpty) {
      parts.add('Skills: ${_skillsCtrl.text.trim()}');
    }
    return parts.join('\n');
  }

  List<String> get _skills => _skillsCtrl.text
      .split(',')
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toList();

  @override
  Widget build(BuildContext context) {
    const stepLabels = ['Role Details', 'Requirements', 'Fee Calc', 'Review'];
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
              widthFactor: (_step + 1) / 4,
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
            // ── Step indicator ────────────────────────────────────────────
            Row(
              children: List.generate(4, (i) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: i < 3 ? 6 : 0),
                  child: Column(children: [
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: i <= _step
                            ? HireIQTheme.amber
                            : HireIQTheme.borderLight,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stepLabels[i],
                      style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: i <= _step
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: i <= _step
                              ? HireIQTheme.primaryNavy
                              : HireIQTheme.textMuted),
                    ),
                  ]),
                ),
              )),
            ),
            const SizedBox(height: 28),

            // ── Step body ─────────────────────────────────────────────────
            _buildStep(),
            const SizedBox(height: 28),

            // ── Navigation ────────────────────────────────────────────────
            _buildNavButtons(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 0: return _buildStep0();
      case 1: return _buildStep1();
      case 2: return _buildStep2();
      case 3: return _buildStep3();
      default: return _buildStep0();
    }
  }

  // ── Step 0: Role Details ──────────────────────────────────────────────────

  Widget _buildStep0() {
    return Form(
      key: _step0Key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _stepTitle('Role Details'),
          const SizedBox(height: 20),
          _fieldLabel('Role Name', required: true),
          TextFormField(
            controller: _roleNameCtrl,
            style: _textStyle,
            decoration: _inputDec('e.g. Senior Flutter Developer'),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Role name is required' : null,
          ),
          const SizedBox(height: 16),
          _fieldLabel('Client Company', required: true),
          TextFormField(
            controller: _employerCompanyCtrl,
            style: _textStyle,
            decoration: _inputDec('e.g. Acme Corp'),
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'Company name is required'
                : null,
          ),
          const SizedBox(height: 16),
          _fieldLabel('Industry'),
          DropdownButtonFormField<String>(
            value: _industry,
            decoration: _inputDec(''),
            style: _textStyle,
            items: const [
              'Technology', 'Finance', 'Engineering', 'Healthcare',
              'Legal', 'Marketing', 'Sales', 'Executive', 'Other',
            ].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
            onChanged: (v) => setState(() => _industry = v!),
          ),
          const SizedBox(height: 16),
          _fieldLabel('Location', required: true),
          TextFormField(
            controller: _locationCtrl,
            style: _textStyle,
            decoration: _inputDec('e.g. Cape Town (Remote)'),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Location is required' : null,
          ),
          const SizedBox(height: 16),
          _fieldLabel('Contract Type'),
          DropdownButtonFormField<String>(
            value: _contractType,
            decoration: _inputDec(''),
            style: _textStyle,
            items: const ['Permanent', 'Contract', 'Freelance']
                .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                .toList(),
            onChanged: (v) => setState(() => _contractType = v!),
          ),
        ],
      ),
    );
  }

  // ── Step 1: Requirements ──────────────────────────────────────────────────

  Widget _buildStep1() {
    return Form(
      key: _step1Key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _stepTitle('Requirements'),
          const SizedBox(height: 20),
          _fieldLabel('Experience Level'),
          DropdownButtonFormField<String>(
            value: _experienceLevel,
            decoration: _inputDec(''),
            style: _textStyle,
            items: const ['Junior', 'Mid-level', 'Senior', 'Executive']
                .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                .toList(),
            onChanged: (v) => setState(() => _experienceLevel = v!),
          ),
          const SizedBox(height: 16),
          _fieldLabel('Qualifications'),
          TextFormField(
            controller: _qualificationsCtrl,
            style: _textStyle,
            decoration: _inputDec('e.g. BSc Computer Science, AWS Certified'),
          ),
          const SizedBox(height: 16),
          _fieldLabel('Required Skills'),
          TextFormField(
            controller: _skillsCtrl,
            style: _textStyle,
            decoration: _inputDec('Flutter, Dart, Firebase (comma-separated)'),
          ),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fieldLabel('Min Salary (R)'),
                  TextFormField(
                    controller: _salaryMinCtrl,
                    style: _textStyle,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: _inputDec('30000'),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fieldLabel('Max Salary (R)'),
                  TextFormField(
                    controller: _salaryMaxCtrl,
                    style: _textStyle,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: _inputDec('60000'),
                  ),
                ],
              ),
            ),
          ]),
          const SizedBox(height: 14),
          _aiInfoBanner(),
        ],
      ),
    );
  }

  // ── Step 2: Fee Calculation ───────────────────────────────────────────────

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _stepTitle('Fee Calculation'),
        const SizedBox(height: 20),
        _fieldLabel('Expected Annual Salary (R)'),
        TextFormField(
          controller: _annualSalaryCtrl,
          style: _textStyle,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: _inputDec('600000'),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 20),
        _fieldLabel('Fee Percentage'),
        const SizedBox(height: 8),
        _feePercentageSelector(),
        const SizedBox(height: 24),
        _feeBreakdownCard(),
      ],
    );
  }

  Widget _feePercentageSelector() {
    const options = [
      (pct: 10.0, label: '10%', desc: 'Junior roles'),
      (pct: 12.0, label: '12%', desc: 'Mid-level roles'),
      (pct: 15.0, label: '15%', desc: 'Senior & specialist'),
    ];
    return Row(
      children: options.map((opt) {
        final selected = _feePercentage == opt.pct;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _feePercentage = opt.pct),
            child: Container(
              margin: EdgeInsets.only(
                right: opt.pct < 15.0 ? 8 : 0,
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              decoration: BoxDecoration(
                color: selected
                    ? HireIQTheme.amber.withValues(alpha: 0.12)
                    : HireIQTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                border: Border.all(
                  color: selected ? HireIQTheme.amber : HireIQTheme.borderLight,
                  width: selected ? 1.5 : 1,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    opt.label,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: selected
                          ? HireIQTheme.primaryNavy
                          : HireIQTheme.textMuted,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    opt.desc,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: selected
                          ? HireIQTheme.primaryNavy
                          : HireIQTheme.textMuted,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _feeBreakdownCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: HireIQTheme.primaryNavy,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fee Breakdown',
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withValues(alpha: 0.7))),
          const SizedBox(height: 16),
          _breakdownRow('Total Placement Fee', _feeAmount,
              highlight: true),
          const SizedBox(height: 12),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.1)),
          const SizedBox(height: 12),
          _breakdownRow('HireIQ Platform (20%)', _hireIQCut),
          const SizedBox(height: 8),
          _breakdownRow('Your Earnings (80%)', _recruiterEarnings,
              highlight: true, accent: HireIQTheme.amber),
        ],
      ),
    );
  }

  Widget _breakdownRow(String label, double amount,
      {bool highlight = false, Color? accent}) {
    final color = accent ?? (highlight ? Colors.white : Colors.white.withValues(alpha: 0.6));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.white.withValues(alpha: 0.7))),
        Text(
          'R ${_formatCurrency(amount)}',
          style: GoogleFonts.inter(
              fontSize: highlight ? 16 : 14,
              fontWeight: highlight ? FontWeight.w800 : FontWeight.w600,
              color: color),
        ),
      ],
    );
  }

  // ── Step 3: Review ────────────────────────────────────────────────────────

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _stepTitle('Review & Submit'),
        const SizedBox(height: 20),
        _reviewCard(),
        const SizedBox(height: 16),
        _shieldIQBanner(),
        const SizedBox(height: 24),
        _submitButton(),
      ],
    );
  }

  Widget _reviewCard() {
    return Container(
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
            _roleNameCtrl.text.trim().isEmpty
                ? 'Untitled Role'
                : _roleNameCtrl.text.trim(),
            style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.primaryNavy),
          ),
          if (_employerCompanyCtrl.text.trim().isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(_employerCompanyCtrl.text.trim(),
                style: GoogleFonts.inter(
                    color: HireIQTheme.primaryTeal,
                    fontWeight: FontWeight.w600)),
          ],
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: [
            _chip(Icons.domain_outlined, _industry),
            _chip(Icons.location_on_outlined, _locationCtrl.text.trim()),
            _chip(Icons.work_outline, _contractType),
            _chip(Icons.trending_up_outlined, _experienceLevel),
          ]),
          if (_salaryMinCtrl.text.isNotEmpty || _salaryMaxCtrl.text.isNotEmpty) ...[
            const SizedBox(height: 8),
            _chip(
              Icons.payments_outlined,
              'R${_salaryMinCtrl.text.isEmpty ? "0" : _salaryMinCtrl.text}'
              ' – R${_salaryMaxCtrl.text.isEmpty ? "0" : _salaryMaxCtrl.text}',
            ),
          ],
          if (_skills.isNotEmpty) ...[
            const SizedBox(height: 14),
            const Divider(color: HireIQTheme.borderLight),
            const SizedBox(height: 10),
            Text('Skills',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: HireIQTheme.textPrimary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: _skills
                  .map((s) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusFull),
                        ),
                        child: Text(s,
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                color: HireIQTheme.primaryTeal,
                                fontWeight: FontWeight.w500)),
                      ))
                  .toList(),
            ),
          ],
          if (_annualSalary > 0) ...[
            const SizedBox(height: 14),
            const Divider(color: HireIQTheme.borderLight),
            const SizedBox(height: 10),
            Text('Fee Summary',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: HireIQTheme.textPrimary)),
            const SizedBox(height: 8),
            _reviewFeeRow(
                'Annual Salary', 'R ${_formatCurrency(_annualSalary)}'),
            _reviewFeeRow('Fee (${_feePercentage.toInt()}%)',
                'R ${_formatCurrency(_feeAmount)}'),
            _reviewFeeRow(
                'Your Earnings', 'R ${_formatCurrency(_recruiterEarnings)}',
                bold: true),
          ],
        ],
      ),
    );
  }

  Widget _reviewFeeRow(String label, String value, {bool bold = false}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: GoogleFonts.inter(
                    fontSize: 13, color: HireIQTheme.textSecondary)),
            Text(value,
                style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
                    color: bold
                        ? HireIQTheme.primaryNavy
                        : HireIQTheme.textPrimary)),
          ],
        ),
      );

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isSubmitting ? null : _submit,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _isSubmitting ? HireIQTheme.borderMedium : HireIQTheme.amber,
          foregroundColor: HireIQTheme.primaryNavy,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
        ),
        child: _isSubmitting
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: HireIQTheme.primaryNavy),
              )
            : Text(
                'Confirm and Submit Brief',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700, fontSize: 15),
              ),
      ),
    );
  }

  // ── Navigation buttons ────────────────────────────────────────────────────

  Widget _buildNavButtons() {
    // On step 3 (review), submit button is inside the step — hide nav
    if (_step == 3) return const SizedBox.shrink();
    return Row(children: [
      if (_step > 0) ...[
        Expanded(
          child: OutlinedButton(
            onPressed: () => setState(() => _step--),
            style: OutlinedButton.styleFrom(
              foregroundColor: HireIQTheme.primaryNavy,
              side: const BorderSide(color: HireIQTheme.borderMedium),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
            ),
            child: Text('Back',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(width: 12),
      ],
      Expanded(
        flex: 2,
        child: ElevatedButton(
          onPressed: _advance,
          style: ElevatedButton.styleFrom(
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(HireIQTheme.radiusLg)),
          ),
          child: Text('Continue',
              style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
        ),
      ),
    ]);
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  TextStyle get _textStyle =>
      GoogleFonts.inter(fontSize: 14, color: HireIQTheme.textPrimary);

  Widget _stepTitle(String text) => Text(
        text,
        style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: HireIQTheme.primaryNavy),
      );

  Widget _fieldLabel(String label, {bool required = false}) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(children: [
          Text(label,
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: HireIQTheme.textPrimary)),
          if (required)
            Text(' *',
                style: GoogleFonts.inter(
                    color: Colors.red, fontWeight: FontWeight.w600)),
        ]),
      );

  InputDecoration _inputDec(String hint) => InputDecoration(
        hintText: hint,
        hintStyle:
            GoogleFonts.inter(color: HireIQTheme.textMuted, fontSize: 13),
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
          borderSide:
              const BorderSide(color: HireIQTheme.primaryTeal, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: const EdgeInsets.all(14),
      );

  Widget _chip(IconData icon, String text) => Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: HireIQTheme.background,
          borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
          border: Border.all(color: HireIQTheme.borderLight),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 12, color: HireIQTheme.textMuted),
          const SizedBox(width: 5),
          Text(text,
              style: GoogleFonts.inter(
                  fontSize: 12, color: HireIQTheme.textSecondary)),
        ]),
      );

  Widget _aiInfoBanner() => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
        ),
        child: Row(children: [
          const Icon(Icons.auto_awesome_rounded,
              size: 16, color: HireIQTheme.primaryTeal),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'MatchIQ will surface the best-fit candidates for this brief automatically.',
              style: GoogleFonts.inter(
                  fontSize: 12, color: HireIQTheme.primaryTeal, height: 1.4),
            ),
          ),
        ]),
      );

  Widget _shieldIQBanner() => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: HireIQTheme.success.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
        ),
        child: Row(children: [
          const Icon(Icons.shield_rounded,
              size: 16, color: HireIQTheme.primaryTeal),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'ShieldIQ: Brief will be checked for POPIA compliance and B-BBEE alignment before publishing.',
              style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: HireIQTheme.primaryTeal),
            ),
          ),
        ]),
      );

  String _formatCurrency(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(2)}M';
    }
    if (amount >= 1000) {
      final k = (amount / 1000).toStringAsFixed(1);
      return '${k}k';
    }
    return amount.toStringAsFixed(0);
  }
}
