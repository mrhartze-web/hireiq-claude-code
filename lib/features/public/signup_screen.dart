import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../providers/auth_provider.dart';
import '../mobile_screens.dart';

// ── Screen ─────────────────────────────────────────────────────────────────────

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key, this.initialRole, this.gigFocused = false});

  final String? initialRole;
  final bool gigFocused;

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _agreedToTerms = false;
  late String _selectedRole;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    const validRoles = {'candidate', 'employer', 'recruiter'};
    final incoming = widget.initialRole;
    _selectedRole = incoming != null && validRoles.contains(incoming)
        ? incoming
        : 'candidate';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  double get _passwordStrength {
    final pwd = _passwordController.text;
    if (pwd.isEmpty) return 0;
    if (pwd.length < 6) return 0.33;
    if (pwd.length < 8) return 0.5;
    if (pwd.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(pwd) &&
        RegExp(r'[0-9]').hasMatch(pwd)) {
      return 1.0;
    }
    return 0.75;
  }

  Future<void> _signUp() async {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        _phoneController.text.trim().isEmpty) {
      setState(() => _error = 'Please fill in all fields.');
      return;
    }
    if (!_agreedToTerms) {
      setState(() =>
          _error = 'Please agree to the Terms of Service and Privacy Policy.');
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() => _error = 'Passwords do not match.');
      return;
    }
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final credential = await ref.read(authServiceProvider).signUpWithEmail(
            email: _emailController.text,
            password: _passwordController.text,
            displayName: _nameController.text.trim(),
            role: _selectedRole,
          );
      debugPrint(
          '[SignupScreen] signup complete — uid=${credential.user?.uid}, role=$_selectedRole');
      ref.read(cachedRoleProvider.notifier).state = _selectedRole;
      if (mounted) {
        switch (_selectedRole) {
          case 'employer':
            context.go(MobileRoutes.employerOnboardingSteps);
          case 'recruiter':
            context.go('/recruiter/onboarding/step-1');
          default:
            if (widget.gigFocused) {
              context.go('/candidate/gigs');
            } else {
              context.go('/candidate-onboarding');
            }
        }
      }
    } catch (e) {
      String message = 'Sign up failed. Please try again.';
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            message = 'This email is already registered. Sign in instead.';
            break;
          case 'weak-password':
            message = 'Password must be at least 6 characters.';
            break;
          case 'invalid-email':
            message = 'Please enter a valid email address.';
            break;
          default:
            message = e.message ?? 'Sign up failed. Please try again.';
        }
      }
      setState(() => _error = message);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.surfaceWhite,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          if (isMobile) {
            return _buildMobileLayout();
          }
          return _buildDesktopLayout();
        },
      ),
    );
  }

  // ── Mobile layout ────────────────────────────────────────────────────────────

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top navy bar with wordmark and step
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                  color: HireIQTheme.primaryNavy,
                  child: const Row(
                    children: [
                      _WordMark(fontSize: 22),
                      Spacer(),
                      _StepBadge(label: 'Step 2 of 2'),
                    ],
                  ),
                ),
                // Form body
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create your account',
                        style: GoogleFonts.inter(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: HireIQTheme.primaryNavy,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Your AI-powered career profile is ready in under 2 minutes.',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: HireIQTheme.textMuted,
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (_error != null) ...[
                        _ErrorBanner(message: _error!),
                        const SizedBox(height: 16),
                      ],
                      _FormFields(
                        nameController: _nameController,
                        emailController: _emailController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                        phoneController: _phoneController,
                        passwordVisible: _passwordVisible,
                        confirmPasswordVisible: _confirmPasswordVisible,
                        passwordStrength: _passwordStrength,
                        agreedToTerms: _agreedToTerms,
                        onTogglePassword: () => setState(
                            () => _passwordVisible = !_passwordVisible),
                        onToggleConfirmPassword: () => setState(() =>
                            _confirmPasswordVisible = !_confirmPasswordVisible),
                        onToggleTerms: () =>
                            setState(() => _agreedToTerms = !_agreedToTerms),
                        isMobile: true,
                      ),
                      const SizedBox(height: 24),
                      _CreateAccountButton(
                        isLoading: _isLoading,
                        onPressed: _signUp,
                      ),
                      const SizedBox(height: 20),
                      const _Divider(),
                      const SizedBox(height: 20),
                      _GoogleButton(),
                      const SizedBox(height: 20),
                      const _POPIANote(),
                      const SizedBox(height: 20),
                      _SignInLink(onTap: () => context.go('/login')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Bottom gradient bar
        Container(
          height: 4,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [HireIQTheme.primaryTeal, HireIQTheme.primaryNavy],
            ),
          ),
        ),
      ],
    );
  }

  // ── Desktop layout ───────────────────────────────────────────────────────────

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Left column — 45%
        Expanded(
          flex: 45,
          child: Container(
            color: HireIQTheme.primaryNavy,
            padding: const EdgeInsets.fromLTRB(48, 56, 48, 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _WordMark(fontSize: 30),
                const SizedBox(height: 48),
                Text(
                  'Let us build your profile.',
                  style: GoogleFonts.inter(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -1,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'A few details and your AI-powered career profile is ready to go.',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: Colors.white.withValues(alpha: 0.8),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                const _BenefitRow(
                    text: 'Your profile is visible to verified employers'),
                const SizedBox(height: 20),
                const _BenefitRow(
                    text: 'MatchIQ starts scoring you immediately'),
                const SizedBox(height: 20),
                const _BenefitRow(
                    text: 'Takes less than 2 minutes to complete'),
                const Spacer(),
                // Progress indicators
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: HireIQTheme.primaryTeal,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: HireIQTheme.primaryTeal,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'STEP 2 OF 2 — ALMOST THERE',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: HireIQTheme.primaryTeal,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Right column — 55%
        Expanded(
          flex: 55,
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(56, 48, 56, 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: _StepBadge(label: 'Step 2 of 2'),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Create your account',
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: HireIQTheme.primaryNavy,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your AI-powered career profile is ready in under 2 minutes.',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: HireIQTheme.textMuted,
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (_error != null) ...[
                    _ErrorBanner(message: _error!),
                    const SizedBox(height: 20),
                  ],
                  _FormFields(
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    phoneController: _phoneController,
                    passwordVisible: _passwordVisible,
                    confirmPasswordVisible: _confirmPasswordVisible,
                    passwordStrength: _passwordStrength,
                    agreedToTerms: _agreedToTerms,
                    onTogglePassword: () =>
                        setState(() => _passwordVisible = !_passwordVisible),
                    onToggleConfirmPassword: () => setState(() =>
                        _confirmPasswordVisible = !_confirmPasswordVisible),
                    onToggleTerms: () =>
                        setState(() => _agreedToTerms = !_agreedToTerms),
                    isMobile: false,
                  ),
                  const SizedBox(height: 28),
                  _CreateAccountButton(
                    isLoading: _isLoading,
                    onPressed: _signUp,
                  ),
                  const SizedBox(height: 24),
                  const _Divider(),
                  const SizedBox(height: 24),
                  _GoogleButton(),
                  const SizedBox(height: 24),
                  const _POPIANote(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Shared sub-widgets ─────────────────────────────────────────────────────────

class _WordMark extends StatelessWidget {
  const _WordMark({required this.fontSize});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: 'Hire',
          style: GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        TextSpan(
          text: 'IQ',
          style: GoogleFonts.inter(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            color: HireIQTheme.primaryTeal,
            letterSpacing: -0.5,
          ),
        ),
      ]),
    );
  }
}

class _StepBadge extends StatelessWidget {
  const _StepBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: HireIQTheme.primaryNavy,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HireIQTheme.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline_rounded,
              size: 18, color: HireIQTheme.error),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: HireIQTheme.error,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormFields extends StatelessWidget {
  const _FormFields({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
    required this.passwordVisible,
    required this.confirmPasswordVisible,
    required this.passwordStrength,
    required this.agreedToTerms,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
    required this.onToggleTerms,
    required this.isMobile,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;
  final bool passwordVisible;
  final bool confirmPasswordVisible;
  final double passwordStrength;
  final bool agreedToTerms;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;
  final VoidCallback onToggleTerms;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full name
        _InputField(
          controller: nameController,
          label: 'Full name',
          placeholder: 'Thabo Nkosi',
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 20),
        // Email
        _InputField(
          controller: emailController,
          label: 'Email address',
          placeholder: 'thabo@email.com',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        // Password fields
        isMobile
            ? Column(
                children: [
                  _PasswordField(
                    controller: passwordController,
                    label: 'Password',
                    placeholder: 'Min 8 characters',
                    visible: passwordVisible,
                    strength: passwordStrength,
                    onToggle: onTogglePassword,
                  ),
                  const SizedBox(height: 20),
                  _PasswordField(
                    controller: confirmPasswordController,
                    label: 'Confirm Password',
                    placeholder: 'Re-type password',
                    visible: confirmPasswordVisible,
                    strength: null,
                    onToggle: onToggleConfirmPassword,
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: _PasswordField(
                      controller: passwordController,
                      label: 'Password',
                      placeholder: 'Min 8 characters',
                      visible: passwordVisible,
                      strength: passwordStrength,
                      onToggle: onTogglePassword,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _PasswordField(
                      controller: confirmPasswordController,
                      label: 'Confirm Password',
                      placeholder: 'Re-type password',
                      visible: confirmPasswordVisible,
                      strength: null,
                      onToggle: onToggleConfirmPassword,
                    ),
                  ),
                ],
              ),
        const SizedBox(height: 20),
        // Mobile number
        _PhoneField(controller: phoneController),
        const SizedBox(height: 20),
        // Terms checkbox
        GestureDetector(
          onTap: onToggleTerms,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: agreedToTerms
                      ? HireIQTheme.primaryTeal
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: agreedToTerms
                        ? HireIQTheme.primaryTeal
                        : HireIQTheme.borderLight,
                    width: 1.5,
                  ),
                ),
                child: agreedToTerms
                    ? const Icon(Icons.check_rounded,
                        size: 14, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'I agree to HireIQ\'s Terms of Service and Privacy Policy',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: HireIQTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.label,
    required this.placeholder,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final String placeholder;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: HireIQTheme.primaryNavy,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: GoogleFonts.inter(fontSize: 15),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: GoogleFonts.inter(
              fontSize: 15,
              color: HireIQTheme.textMuted,
            ),
            filled: true,
            fillColor: HireIQTheme.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: HireIQTheme.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: HireIQTheme.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: HireIQTheme.primaryTeal, width: 1.5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.controller,
    required this.label,
    required this.placeholder,
    required this.visible,
    required this.strength,
    required this.onToggle,
  });

  final TextEditingController controller;
  final String label;
  final String placeholder;
  final bool visible;
  final double? strength;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: HireIQTheme.primaryNavy,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: !visible,
          style: GoogleFonts.inter(fontSize: 15),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: GoogleFonts.inter(
              fontSize: 15,
              color: HireIQTheme.textMuted,
            ),
            filled: true,
            fillColor: HireIQTheme.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: HireIQTheme.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: HireIQTheme.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: HireIQTheme.primaryTeal, width: 1.5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            suffixIcon: IconButton(
              icon: Icon(
                visible
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                size: 20,
                color: HireIQTheme.textMuted,
              ),
              onPressed: onToggle,
            ),
          ),
        ),
        if (strength != null) ...[
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: strength,
              backgroundColor: HireIQTheme.borderLight,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(HireIQTheme.primaryTeal),
              minHeight: 4,
            ),
          ),
        ],
      ],
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mobile number',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: HireIQTheme.primaryNavy,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 60,
              height: 52,
              decoration: BoxDecoration(
                color: HireIQTheme.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: HireIQTheme.primaryNavy),
              ),
              child: Center(
                child: Text(
                  '+27',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: HireIQTheme.primaryNavy,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.phone,
                style: GoogleFonts.inter(fontSize: 15),
                decoration: InputDecoration(
                  hintText: '71 234 5678',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 15,
                    color: HireIQTheme.textMuted,
                  ),
                  filled: true,
                  fillColor: HireIQTheme.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: HireIQTheme.borderLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: HireIQTheme.borderLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: HireIQTheme.primaryTeal, width: 1.5),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Required for account verification',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: HireIQTheme.textMuted,
          ),
        ),
      ],
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  const _CreateAccountButton({
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF5A623),
          foregroundColor: HireIQTheme.primaryNavy,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: HireIQTheme.primaryNavy,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create My Account',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_forward_rounded, size: 20),
                ],
              ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: HireIQTheme.borderLight)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: HireIQTheme.textMuted,
            ),
          ),
        ),
        const Expanded(child: Divider(color: HireIQTheme.borderLight)),
      ],
    );
  }
}

class _GoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          // TODO: Implement Google sign in
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: HireIQTheme.primaryNavy,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: const BorderSide(color: Color(0xFFE2E8F0)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'G',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF4285F4),
              ),
            ),
            Text(
              'o',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFEA4335),
              ),
            ),
            Text(
              'o',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFFBBC05),
              ),
            ),
            Text(
              'g',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF4285F4),
              ),
            ),
            Text(
              'l',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF34A853),
              ),
            ),
            Text(
              'e',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF4285F4),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Continue with Google',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: HireIQTheme.primaryNavy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _POPIANote extends StatelessWidget {
  const _POPIANote();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.lock_rounded,
          size: 16,
          color: HireIQTheme.textMuted,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Your data is protected under POPIA. We never sell your information.',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: HireIQTheme.textMuted,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: HireIQTheme.primaryTeal,
          ),
          child: const Icon(
            Icons.check_rounded,
            size: 14,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _SignInLink extends StatelessWidget {
  const _SignInLink({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Already have an account? ',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: HireIQTheme.textMuted,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              'Sign in',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: HireIQTheme.primaryTeal,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
