import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/theme.dart';

// ── Role data ─────────────────────────────────────────────────────────────────

class _Role {
  const _Role({
    required this.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.badge,
    required this.accentColor,
    required this.iconBg,
    this.subNote,
  });

  final String key;
  final IconData icon;
  final String title;
  final String description;
  final String badge;
  final Color accentColor;
  final Color iconBg;
  final String? subNote;
}

const _roles = <_Role>[
  _Role(
    key: 'candidate',
    icon: Icons.person_search_rounded,
    title: 'I am looking for work',
    description:
        'Find permanent roles, freelance contracts, and gig work — all in one place. AI-matched to your skills.',
    badge: 'Free to join',
    accentColor: HireIQTheme.primaryTeal,
    iconBg: HireIQTheme.primaryTeal,
  ),
  _Role(
    key: 'employer',
    icon: Icons.apartment_rounded,
    title: 'I am hiring talent',
    description:
        'Post roles, receive a MatchIQ-ranked shortlist, and hire with confidence.',
    badge: 'From R799/month',
    accentColor: HireIQTheme.primaryNavy,
    iconBg: HireIQTheme.primaryNavy,
    subNote: '7-day money back guarantee',
  ),
  _Role(
    key: 'recruiter',
    icon: Icons.work_rounded,
    title: 'I am a recruiter',
    description:
        'Place candidates, track placements, and keep 80% of every fee you earn.',
    badge: 'First placement free',
    accentColor: Color(0xFFF5A623),
    iconBg: Color(0xFFF5A623),
  ),
];

// ── Screen ────────────────────────────────────────────────────────────────────

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = 'candidate';

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  void _selectRole(String role) {
    HapticFeedback.selectionClick();
    setState(() => _selectedRole = role);
  }

  void _continue() {
    if (_selectedRole != null) {
      context.go('/signup', extra: {'role': _selectedRole});
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
          } else {
            return _buildDesktopLayout();
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Left column (top on mobile)
        Expanded(
          flex: 0,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
            color: HireIQTheme.primaryNavy,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Wordmark
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Hire',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    TextSpan(
                      text: 'IQ',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: HireIQTheme.primaryTeal,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 24),
                // Headline
                Text(
                  'Your next opportunity starts here.',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.8,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right column (bottom on mobile)
        Expanded(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Step indicator
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryNavy,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Step 1 of 2',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Headline
                Text(
                  'I am joining as a...',
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.primaryNavy,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Choose your role to get the right experience.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: HireIQTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 20),
                // Role cards
                Expanded(
                  child: ListView.separated(
                    itemCount: _roles.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final role = _roles[index];
                      return _RoleCard(
                        role: role,
                        isSelected: _selectedRole == role.key,
                        onTap: () => _selectRole(role.key),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Continue button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _continue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5A623),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue',
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

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
                // Wordmark
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Hire',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    TextSpan(
                      text: 'IQ',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: HireIQTheme.primaryTeal,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 48),
                // Headline
                Text(
                  'Your next opportunity starts here.',
                  style: GoogleFonts.inter(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -1,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 16),
                // Subtext
                Text(
                  "South Africa's AI-powered recruitment operating system. Built for candidates, employers, and recruiters who expect more.",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: Colors.white.withValues(alpha: 0.8),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                // Benefit rows
                const _BenefitRow(
                  text:
                      'Permanent, contract, and gig opportunities in one place',
                ),
                const SizedBox(height: 20),
                const _BenefitRow(text: 'Verified identity employers trust'),
                const SizedBox(height: 20),
                const _BenefitRow(text: 'Credentials and badges you own for life'),
                const Spacer(),
                // Bottom sign in link
                Row(
                  children: [
                    Text(
                      'Already have an account? ',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.7),
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
        // Right column — 55%
        Expanded(
          flex: 55,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(48, 48, 48, 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Step indicator
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: HireIQTheme.primaryNavy,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Step 1 of 2',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Headline
                Text(
                  'I am joining as a...',
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: HireIQTheme.primaryNavy,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                // Subtext
                Text(
                  'Choose your role to get the right experience.',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: HireIQTheme.textMuted,
                  ),
                ),
                const SizedBox(height: 32),
                // Role cards
                Expanded(
                  child: ListView.separated(
                    itemCount: _roles.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final role = _roles[index];
                      return _RoleCard(
                        role: role,
                        isSelected: _selectedRole == role.key,
                        onTap: () => _selectRole(role.key),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                // Continue button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _continue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5A623),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_forward_rounded, size: 22),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Benefit row ──────────────────────────────────────────────────────────────

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

// ── Role card ─────────────────────────────────────────────────────────────────

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.role,
    required this.isSelected,
    required this.onTap,
  });

  final _Role role;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isCandidate = role.key == 'candidate';

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? role.accentColor.withValues(alpha: 0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? role.accentColor : HireIQTheme.borderLight,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Icon circle
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: role.iconBg,
              ),
              child: Icon(
                role.icon,
                size: 26,
                color: isCandidate ? Colors.white : Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role.title,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: HireIQTheme.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    role.description,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: HireIQTheme.textMuted,
                      height: 1.45,
                    ),
                  ),
                  if (role.subNote != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      role.subNote!,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: HireIQTheme.primaryTeal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF5A623),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                role.badge,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
