import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/auth_provider.dart';
import '../../shared/theme.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen>
    with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _emailFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _sent = false;
  String? _error;
  bool _focused = false;

  // Entrance animation
  late final AnimationController _entranceCtrl;
  late final Animation<double> _entranceFade;
  late final Animation<Offset> _entranceSlide;

  // State-switch (input ↔ success)
  late final AnimationController _switchCtrl;

  // Checkmark draw animation
  late final AnimationController _checkCtrl;
  late final Animation<double> _checkDraw;
  late final Animation<double> _checkCircle;
  late final Animation<double> _checkBounce;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    _emailFocus.addListener(() {
      setState(() => _focused = _emailFocus.hasFocus);
    });

    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _entranceFade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    );
    _entranceSlide = Tween<Offset>(
      begin: const Offset(0, 0.07),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    ));

    _switchCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _checkCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _checkCircle = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _checkCtrl,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
      ),
    );
    _checkDraw = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _checkCtrl,
        curve: const Interval(0.4, 0.85, curve: Curves.easeOut),
      ),
    );
    _checkBounce = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _checkCtrl,
        curve: const Interval(0.5, 1.0, curve: Curves.elasticOut),
      ),
    );

    _entranceCtrl.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    _entranceCtrl.dispose();
    _switchCtrl.dispose();
    _checkCtrl.dispose();
    super.dispose();
  }

  Future<void> _sendReset() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      await ref
          .read(authServiceProvider)
          .sendPasswordResetEmail(_emailController.text.trim());
      if (!mounted) return;
      // Fade out form, then play check animation
      await _switchCtrl.forward();
      setState(() => _sent = true);
      _checkCtrl.forward();
    } catch (_) {
      if (mounted) {
        setState(() =>
            _error = 'Could not send reset email. Check the address and try again.');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: Stack(
        children: [
          // Subtle top wash
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 200,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    HireIQTheme.primaryNavy.withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back arrow
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: _BackButton(onTap: () => context.pop()),
                ),

                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (child, anim) => FadeTransition(
                      opacity: anim,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.04),
                          end: Offset.zero,
                        ).animate(anim),
                        child: child,
                      ),
                    ),
                    child: _sent
                        ? _SuccessView(
                            key: const ValueKey('success'),
                            checkCtrl: _checkCtrl,
                            checkCircle: _checkCircle,
                            checkDraw: _checkDraw,
                            checkBounce: _checkBounce,
                            onBackToLogin: () => context.go('/login'),
                          )
                        : _InputView(
                            key: const ValueKey('input'),
                            emailController: _emailController,
                            emailFocus: _emailFocus,
                            formKey: _formKey,
                            focused: _focused,
                            isLoading: _isLoading,
                            error: _error,
                            entranceFade: _entranceFade,
                            entranceSlide: _entranceSlide,
                            onSend: _sendReset,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Back button ───────────────────────────────────────────────────────────────

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: HireIQTheme.surfaceWhite,
          shape: BoxShape.circle,
          border: Border.all(color: HireIQTheme.borderLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_back_rounded,
          size: 20,
          color: HireIQTheme.textPrimary,
        ),
      ),
    );
  }
}

// ── Input view ────────────────────────────────────────────────────────────────

class _InputView extends StatelessWidget {
  const _InputView({
    super.key,
    required this.emailController,
    required this.emailFocus,
    required this.formKey,
    required this.focused,
    required this.isLoading,
    required this.error,
    required this.entranceFade,
    required this.entranceSlide,
    required this.onSend,
  });

  final TextEditingController emailController;
  final FocusNode emailFocus;
  final GlobalKey<FormState> formKey;
  final bool focused;
  final bool isLoading;
  final String? error;
  final Animation<double> entranceFade;
  final Animation<Offset> entranceSlide;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: FadeTransition(
          opacity: entranceFade,
          child: SlideTransition(
            position: entranceSlide,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),

                // Bolt icon mark
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        HireIQTheme.primaryNavy,
                        HireIQTheme.primaryNavy.withValues(alpha: 0.75),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: HireIQTheme.primaryNavy.withValues(alpha: 0.28),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.bolt_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 28),

                // Heading
                Text(
                  'Reset your password',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.textPrimary,
                    letterSpacing: -0.6,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 10),

