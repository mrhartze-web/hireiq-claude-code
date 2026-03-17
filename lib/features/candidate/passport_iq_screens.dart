import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

// ── PassportIQ Processing ──────────────────────────────────────────────────────

class PassportIQProcessingScreen extends StatefulWidget {
  const PassportIQProcessingScreen({super.key});

  @override
  State<PassportIQProcessingScreen> createState() =>
      _PassportIQProcessingScreenState();
}

class _PassportIQProcessingScreenState
    extends State<PassportIQProcessingScreen> {
  double progress = 0.55;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) context.go('/candidate/passport/result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.primaryNavy,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 40, 28, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Shield icon with glow
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: HireIQTheme.primaryTeal.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: HireIQTheme.primaryTeal.withValues(alpha: 0.3),
                      blurRadius: 32,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  color: HireIQTheme.primaryTeal,
                  size: 48,
                ),
              ),

              const SizedBox(height: 36),

              Text(
                'PassportIQ is verifying\nyour identity',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                  height: 1.25,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                'Securely checking your South African ID against government records...',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: Colors.white.withValues(alpha: 0.65),
                  height: 1.55,
                ),
              ),

              const SizedBox(height: 48),

              // Progress bar
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(HireIQTheme.radiusFull),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: Colors.white.withValues(alpha: 0.15),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    HireIQTheme.primaryTeal,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${(progress * 100).toInt()}% complete',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: HireIQTheme.primaryTeal,
                ),
              ),

              const Spacer(),

              // Security info card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.07),
                  borderRadius:
                      BorderRadius.circular(HireIQTheme.radiusLg),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.lock_outline_rounded,
                          color: HireIQTheme.primaryTeal,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Bank-grade encryption',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Your ID data is encrypted end-to-end and never stored on HireIQ servers after verification.',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.6),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Verification takes 15–60 seconds',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: HireIQTheme.primaryTeal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── PassportIQ Result ──────────────────────────────────────────────────────────

class PassportIQResultScreen extends StatelessWidget {
  const PassportIQResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
              onPressed: () => context.go('/candidate/profile'),
            ),
            title: Text(
              'PassportIQ Result',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 36, 20, 48),
              child: Column(
                children: [
                  // Success icon
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: HireIQTheme.success.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      color: HireIQTheme.success,
                      size: 52,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Identity verified ✓',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: HireIQTheme.primaryNavy,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your PassportIQ badge is now active on your profile.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: HireIQTheme.textMuted,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Badge card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          HireIQTheme.primaryNavy,
                          Color(0xFF243659),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.circular(HireIQTheme.radiusXl),
                      boxShadow: [
                        BoxShadow(
                          color: HireIQTheme.primaryNavy
                              .withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.verified_rounded,
                          color: HireIQTheme.amber,
                          size: 56,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PassportIQ Verified',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Thabo Nkosi',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white
                                    .withValues(alpha: 0.8),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Verified 8 March 2026',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: Colors.white
                                    .withValues(alpha: 0.55),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Unlocks section
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'What your badge unlocks',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  const _UnlockItem(
                    icon: Icons.star_outline_rounded,
                    title: 'Priority in employer search results',
                    subtitle:
                        'Verified profiles appear 3× more in shortlists',
                  ),
                  const _UnlockItem(
                    icon: Icons.bolt_rounded,
                    title: 'Smart Apply eligibility',
                    subtitle:
                        'Apply instantly without manual ID checks',
                  ),
                  const _UnlockItem(
                    icon: Icons.verified_user_outlined,
                    title: 'ShieldIQ fraud protection',
                    subtitle:
                        'Employers know your identity is confirmed',
                  ),
                  const _UnlockItem(
                    icon: Icons.trending_up_rounded,
                    title: 'MatchIQ score boost',
                    subtitle:
                        'Verified candidates receive a +5 MatchIQ bonus',
                    isLast: true,
                  ),

                  const SizedBox(height: 32),

                  GestureDetector(
                    onTap: () => context.go('/candidate/profile'),
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            HireIQTheme.primaryNavy,
                            Color(0xFF243659),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius:
                            BorderRadius.circular(HireIQTheme.radiusMd),
                        boxShadow: [
                          BoxShadow(
                            color: HireIQTheme.primaryNavy
                                .withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Back to Profile',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
}

// ── Unlock item ────────────────────────────────────────────────────────────────

class _UnlockItem extends StatelessWidget {
  const _UnlockItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: HireIQTheme.primaryTeal.withValues(alpha: 0.1),
              borderRadius:
                  BorderRadius.circular(HireIQTheme.radiusSm),
            ),
            child: Icon(icon, color: HireIQTheme.primaryTeal, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: HireIQTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: HireIQTheme.textMuted,
                    height: 1.4,
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
