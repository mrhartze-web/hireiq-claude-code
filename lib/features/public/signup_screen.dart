import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../providers/auth_provider.dart';
import '../mobile_screens.dart';

// ── Role data ──────────────────────────────────────────────────────────────────

class _RoleOption {
  const _RoleOption({
    required this.key,
    required this.label,
    required this.subtitle,
    required this.accentColor,
    required this.icon,
  });

  final String key;
  final String label;
  final String subtitle;
  final Color accentColor;
  final IconData icon;
}

const _roleOptions = <_RoleOption>[
  _RoleOption(
    key: 'candidate',
    label: 'Candidate',
    subtitle: 'Looking for work',
    accentColor: HireIQTheme.primaryTeal,
    icon: Icons.person_search_rounded,
  ),
  _RoleOption(
    key: 'employer',
    label: 'Employer',
    subtitle: 'Hiring talent',
    accentColor: HireIQTheme.primaryNavy,
    icon: Icons.apartment_rounded,
  ),
  _RoleOption(
    key: 'recruiter',
    label: 'Recruiter',
    subtitle: 'Placing candidates',
    accentColor: Color(0xFFF5A623),
    icon: Icons.work_rounded,
  ),
];

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
  bool _passwordVisible = false;
  late String _selectedRole;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    const validRoles = {'candidate', 'employer', 'recruiter'};
    final incoming = widget.initialRole;
    _selectedRole =
        (incoming != null && validRoles.contains(incoming)) ? incoming : 'candidate';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      setState(() => _error = 'Please fill in all fields to continue.');
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top navy header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 28),
            color: HireIQTheme.primaryNavy,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _WordMark(fontSize: 22),
                const SizedBox(height: 16),
                Text(
                  'Create your account',
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.6,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "South Africa's trust layer for work.",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ),
          // Form body
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _StepBadge(label: 'Step 2 of 2'),
                const SizedBox(height: 20),
                Text(
                  'Your details',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.primaryNavy,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Free to join. No credit card required.',
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
                  passwordVisible: _passwordVisible,
                  onTogglePassword: () =>
                      setState(() => _passwordVisible = !_passwordVisible),
                ),
                const SizedBox(height: 24),
                Text(
                  'Joining as',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: HireIQTheme.primaryNavy,
                  ),
                ),
                const SizedBox(height: 10),
                ..._roleOptions.map(
                  (r) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _RoleOptionTile(
                      option: r,
                      isSelected: _selectedRole == r.key,
                      onTap: () => setState(() => _selectedRole = r.key),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                _CreateAccountButton(
                  isLoading: _isLoading,
                  onPressed: _signUp,
                ),
                const SizedBox(height: 20),
                _SignInLink(onTap: () => context.go('/login')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Desktop layout ───────────────────────────────────────────────────────────

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Left panel — 42%
        Expanded(
          flex: 42,
          child: Container(
            color: HireIQTheme.primaryNavy,
            padding: const EdgeInsets.fromLTRB(48, 56, 48, 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _WordMark(fontSize: 24),
                const SizedBox(height: 48),
                Text(
                  'Build your career on solid ground.',
                  style: GoogleFonts.inter(
                    fontSize: 38,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -1,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "South Africa's trust and matching infrastructure for work — built for candidates, employers, and recruiters who expect results.",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    color: Colors.white.withValues(alpha: 0.80),
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 40),
                const _BenefitRow(text: 'Verified identity employers trust'),
                const SizedBox(height: 20),
                const _BenefitRow(
                    text: 'AI-matched to roles where you qualify'),
                const SizedBox(height: 20),
                const _BenefitRow(
                    text: 'Credentials and badges you own for life'),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      'Already have an account? ',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.70),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go('/login'),
                      child: Text(
                        'Sign in →',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Right panel — 58%
        Expanded(
          flex: 58,
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(56, 48, 56, 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _StepBadge(label: 'Step 2 of 2'),
                  const SizedBox(height: 28),
                  Text(
                    'Create your account',
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: HireIQTheme.primaryNavy,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Free to join. No credit card required.',
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
                    passwordVisible: _passwordVisible,
                    onTogglePassword: () =>
                        setState(() => _passwordVisible = !_passwordVisible),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Joining as',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: HireIQTheme.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: _roleOptions
                        .map(
                          (r) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: r.key != 'recruiter' ? 10 : 0,
                              ),
                              child: _RoleOptionTile(
                                option: r,
                                isSelected: _selectedRole == r.key,
                                onTap: () =>
                                    setState(() => _selectedRole = r.key),
                                compact: true,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 32),
                  _CreateAccountButton(
                    isLoading: _isLoading,
                    onPressed: _signUp,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'By creating an account you agree to our Terms of Service and Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: HireIQTheme.textMuted,
                        height: 1.5,
                      ),
                    ),
                  ),
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
        color: HireIQTheme.errorLight,
        borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
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
    required this.passwordVisible,
    required this.onTogglePassword,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool passwordVisible;
  final VoidCallback onTogglePassword;

  InputDecoration _inputDecoration(String label, {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        color: HireIQTheme.textMuted,
      ),
      floatingLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        color: HireIQTheme.primaryTeal,
        fontWeight: FontWeight.w600,
      ),
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
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      suffixIcon: suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: nameController,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          style: GoogleFonts.inter(fontSize: 15),
          decoration: _inputDecoration('Full name'),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: GoogleFonts.inter(fontSize: 15),
          decoration: _inputDecoration('Email address'),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          obscureText: !passwordVisible,
          style: GoogleFonts.inter(fontSize: 15),
          decoration: _inputDecoration(
            'Password',
            suffix: IconButton(
              icon: Icon(
                passwordVisible
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                size: 20,
                color: HireIQTheme.textMuted,
              ),
              onPressed: onTogglePassword,
            ),
          ),
        ),
      ],
    );
  }
}

class _RoleOptionTile extends StatelessWidget {
  const _RoleOptionTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
    this.compact = false,
  });

  final _RoleOption option;
  final bool isSelected;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.all(compact ? 14 : 16),
        decoration: BoxDecoration(
          color: isSelected
              ? option.accentColor.withValues(alpha: 0.07)
              : Colors.white,
          borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
          border: Border.all(
            color: isSelected ? option.accentColor : HireIQTheme.borderLight,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: compact
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(option.icon,
                          size: 18,
                          color: isSelected
                              ? option.accentColor
                              : HireIQTheme.textMuted),
                      const Spacer(),
                      if (isSelected)
                        Icon(Icons.check_circle_rounded,
                            size: 18, color: option.accentColor),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    option.label,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? option.accentColor
                          : HireIQTheme.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    option.subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: HireIQTheme.textMuted,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? option.accentColor
                          : option.accentColor.withValues(alpha: 0.10),
                    ),
                    child: Icon(
                      option.icon,
                      size: 20,
                      color: isSelected ? Colors.white : option.accentColor,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option.label,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: HireIQTheme.primaryNavy,
                          ),
                        ),
                        Text(
                          option.subtitle,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: HireIQTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(Icons.check_circle_rounded,
                        size: 22, color: option.accentColor),
                ],
              ),
      ),
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
          backgroundColor: HireIQTheme.amber,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(HireIQTheme.radiusMd),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create account',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, size: 20),
                ],
              ),
      ),
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
