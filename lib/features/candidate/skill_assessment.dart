import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/theme.dart';

class SkillAssessmentScreen extends StatefulWidget {
  const SkillAssessmentScreen({super.key});

  @override
  State<SkillAssessmentScreen> createState() => _SkillAssessmentScreenState();
}

class _SkillAssessmentScreenState extends State<SkillAssessmentScreen> {
  final int _currentQuestion = 1;
  final int _totalQuestions = 15;
  final double _timerProgress = 0.7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQTheme.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Header ────────────────────────────────────────────────
            Container(
              color: HireIQTheme.primaryNavy,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'SkillIQ Assessment',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    '$_currentQuestion / $_totalQuestions',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),

            // Timer bar
            ClipRRect(
              child: LinearProgressIndicator(
                value: _timerProgress,
                minHeight: 4,
                backgroundColor: HireIQTheme.borderLight,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  HireIQTheme.primaryTeal,
                ),
              ),
            ),

            // ── Question body ──────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question $_currentQuestion of $_totalQuestions',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: HireIQTheme.textLight,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Which of the following is the most efficient way to manage state in a large-scale Flutter application with complex dependencies?',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: HireIQTheme.primaryNavy,
                        height: 1.45,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const _OptionTile(
                      label: 'A',
                      text: 'setState() exclusively',
                    ),
                    const _OptionTile(
                      label: 'B',
                      text:
                          'Using a combination of Riverpod and immutable data models',
                      isSelected: true,
                    ),
                    const _OptionTile(
                      label: 'C',
                      text: 'Global variables and singletons',
                    ),
                    const _OptionTile(
                      label: 'D',
                      text:
                          'Passing data through the constructor chain (Prop drilling)',
                    ),
                  ],
                ),
              ),
            ),

            // ── Bottom nav ─────────────────────────────────────────────
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: HireIQTheme.surfaceWhite,
                            borderRadius: BorderRadius.circular(
                                HireIQTheme.radiusMd),
                            border: Border.all(
                                color: HireIQTheme.borderLight),
                          ),
                          child: Center(
                            child: Text(
                              'Previous',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: HireIQTheme.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                HireIQTheme.primaryNavy,
                                Color(0xFF243659),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(
                                HireIQTheme.radiusMd),
                            boxShadow: [
                              BoxShadow(
                                color: HireIQTheme.primaryNavy
                                    .withValues(alpha: 0.25),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Next Question',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
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
      ),
    );
  }
}

// ── Option tile ────────────────────────────────────────────────────────────────

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.text,
    this.isSelected = false,
  });

  final String label;
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? HireIQTheme.primaryTeal.withValues(alpha: 0.06)
              : HireIQTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(HireIQTheme.radiusLg),
          border: Border.all(
            color: isSelected
                ? HireIQTheme.primaryTeal.withValues(alpha: 0.5)
                : HireIQTheme.borderLight,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: HireIQTheme.primaryNavy.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected
                    ? HireIQTheme.primaryTeal
                    : HireIQTheme.backgroundLight,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isSelected
                        ? Colors.white
                        : HireIQTheme.textSecondary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: isSelected
                      ? HireIQTheme.primaryNavy
                      : HireIQTheme.textSecondary,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
