import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/auth_provider.dart';
import '../navigation/role_navigation_bar.dart';
import '../theme.dart';

class AdminModeBar extends ConsumerWidget {
  const AdminModeBar({super.key, required this.currentSection});

  final UserRole currentSection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cachedRole = ref.watch(cachedRoleProvider);
    if (cachedRole != 'admin') return const SizedBox.shrink();

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF0F1F38).withValues(alpha: 0.88),
            border: const Border(
              top: BorderSide(color: Color(0xFF0D9488), width: 1),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // Shield icon + label
              const Icon(
                Icons.shield_rounded,
                size: 13,
                color: Color(0xFF0D9488),
              ),
              const SizedBox(width: 6),
              Text(
                'Admin QC Mode',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.75),
                  letterSpacing: 0.4,
                ),
              ),

              const Spacer(),

              // Role pills
              _QcPill(
                label: 'C',
                color: HireIQTheme.primaryTeal,
                isActive: currentSection == UserRole.candidate,
                onTap: () => context.go('/candidate'),
              ),
              const SizedBox(width: 6),
              _QcPill(
                label: 'E',
                color: HireIQTheme.primaryNavy,
                isActive: currentSection == UserRole.employer,
                onTap: () => context.go('/employer'),
              ),
              const SizedBox(width: 6),
              _QcPill(
                label: 'R',
                color: HireIQTheme.recruiterAccent,
                isActive: currentSection == UserRole.recruiter,
                onTap: () => context.go('/recruiter'),
              ),
              const SizedBox(width: 6),
              _QcPill(
                label: 'A',
                color: const Color(0xFFEF4444),
                isActive: currentSection == UserRole.admin,
                onTap: () => context.go('/admin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── QC Pill ────────────────────────────────────────────────────────────────────

class _QcPill extends StatelessWidget {
  const _QcPill({
    required this.label,
    required this.color,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final Color color;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: isActive ? color : color.withValues(alpha: 0.28),
          borderRadius: BorderRadius.circular(14),
          border: isActive
              ? Border.all(color: Colors.white, width: 1.5)
              : Border.all(color: color.withValues(alpha: 0.4), width: 1),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Colors.white.withValues(alpha: isActive ? 1.0 : 0.55),
          ),
        ),
      ),
    );
  }
}
