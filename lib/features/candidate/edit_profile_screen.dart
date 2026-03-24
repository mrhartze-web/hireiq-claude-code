import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/candidate_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/candidate_provider.dart';
import '../../providers/job_provider.dart';
import '../../shared/theme.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  bool _initialized = false;
  bool _isSaving = false;

  // ── Controllers ────────────────────────────────────────────────────────────
  final _headlineCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _bioCtrl = TextEditingController();
  final _skillsCtrl = TextEditingController();
  final _salaryExpCtrl = TextEditingController();
  final _preferredRolesCtrl = TextEditingController();

  // ── Dropdown state ─────────────────────────────────────────────────────────
  int _yearsExperience = 0;
  String _availabilityStatus = 'Available';

  static const _availabilityOptions = [
    'Available',
    'Open to offers',
    'Not looking',
  ];

  @override
  void dispose() {
    _headlineCtrl.dispose();
    _locationCtrl.dispose();
    _bioCtrl.dispose();
    _skillsCtrl.dispose();
    _salaryExpCtrl.dispose();
    _preferredRolesCtrl.dispose();
    super.dispose();
  }

  void _populate(CandidateModel profile) {
    _headlineCtrl.text = profile.headline;
    _locationCtrl.text = profile.location;
    _bioCtrl.text = profile.bio;
    _skillsCtrl.text = profile.skills.join(', ');
    if (profile.salaryExpectation > 0) {
      _salaryExpCtrl.text = profile.salaryExpectation.toString();
    }
    _preferredRolesCtrl.text = profile.preferredRoles.join(', ');
    // Dropdown values need setState — schedule for after current build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _yearsExperience = profile.yearsExperience.clamp(0, 20);
          _availabilityStatus =
              _normalizeAvailability(profile.availabilityStatus);
        });
      }
    });
  }

  String _normalizeAvailability(String raw) {
    switch (raw.toLowerCase().replaceAll('_', ' ')) {
      case 'open to offers':
      case 'open':
        return 'Open to offers';
      case 'not looking':
      case 'not_looking':
        return 'Not looking';
      default:
        return 'Available';
    }
  }

  List<String> _parseList(String text) => text
      .split(',')
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toList();

  int _calcCompletion() {
    int pct = 0;
    if (_headlineCtrl.text.trim().isNotEmpty) pct += 12;
    if (_locationCtrl.text.trim().isNotEmpty) pct += 12;
    if (_bioCtrl.text.trim().isNotEmpty) pct += 12;
    if (_yearsExperience > 0) pct += 12;
    if (_parseList(_skillsCtrl.text).isNotEmpty) pct += 15;
    if ((int.tryParse(_salaryExpCtrl.text.trim()) ?? 0) > 0) pct += 12;
    if (_availabilityStatus.isNotEmpty) pct += 12;
    if (_parseList(_preferredRolesCtrl.text).isNotEmpty) pct += 13;
    return pct;
  }

  Future<void> _save() async {
    final uid = ref.read(authStateProvider).value?.uid;
    if (uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not authenticated')),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      final existing = ref.read(candidateProfileProvider(uid)).value;

      final candidate = CandidateModel(
        uid: uid,
        headline: _headlineCtrl.text.trim(),
        location: _locationCtrl.text.trim(),
        bio: _bioCtrl.text.trim(),
        yearsExperience: _yearsExperience,
        skills: _parseList(_skillsCtrl.text),
        salaryExpectation:
            int.tryParse(_salaryExpCtrl.text.trim()) ?? 0,
        availabilityStatus: _availabilityStatus,
        preferredRoles: _parseList(_preferredRolesCtrl.text),
        profileCompletionPercent: _calcCompletion(),
        // Preserve server-managed fields
        cvUrl: existing?.cvUrl,
        matchIQScore: existing?.matchIQScore ?? 0.0,
        passportIQVerified: existing?.passportIQVerified ?? false,
      );

      await ref.read(firestoreServiceProvider).upsertCandidate(candidate);
      ref.invalidate(candidateProfileProvider(uid));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: HireIQTheme.primaryTeal,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = ref.watch(authStateProvider).value?.uid ?? '';
    final profileAsync = ref.watch(candidateProfileProvider(uid));

    // Pre-populate once when profile data arrives
    if (!_initialized) {
      profileAsync.whenData((profile) {
        if (profile != null) {
          _initialized = true;
          _populate(profile);
        }
      });
    }

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: HireIQTheme.primaryNavy,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Edit Profile',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: _isSaving ? null : _save,
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryTeal.withValues(alpha: 0.2),
                    borderRadius:
                        BorderRadius.circular(HireIQTheme.radiusFull),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : Text(
                          'Save',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 48),
              child: Column(
                children: [
                  // ── Avatar ───────────────────────────────────────────
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: HireIQTheme.primaryTeal, width: 3),
                        ),
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor:
                              HireIQTheme.primaryTeal.withValues(alpha: 0.1),
                          child: const Icon(Icons.person_rounded,
                              size: 44, color: HireIQTheme.primaryTeal),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                              color: HireIQTheme.primaryTeal,
                              shape: BoxShape.circle),
                          child: const Icon(Icons.camera_alt_rounded,
                              color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // ── Personal Info ─────────────────────────────────────
                  _EditSection(
                    title: 'Personal Info',
                    children: [
                      _fieldRow('Headline / Role',
                          'e.g. Senior Flutter Developer',
                          controller: _headlineCtrl),
                      _fieldRow('Location',
                          'e.g. Cape Town, South Africa',
                          controller: _locationCtrl),
                      _fieldRow('Bio',
                          'Tell employers about yourself...',
                          controller: _bioCtrl,
                          maxLines: 4),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Career Details ────────────────────────────────────
                  _EditSection(
                    title: 'Career Details',
                    children: [
                      _fieldLabel('Years of Experience'),
                      DropdownButtonFormField<int>(
                        value: _yearsExperience,
                        decoration: _inputDec(''),
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: HireIQTheme.textPrimary),
                        items: List.generate(21, (i) => i)
                            .map((y) => DropdownMenuItem(
                                  value: y,
                                  child: Text(y == 0
                                      ? '< 1 year'
                                      : y == 20
                                          ? '20+ years'
                                          : '$y year${y == 1 ? "" : "s"}'),
                                ))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _yearsExperience = v ?? 0),
                      ),
                      const SizedBox(height: 16),
                      _fieldLabel('Availability Status'),
                      DropdownButtonFormField<String>(
                        value: _availabilityStatus,
                        decoration: _inputDec(''),
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: HireIQTheme.textPrimary),
                        items: _availabilityOptions
                            .map((s) => DropdownMenuItem(
                                value: s, child: Text(s)))
                            .toList(),
                        onChanged: (v) => setState(
                            () => _availabilityStatus = v!),
                      ),
                      const SizedBox(height: 16),
                      _fieldRow('Salary Expectation (R / month)',
                          'e.g. 45000',
                          controller: _salaryExpCtrl,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ]),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Skills & Roles ────────────────────────────────────
                  _EditSection(
                    title: 'Skills & Preferred Roles',
                    children: [
                      _fieldRow('Skills',
                          'Flutter, Dart, Firebase (comma-separated)',
                          controller: _skillsCtrl),
                      _fieldRow('Preferred Roles',
                          'Flutter Dev, Mobile Lead (comma-separated)',
                          controller: _preferredRolesCtrl),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // ── Save button (bottom) ──────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isSaving
                            ? HireIQTheme.borderMedium
                            : HireIQTheme.primaryTeal,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                HireIQTheme.radiusLg)),
                      ),
                      child: _isSaving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white),
                            )
                          : Text('Save Profile',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  Widget _fieldRow(
    String label,
    String hint, {
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fieldLabel(label),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            style: GoogleFonts.inter(
                fontSize: 14, color: HireIQTheme.textPrimary),
            decoration: _inputDec(hint),
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: HireIQTheme.textMuted,
            letterSpacing: 0.2,
          ),
        ),
      );

  InputDecoration _inputDec(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
            color: HireIQTheme.textMuted, fontSize: 13),
        filled: true,
        fillColor: HireIQTheme.surfaceWhite,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
              const BorderSide(color: HireIQTheme.primaryTeal, width: 2),
        ),
      );
}

// ── Edit section ──────────────────────────────────────────────────────────────

class _EditSection extends StatelessWidget {
  const _EditSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: HireIQTheme.primaryNavy,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 14),
        ...children,
      ],
    );
  }
}
