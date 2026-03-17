import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HireIQTheme {
  // ── Primary Brand ──────────────────────────────────────────────────────
  static const Color primaryNavy = Color(0xFF1A2B4A);
  static const Color primaryTeal = Color(0xFF0D9488);
  static const Color amber = Color(0xFFF5A623);

  // ── Aliases ────────────────────────────────────────────────────────────
  static const Color secondaryTeal = primaryTeal;
  static const Color secondaryOrange = amber;
  static const Color accentAmber = amber;
  static const Color brandNavy = primaryNavy;
  static const Color brandTeal = primaryTeal;

  // ── Short aliases used by older generated screens ─────────────────────
  static const Color primary = primaryNavy;
  static const Color accent = primaryTeal;
  static const Color surface = surfaceWhite;
  static const Color border = borderLight;

  // ── Surface & Background ───────────────────────────────────────────────
  static const Color background = Color(0xFFF8FAFC);
  static const Color backgroundLight = Color(0xFFF1F5F9);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color surfaceGrey = Color(0xFFF8FAFC);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // ── Text ───────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textLight = Color(0xFF94A3B8);
  static const Color textWhite = Color(0xFFFFFFFF);

  // ── Status ─────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF22C55E);
  static const Color successLight = Color(0xFFDCFCE7);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFEFF6FF);

  // ── Border ─────────────────────────────────────────────────────────────
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderMedium = Color(0xFFCBD5E1);
  static const Color divider = Color(0xFFE2E8F0);

  // ── Role Accents ───────────────────────────────────────────────────────
  static const Color candidateAccent = primaryTeal;
  static const Color employerAccent = primaryNavy;
  static const Color recruiterAccent = Color(0xFF7C3AED);
  static const Color adminAccent = Color(0xFFDC2626);

  // ── Shimmer ────────────────────────────────────────────────────────────
  static const Color shimmerBase = Color(0xFFE2E8F0);
  static const Color shimmerHighlight = Color(0xFFF8FAFC);

  // ── Spacing ────────────────────────────────────────────────────────────
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;

  // ── Border Radius ──────────────────────────────────────────────────────
  static const double radiusSm = 6.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  // ── Elevation ──────────────────────────────────────────────────────────
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 8.0;

  // ── Text Style Getters used by older generated screens ─────────────────
  static TextStyle get titleStyle => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      );

  static TextStyle get subtitleStyle => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textMuted,
      );

  static TextStyle get bodyStyle => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textPrimary,
      );

  // ── Theme Data ─────────────────────────────────────────────────────────
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      primaryColor: primaryNavy,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryNavy,
        primary: primaryNavy,
        secondary: primaryTeal,
        surface: surfaceWhite,
        error: error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimary,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.inter(
            fontSize: 32, fontWeight: FontWeight.bold, color: textPrimary),
        displayMedium: GoogleFonts.inter(
            fontSize: 28, fontWeight: FontWeight.bold, color: textPrimary),
        displaySmall: GoogleFonts.inter(
            fontSize: 24, fontWeight: FontWeight.bold, color: textPrimary),
        headlineMedium: GoogleFonts.inter(
            fontSize: 20, fontWeight: FontWeight.w600, color: textPrimary),
        titleLarge: GoogleFonts.inter(
            fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary),
        bodyLarge: GoogleFonts.inter(
            fontSize: 16, fontWeight: FontWeight.normal, color: textPrimary),
        bodyMedium: GoogleFonts.inter(
            fontSize: 14, fontWeight: FontWeight.normal, color: textPrimary),
        labelLarge: GoogleFonts.inter(
            fontSize: 14, fontWeight: FontWeight.w500, color: textPrimary),
        bodySmall: GoogleFonts.inter(
            fontSize: 12, fontWeight: FontWeight.normal, color: textMuted),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceWhite,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primaryNavy),
        titleTextStyle: TextStyle(
            color: textPrimary, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      dividerTheme: const DividerThemeData(
          color: borderLight, thickness: 1, space: 1),
      cardTheme: CardThemeData(
        color: surfaceWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: borderLight),
        ),
      ),
    );
  }
}