                // Subtitle
                Text(
                  'Enter your email and we will send you\na reset link.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: HireIQTheme.textMuted,
                    height: 1.55,
                  ),
                ),

                const SizedBox(height: 36),

                // Card
                Container(
                  decoration: BoxDecoration(
                    color: HireIQTheme.surfaceWhite,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: HireIQTheme.primaryNavy.withValues(alpha: 0.07),
                        blurRadius: 28,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Error banner
                        if (error != null) ...[
                          _ErrorBanner(message: error!),
                          const SizedBox(height: 16),
                        ],

                        // Field label
                        Text(
                          'Email address',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: HireIQTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Email field
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: focused
                                  ? HireIQTheme.primaryTeal
                                  : HireIQTheme.borderLight,
                              width: focused ? 1.5 : 1.0,
                            ),
                            boxShadow: focused
                                ? [
                                    BoxShadow(
                                      color: HireIQTheme.primaryTeal
                                          .withValues(alpha: 0.12),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : [],
                          ),
                          child: TextFormField(
                            controller: emailController,
                            focusNode: emailFocus,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => onSend(),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Email is required';
                              }
                              if (!v.contains('@')) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: HireIQTheme.textPrimary,
                            ),
                            decoration: InputDecoration(
                              hintText: 'you@example.com',
                              hintStyle: GoogleFonts.inter(
                                fontSize: 15,
                                color: HireIQTheme.textLight,
                              ),
                              prefixIcon: Icon(
                                Icons.mail_outline_rounded,
                                size: 18,
                                color: focused
                                    ? HireIQTheme.primaryTeal
                                    : HireIQTheme.textLight,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 14),
                              errorStyle: GoogleFonts.inter(
                                fontSize: 12,
                                color: HireIQTheme.error,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Send button
                        _SendButton(
                          isLoading: isLoading,
                          onTap: onSend,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Back to login text link
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_back_rounded,
                        size: 14,
                        color: HireIQTheme.textMuted,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Back to sign in',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: HireIQTheme.textMuted,
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
      ),
    );
  }
}

// ── Success view ──────────────────────────────────────────────────────────────

class _SuccessView extends StatelessWidget {
  const _SuccessView({
    super.key,
    required this.checkCtrl,
    required this.checkCircle,
    required this.checkDraw,
    required this.checkBounce,
    required this.onBackToLogin,
  });

  final AnimationController checkCtrl;
  final Animation<double> checkCircle;
  final Animation<double> checkDraw;
  final Animation<double> checkBounce;
  final VoidCallback onBackToLogin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),

          // Animated checkmark
          AnimatedBuilder(
            animation: checkCtrl,
            builder: (_, __) => Transform.scale(
              scale: checkBounce.value,
              child: SizedBox(
                width: 120,
                height: 120,
                child: CustomPaint(
                  painter: _CheckPainter(
                    circleProgress: checkCircle.value,
                    checkProgress: checkDraw.value,
                    color: HireIQTheme.primaryTeal,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 36),

          Text(
            'Email sent',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: HireIQTheme.textPrimary,
              letterSpacing: -0.6,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Check your inbox for the reset link.\nIt may take a minute to arrive.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: HireIQTheme.textMuted,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 40),

          _BackToLoginButton(onTap: onBackToLogin),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ── Send button ───────────────────────────────────────────────────────────────

class _SendButton extends StatefulWidget {
  const _SendButton({required this.isLoading, required this.onTap});
  final bool isLoading;
  final VoidCallback onTap;

  @override
  State<_SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<_SendButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _press;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _press = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
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
              colors: [Color(0xFF243659), HireIQTheme.primaryNavy],
            ),
            boxShadow: [
              BoxShadow(
                color: HireIQTheme.primaryNavy.withValues(alpha: 0.32),
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
                    'Send Reset Link',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.1,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

// ── Back to login button ──────────────────────────────────────────────────────

class _BackToLoginButton extends StatefulWidget {
  const _BackToLoginButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_BackToLoginButton> createState() => _BackToLoginButtonState();
}

class _BackToLoginButtonState extends State<_BackToLoginButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _press;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _press = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
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
        widget.onTap();
      },
      onTapCancel: () => _press.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: HireIQTheme.surfaceWhite,
            border: Border.all(color: HireIQTheme.borderLight, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.arrow_back_rounded,
                size: 17,
                color: HireIQTheme.textPrimary,
              ),
              const SizedBox(width: 8),
              Text(
                'Back to Login',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
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

// ── Error banner ──────────────────────────────────────────────────────────────

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
                fontWeight: FontWeight.w500,
                color: HireIQTheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Checkmark painter ─────────────────────────────────────────────────────────

class _CheckPainter extends CustomPainter {
  const _CheckPainter({
    required this.circleProgress,
    required this.checkProgress,
    required this.color,
  });

  final double circleProgress;
  final double checkProgress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background fill that grows with circleProgress
    if (circleProgress > 0) {
      canvas.drawCircle(
        center,
        radius,
        Paint()..color = color.withValues(alpha: 0.1 * circleProgress),
      );
    }

    // Stroke ring drawn as an arc
    if (circleProgress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - 4),
        -math.pi / 2,
        2 * math.pi * circleProgress,
        false,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.5
          ..strokeCap = StrokeCap.round,
      );
    }

    // Checkmark tick
    if (checkProgress > 0) {
      // Tick path: down-left leg then up-right leg
      final p1 = Offset(size.width * 0.26, size.height * 0.52);
      final p2 = Offset(size.width * 0.44, size.height * 0.68);
      final p3 = Offset(size.width * 0.74, size.height * 0.34);

      final totalLen =
          (p2 - p1).distance + (p3 - p2).distance;
      final drawn = totalLen * checkProgress;
      final leg1Len = (p2 - p1).distance;

      final path = Path()..moveTo(p1.dx, p1.dy);

      if (drawn <= leg1Len) {
        final t = drawn / leg1Len;
        path.lineTo(
          p1.dx + (p2.dx - p1.dx) * t,
          p1.dy + (p2.dy - p1.dy) * t,
        );
      } else {
        path.lineTo(p2.dx, p2.dy);
        final remaining = drawn - leg1Len;
        final leg2Len = (p3 - p2).distance;
        final t = (remaining / leg2Len).clamp(0.0, 1.0);
        path.lineTo(
          p2.dx + (p3.dx - p2.dx) * t,
          p2.dy + (p3.dy - p2.dy) * t,
        );
      }

      canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4.5
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
    }
  }

  @override
  bool shouldRepaint(_CheckPainter old) =>
      old.circleProgress != circleProgress ||
      old.checkProgress != checkProgress;
}
