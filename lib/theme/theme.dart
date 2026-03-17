import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HireIQColors {
  static const navy = Color(0xFF1A2B4A);
  static const teal = Color(0xFF0D9488);
  static const tealLight = Color(0xFF14B8A6);
  static const background = Color(0xFFF8FAFC);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF1E293B);
  static const textMuted = Color(0xFF64748B);
  static const silver = Color(0xFFE2E8F0);
  static const success = Color(0xFF065F46);
  static const successBg = Color(0xFFECFDF5);
  static const warning = Color(0xFF92400E);
  static const warningBg = Color(0xFFFFFBEB);
  static const error = Color(0xFF991B1B);
  static const errorBg = Color(0xFFFEF2F2);
}

class HireIQTheme {
  static ThemeData light() {
    final interTextTheme = GoogleFonts.interTextTheme();
    return ThemeData(
      useMaterial3: true,
      textTheme: interTextTheme.copyWith(
        displayLarge: interTextTheme.displayLarge?.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: HireIQColors.textPrimary),
        displayMedium: interTextTheme.displayMedium?.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: HireIQColors.textPrimary),
        headlineLarge: interTextTheme.headlineLarge?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: HireIQColors.textPrimary),
        headlineMedium: interTextTheme.headlineMedium?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: HireIQColors.textPrimary),
        headlineSmall: interTextTheme.headlineSmall?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: HireIQColors.textPrimary),
        titleLarge: interTextTheme.titleLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: HireIQColors.textPrimary),
        titleMedium: interTextTheme.titleMedium?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: HireIQColors.textPrimary),
        titleSmall: interTextTheme.titleSmall?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: HireIQColors.textPrimary),
        bodyLarge: interTextTheme.bodyLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: HireIQColors.textPrimary),
        bodyMedium: interTextTheme.bodyMedium?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: HireIQColors.textPrimary),
        bodySmall: interTextTheme.bodySmall?.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: HireIQColors.textMuted),
        labelLarge: interTextTheme.labelLarge?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: HireIQColors.textPrimary),
        labelMedium: interTextTheme.labelMedium?.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: HireIQColors.textMuted),
        labelSmall: interTextTheme.labelSmall?.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: HireIQColors.textMuted),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: HireIQColors.teal,
        primary: HireIQColors.teal,
        secondary: HireIQColors.navy,
        surface: HireIQColors.surface,
        error: HireIQColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: HireIQColors.textPrimary,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: HireIQColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: HireIQColors.surface,
        foregroundColor: HireIQColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: HireIQColors.textPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: HireIQColors.teal,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: HireIQColors.teal,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: HireIQColors.teal, width: 1.5),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: HireIQColors.teal,
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: HireIQColors.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: HireIQColors.silver),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: HireIQColors.silver),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: HireIQColors.teal, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: HireIQColors.error),
        ),
        labelStyle: GoogleFonts.inter(color: HireIQColors.textMuted),
        hintStyle: GoogleFonts.inter(color: HireIQColors.textMuted),
      ),
      cardTheme: CardThemeData(
        color: HireIQColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: HireIQColors.silver),
        ),
        margin: EdgeInsets.zero,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: HireIQColors.background,
        selectedColor: HireIQColors.teal.withValues(alpha: 0.08),
        labelStyle:
            GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: HireIQColors.silver),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HireIQColors.surface,
        selectedItemColor: HireIQColors.teal,
        unselectedItemColor: HireIQColors.textMuted,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 12),
      ),
      dividerTheme: const DividerThemeData(
        color: HireIQColors.silver,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
