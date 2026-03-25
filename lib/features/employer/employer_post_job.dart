import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/job_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/employer_provider.dart';
import '../../services/firebase/firestore_service.dart';
import '../../shared/theme.dart';

class EmployerPostJob extends ConsumerStatefulWidget {
  const EmployerPostJob({super.key});

  @override
  ConsumerState<EmployerPostJob> createState() => _EmployerPostJobState();
}

class _EmployerPostJobState extends ConsumerState<EmployerPostJob> {
  final _step0Key = GlobalKey<FormState>();
  final _step1Key = GlobalKey<FormState>();

  int _currentStep = 0;
  bool _isLoading = false;

  final _titleCtrl = TextEditingController();
  final _companyCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _requirementsCtrl = TextEditingController();
  final _skillsCtrl = TextEditingController();
  final _salaryMinCtrl = TextEditingController();
  final _salaryMaxCtrl = TextEditingController();
  final _departmentCtrl = TextEditingController();

  String _jobType = 'Full-time';
  String _experienceLevel = 'Mid Level';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final uid = ref.read(authStateProvider).value?.uid;
      if (uid == null) return;
      final employer = await ref.read(employerProfileProvider(uid).future);
      if (mounted && employer != null && employer.companyName.isNotEmpty) {
        _companyCtrl.text = employer.companyName;
      }
    });
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _companyCtrl.dispose();
    _locationCtrl.dispose();
    _descriptionCtrl.dispose();
    _requirementsCtrl.dispose();
    _skillsCtrl.dispose();
    _salaryMinCtrl.dispose();
    _salaryMaxCtrl.dispose();
    _departmentCtrl.dispose();
    super.dispose();
  }

  void _advance() {
    final key = _currentStep == 0 ? _step0Key : _step1Key;
    if (key.currentState?.validate() ?? false) {
      setState(() => _currentStep++);
    }
  }

  Future<void> _postJob() async {
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not authenticated — please sign in again.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final skills = _skillsCtrl.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final reqText = _buildRequirementsText();

      final job = JobModel(
        jobId: '',
        employerUid: uid,
        title: _titleCtrl.text.trim(),
        company: _companyCtrl.text.trim(),
        location: _locationCtrl.text.trim(),
        jobType: _jobType,
        description: _descriptionCtrl.text.trim(),
        requirements: reqText,
        skills: skills,
        salaryMin: int.tryParse(_salaryMinCtrl.text.trim()) ?? 0,
        salaryMax: int.tryParse(_salaryMaxCtrl.text.trim()) ?? 0,
        industry: _departmentCtrl.text.trim(),
        postedAt: DateTime.now(),
        isActive: true,
        applicationsCount: 0,
        matchIQEnabled: true,
        wildcardIQEnabled: false,
      );

      await FirestoreService().createJob(job);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Job posted successfully'),
            backgroundColor: HireIQTheme.primaryTeal,
          ),
        );
        context.go('/employer/my-jobs');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post job: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Prepends experience level to the user-supplied requirements text.
  String _buildRequirementsText() {
    final base = _requirementsCtrl.text.trim();
    final expLine = 'Experience Level: $_experienceLevel';
    return base.isEmpty ? expLine : '$expLine\n\n$base';
  }

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
    const steps = ['Basic Info', 'Details', 'Review'];
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
                          ? const Icon(Icons.check, color: Colors.white, size: 16)
                          : Text(
                              '${i + 1}',
                              style: GoogleFonts.inter(
                                color: isActive ? Colors.white : HireIQTheme.textMuted,
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
                        color: isActive ? HireIQTheme.primaryNavy : HireIQTheme.textMuted,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
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
                    color: isDone ? HireIQTheme.primaryTeal : HireIQTheme.borderLight,
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

  // ── Step 0: Basic Information ─────────────────────────────────────────────

  Widget _buildBasicInfoStep() {
    return Form(
      key: _step0Key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Basic Information'),
          const SizedBox(height: 20),
          _field(
            label: 'Job Title',
            hint: 'e.g. Senior Flutter Developer',
            controller: _titleCtrl,
            required: true,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Job title is required' : null,
          ),
          const SizedBox(height: 16),
          _field(
            label: 'Company Name',
            hint: 'e.g. Acme Corp',
            controller: _companyCtrl,
          ),
          const SizedBox(height: 16),
          _field(
            label: 'Location',
            hint: 'e.g. Cape Town (Remote)',
            controller: _locationCtrl,
            required: true,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Location is required' : null,
          ),
          const SizedBox(height: 16),
          _dropdownField(
            label: 'Employment Type',
            value: _jobType,
            options: const ['Full-time', 'Part-time', 'Contract', 'Freelance'],
            onChanged: (v) => setState(() => _jobType = v!),
          ),
          const SizedBox(height: 16),
          _field(
            label: 'Department / Industry',
            hint: 'e.g. Engineering, Finance, Marketing',
            controller: _departmentCtrl,
          ),
          const SizedBox(height: 16),
          _dropdownField(
            label: 'Experience Level',
            value: _experienceLevel,
            options: const [
              'Entry Level',
              'Mid Level',
              'Senior',
              'Lead',
              'Executive',
            ],
            onChanged: (v) => setState(() => _experienceLevel = v!),
          ),
        ],
      ),
    );
  }

  // ── Step 1: Job Details ───────────────────────────────────────────────────

  Widget _buildDetailsStep() {
    return Form(
      key: _step1Key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Job Details'),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Job Description',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: HireIQTheme.textPrimary),
              ),
              _aiGenerateChip(),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _descriptionCtrl,
            maxLines: 6,
            style: GoogleFonts.inter(color: HireIQTheme.textPrimary),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Description is required' : null,
            decoration: _inputDeco(
              'Describe the role, responsibilities, and what success looks like...',
            ),
          ),
          const SizedBox(height: 16),
          _field(
            label: 'Requirements',
            hint: 'List the must-have qualifications and skills...',
            controller: _requirementsCtrl,
            maxLines: 4,
          ),
          const SizedBox(height: 16),
          _field(
            label: 'Required Skills',
            hint: 'Flutter, Dart, Firebase (comma-separated)',
            controller: _skillsCtrl,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _field(
                  label: 'Min Salary (R)',
                  hint: '30000',
                  controller: _salaryMinCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _field(
                  label: 'Max Salary (R)',
                  hint: '60000',
                  controller: _salaryMaxCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Step 2: Review & Publish ──────────────────────────────────────────────

  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Review & Publish'),
        const SizedBox(height: 16),
        _reviewCard(),
        const SizedBox(height: 24),
        _postJobButton(),
      ],
    );
  }

  Widget _reviewCard() {
    return Container(
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _titleCtrl.text.trim().isEmpty ? 'Untitled Role' : _titleCtrl.text.trim(),
            style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: HireIQTheme.textPrimary),
          ),
          if (_companyCtrl.text.trim().isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(_companyCtrl.text.trim(),
                style: GoogleFonts.inter(
                    color: HireIQTheme.primaryTeal,
                    fontWeight: FontWeight.w600)),
          ],
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _chip(Icons.location_on_outlined, _locationCtrl.text.trim()),
              _chip(Icons.work_outline, _jobType),
              _chip(Icons.trending_up_outlined, _experienceLevel),
              if (_departmentCtrl.text.trim().isNotEmpty)
                _chip(Icons.domain_outlined, _departmentCtrl.text.trim()),
              if (_salaryMinCtrl.text.isNotEmpty || _salaryMaxCtrl.text.isNotEmpty)
                _chip(
                  Icons.payments_outlined,
                  'R${_salaryMinCtrl.text.isEmpty ? "0" : _salaryMinCtrl.text}'
                  ' – R${_salaryMaxCtrl.text.isEmpty ? "0" : _salaryMaxCtrl.text}',
                ),
            ],
          ),
          if (_descriptionCtrl.text.trim().isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(color: HireIQTheme.borderLight),
            const SizedBox(height: 12),
            Text('Description',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: HireIQTheme.textPrimary)),
            const SizedBox(height: 6),
            Text(
              _descriptionCtrl.text.trim(),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                  color: HireIQTheme.textSecondary, height: 1.5, fontSize: 13),
            ),
          ],
          if (_skillsCtrl.text.trim().isNotEmpty) ...[
            const SizedBox(height: 14),
            Text('Skills',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: HireIQTheme.textPrimary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: _skillsCtrl.text
                  .split(',')
                  .map((s) => s.trim())
                  .where((s) => s.isNotEmpty)
                  .map((s) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: HireIQTheme.primaryTeal.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
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
        ],
      ),
    );
  }

  Widget _postJobButton() {
    return GestureDetector(
      onTap: _isLoading ? null : _postJob,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isLoading
                ? [HireIQTheme.textMuted, HireIQTheme.textMuted]
                : const [HireIQTheme.primaryTeal, Color(0xFF0A7A70)],
          ),
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
        ),
        alignment: Alignment.center,
        child: _isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                    strokeWidth: 2.5, color: Colors.white),
              )
            : Text(
                'Post Job',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white),
              ),
      ),
    );
  }

  // ── Navigation Buttons ────────────────────────────────────────────────────

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
                  borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
                  border: Border.all(color: HireIQTheme.borderLight),
                ),
                alignment: Alignment.center,
                child: Text('Back',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: HireIQTheme.textPrimary)),
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: _advance,
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [HireIQTheme.primaryNavy, Color(0xFF243659)],
                ),
                borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
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

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _sectionTitle(String text) => Text(
        text,
        style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: HireIQTheme.textPrimary),
      );

  InputDecoration _inputDeco(String hint, {String? errorText}) =>
      InputDecoration(
        hintText: hint,
        errorText: errorText,
        hintStyle: GoogleFonts.inter(color: HireIQTheme.textMuted),
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
          borderSide: const BorderSide(color: HireIQTheme.primaryTeal),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
          borderSide: const BorderSide(color: Colors.red),
        ),
      );

  Widget _field({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool required = false,
    int maxLines = 1,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: HireIQTheme.textPrimary),
            ),
            if (required)
              Text(' *',
                  style: GoogleFonts.inter(
                      color: Colors.red, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: GoogleFonts.inter(color: HireIQTheme.textPrimary),
          validator: validator,
          decoration: _inputDeco(hint),
        ),
      ],
    );
  }

  Widget _dropdownField({
    required String label,
    required String value,
    required List<String> options,
    required void Function(String?) onChanged,
  }) {
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
          value: value,
          decoration: _inputDeco(''),
          style: GoogleFonts.inter(color: HireIQTheme.textPrimary),
          items: options
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e,
                        style: GoogleFonts.inter(
                            color: HireIQTheme.textPrimary)),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _chip(IconData icon, String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: HireIQTheme.background,
          borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
          border: Border.all(color: HireIQTheme.borderLight),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: HireIQTheme.textMuted),
            const SizedBox(width: 5),
            Text(text,
                style: GoogleFonts.inter(
                    fontSize: 12, color: HireIQTheme.textSecondary)),
          ],
        ),
      );

  Widget _aiGenerateChip() => GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [HireIQTheme.primaryTeal, Color(0xFF0A7A70)],
            ),
            borderRadius: BorderRadius.circular(HireIQTheme.radiusFull),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.auto_awesome, size: 14, color: Colors.white),
              const SizedBox(width: 6),
              Text('AI Generate',
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ],
          ),
        ),
      );
}
