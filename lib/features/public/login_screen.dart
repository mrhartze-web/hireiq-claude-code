import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _isLoading = false;
  bool _isGoogleLoading = false;
  bool _obscurePassword = true;
  String? _error;

  late final AnimationController _entranceController;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _cardFade;
  late final Animation<Offset> _cardSlide;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _headerFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _cardFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.25, 0.9, curve: Curves.easeOut),
    );
    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.25, 0.9, curve: Curves.easeOut),
    ));

    _entranceController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  Future<void> _navigateByRole() async {
    final role = await ref
        .read(authServiceProvider)
        .getUserRole(ref.read(authStateProvider).value?.uid ?? '');
    if (!mounted) return;
    switch (role) {
      case 'employer':
        context.go('/employer');
        break;
      case 'recruiter':
        context.go('/recruiter');
        break;
      case 'admin':
        context.go('/admin');
        break;
      default:
        context.go('/candidate');
    }
  }

  Future<void> _signIn() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      await ref.read(authServiceProvider).signInWithEmail(
            email: _emailController.text,
            password: _passwordController.text,
          );
      if (mounted) await _navigateByRole();
    } catch (_) {
      setState(() => _error = 'Invalid email or password. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isGoogleLoading = true;
      _error = null;
    });
    try {
      await ref.read(authServiceProvider).signInWithGoogle();
      if (mounted) await _navigateByRole();
    } catch (e) {
      if (mounted) {
        final msg = e.toString().contains('cancelled')
            ? null
            : 'Google sign-in failed. Please try again.';
        setState(() => _error = msg);
      }
    } finally {
      if (mounted) setState(() => _isGoogleLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: Stack(
        children: [
          // Subtle top gradient wash
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 260,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    HireIQTheme.primaryNavy.withValues(alpha: 0.06),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  // ── Header ─────────────────────────────────────────────
                  SlideTransition(
                    position: _headerSlide,
                    child: FadeTransition(
                      opacity: _headerFade,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                        child: Column(
                          children: [
                            // Logo mark
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    HireIQTheme.primaryTeal,
                                    HireIQTheme.primaryTeal.withValues(alpha: 0.7),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        HireIQTheme.primaryTeal.withValues(alpha: 0.3),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.bolt_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),

                            const SizedBox(height: 20),

                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Hire',
                                  style: GoogleFonts.inter(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: HireIQTheme.primaryNavy,
                                    letterSpacing: -0.8,
                                  ),
                                ),
                                TextSpan(
                                  text: 'IQ',
                                  style: GoogleFonts.inter(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: HireIQTheme.primaryTeal,
                                    letterSpacing: -0.8,
                                  ),
                                ),
                              ]),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              'Welcome back',
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: HireIQTheme.textPrimary,
                                letterSpacing: -0.4,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              'Sign in to continue to your account',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: HireIQTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Card ───────────────────────────────────────────────
                  SlideTransition(
                    position: _cardSlide,
                    child: FadeTransition(
                      opacity: _cardFade,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: HireIQTheme.primaryNavy.withValues(alpha: 0.07),
                                blurRadius: 32,
                                offset: const Offset(0, 8),
                              ),
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(24),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Error banner
                                if (_error != null) ...[
                                  _ErrorBanner(message: _error!),
                                  const SizedBox(height: 16),
                                ],

                                // Email field
                                const _FieldLabel(label: 'Email address'),
                                const SizedBox(height: 6),
                                _PremiumField(
                                  controller: _emailController,
                                  focusNode: _emailFocus,
                                  nextFocus: _passwordFocus,
                                  hint: 'you@example.com',
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: Icons.mail_outline_rounded,
                                  validator: (v) {
                                    if (v == null || v.trim().isEmpty) {
                                      return 'Email is required';
                                    }
                                    if (!v.contains('@')) {
                                      return 'Enter a valid email';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 18),

                                // Password field
                                const _FieldLabel(label: 'Password'),
                                const SizedBox(height: 6),
                                _PremiumField(
                                  controller: _passwordController,
                                  focusNode: _passwordFocus,
                                  hint: '••••••••',
                                  obscureText: _obscurePassword,
                                  prefixIcon: Icons.lock_outline_rounded,
                                  suffixIcon: _obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  onSuffixTap: () => setState(
                                      () => _obscurePassword = !_obscurePassword),
                                  onSubmitted: (_) => _signIn(),
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 8),

                                // Forgot password
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () =>
                                        context.push('/forgot-password'),
                                    child: Text(
                                      'Forgot password?',
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: HireIQTheme.primaryTeal,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 24),

                                // Sign in button
                                _SignInButton(
                                  isLoading: _isLoading,
                                  onTap: _signIn,
                                ),

                                const SizedBox(height: 20),

                                // Divider
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Divider(
                                        color: HireIQTheme.borderLight,
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Text(
                                        'or continue with',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: HireIQTheme.textMuted,
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      child: Divider(
                                        color: HireIQTheme.borderLight,
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // Google button
                                _GoogleButton(
                                  isLoading: _isGoogleLoading,
                                  onTap: _signInWithGoogle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Sign up link ───────────────────────────────────────
                  FadeTransition(
                    opacity: _cardFade,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?  ",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: HireIQTheme.textMuted,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/signup'),
                          child: Text(
                            'Create account',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: HireIQTheme.primaryNavy,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Reusable sub-widgets ──────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});
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

class _PremiumField extends StatefulWidget {
  const _PremiumField({
    required this.controller,
    required this.focusNode,
    required this.hint,
    required this.prefixIcon,
    this.nextFocus,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.onSubmitted,
    this.validator,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocus;
  final String hint;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;

  @override
  State<_PremiumField> createState() => _PremiumFieldState();
}

class _PremiumFieldState extends State<_PremiumField> {
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() => _focused = widget.focusNode.hasFocus);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _focused
              ? HireIQTheme.primaryTeal
              : HireIQTheme.borderLight,
          width: _focused ? 1.5 : 1.0,
        ),
        boxShadow: _focused
            ? [
                BoxShadow(
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        textInputAction:
            widget.nextFocus != null ? TextInputAction.next : TextInputAction.done,
        onFieldSubmitted: (v) {
          if (widget.nextFocus != null) {
            FocusScope.of(context).requestFocus(widget.nextFocus);
          }
          widget.onSubmitted?.call(v);
        },
        validator: widget.validator,
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: HireIQTheme.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: GoogleFonts.inter(
            fontSize: 15,
            color: HireIQTheme.textLight,
          ),
          prefixIcon: Icon(
            widget.prefixIcon,
            size: 18,
            color: _focused ? HireIQTheme.primaryTeal : HireIQTheme.textLight,
          ),
          suffixIcon: widget.suffixIcon != null
              ? GestureDetector(
                  onTap: widget.onSuffixTap,
                  child: Icon(
                    widget.suffixIcon,
                    size: 18,
                    color: HireIQTheme.textMuted,
                  ),
                )
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          errorStyle: GoogleFonts.inter(
            fontSize: 12,
            color: HireIQTheme.error,
          ),
        ),
      ),
    );
  }
}

class _SignInButton extends StatefulWidget {
  const _SignInButton({required this.isLoading, required this.onTap});
  final bool isLoading;
  final VoidCallback onTap;

  @override
  State<_SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<_SignInButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _press;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _press = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _press, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _press.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _press.forward(),
      onTapUp: (_) {
        _press.reverse();
        if (!widget.isLoading) widget.onTap();
      },
      onTapCancel: () => _press.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF243659),
                HireIQTheme.primaryNavy,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: HireIQTheme.primaryNavy.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: widget.isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Text(
                    'Sign in',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.2,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton({required this.isLoading, required this.onTap});
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: HireIQTheme.borderLight, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: HireIQTheme.textMuted,
                    strokeWidth: 2,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Google 'G' drawn with a custom painter — no asset needed
                    CustomPaint(
                      size: const Size(20, 20),
                      painter: _GoogleGPainter(),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Continue with Google',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: HireIQTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: HireIQTheme.errorLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: HireIQTheme.error.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 16,
            color: HireIQTheme.error,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: HireIQTheme.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Google G painter ──────────────────────────────────────────────────────────

class _GoogleGPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    // Blue arc (top → right-ish)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      -1.1, 1.7, false,
      Paint()
        ..color = const Color(0xFF4285F4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.8
        ..strokeCap = StrokeCap.round,
    );
    // Red arc (top-left)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      -2.7, 1.4, false,
      Paint()
        ..color = const Color(0xFFEA4335)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.8
        ..strokeCap = StrokeCap.round,
    );
    // Yellow arc (bottom-left)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      2.2, 1.1, false,
      Paint()
        ..color = const Color(0xFFFBBC05)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.8
        ..strokeCap = StrokeCap.round,
    );
    // Green arc (bottom-right)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      0.6, 1.0, false,
      Paint()
        ..color = const Color(0xFF34A853)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.8
        ..strokeCap = StrokeCap.round,
    );
    // Horizontal bar of the 'G'
    canvas.drawLine(
      Offset(cx, cy),
      Offset(cx + r, cy),
      Paint()
        ..color = const Color(0xFF4285F4)
        ..strokeWidth = 2.8
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
