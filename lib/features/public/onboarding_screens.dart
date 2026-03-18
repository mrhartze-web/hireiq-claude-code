import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';

// ── Data ──────────────────────────────────────────────────────────────────────

class _Slide {
  const _Slide({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.bgColor,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Color bgColor;
}

const _slides = [
  _Slide(
    icon: Icons.bolt_rounded,
    iconColor: HireIQTheme.primaryTeal,
    title: 'Intelligence that finds\ntalent others miss.',
    subtitle:
        'HireIQ uses AI to match candidates and employers with unmatched precision — faster, fairer, smarter.',
    bgColor: Color(0xFFECFDF5),
  ),
  _Slide(
    icon: Icons.people_alt_rounded,
    iconColor: Color(0xFF7C3AED),
    title: 'Built for every side\nof the hire.',
    subtitle:
        'Whether you\'re a candidate, employer, or recruiter — HireIQ gives you the tools to move faster and win.',
    bgColor: Color(0xFFF5F3FF),
  ),
  _Slide(
    icon: Icons.verified_rounded,
    iconColor: HireIQTheme.primaryNavy,
    title: 'Your profile.\nYour passport.',
    subtitle:
        'Build a verified career passport, showcase real skills, and let opportunities come to you.',
    bgColor: Color(0xFFEFF6FF),
  ),
];

// ── Screen ────────────────────────────────────────────────────────────────────

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

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
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/role-selection');
    }
  }

  void _skip() => context.go('/role-selection');

  @override
  Widget build(BuildContext context) {
    final isLast = _currentPage == _slides.length - 1;

    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ───────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo wordmark
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Hire',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: HireIQTheme.primaryNavy,
                          letterSpacing: -0.5,
                        ),
                      ),
                      TextSpan(
                        text: 'IQ',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: HireIQTheme.primaryTeal,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ]),
                  ),

                  // Skip button
                  TextButton(
                    onPressed: _skip,
                    style: TextButton.styleFrom(
                      foregroundColor: HireIQTheme.textMuted,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                    ),
                    child: Text(
                      'Skip',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── PageView ──────────────────────────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, index) =>
                    _SlideView(slide: _slides[index]),
              ),
            ),

            // ── Bottom controls (always visible) ──────────────────────────────
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  // Dot indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == i ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == i
                              ? HireIQTheme.primaryTeal
                              : HireIQTheme.borderLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Action button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isLast
                            ? HireIQTheme.primaryTeal
                            : HireIQTheme.primaryNavy,
                        foregroundColor: Colors.white,
                        elevation: isLast ? 4 : 0,
                        shadowColor: isLast
                            ? HireIQTheme.primaryTeal.withValues(alpha: 0.4)
                            : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(HireIQTheme.radiusMd),
                        ),
                      ),
                      child: Text(
                        isLast ? 'Get Started' : 'Next',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Slide view ────────────────────────────────────────────────────────────────

class _SlideView extends StatelessWidget {
  const _SlideView({required this.slide});

  final _Slide slide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon container
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: slide.bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              slide.icon,
              size: 56,
              color: slide.iconColor,
            ),
          ),

          const SizedBox(height: 40),

          // Title
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: HireIQTheme.primaryNavy,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 16),

          // Subtitle
          Text(
            slide.subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: HireIQTheme.textMuted,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
