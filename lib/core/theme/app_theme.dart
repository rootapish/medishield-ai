import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      surfaceContainerHighest: AppColors.surfaceVariant,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: AppColors.inverseSurface,
      onInverseSurface: AppColors.inverseOnSurface,
      inversePrimary: AppColors.inversePrimary,
      surfaceTint: AppColors.surfaceTint,
    );

    final baseTextTheme = Typography.englishLike2021.apply(bodyColor: colorScheme.onSurface, displayColor: colorScheme.onSurface);

    final textTheme = baseTextTheme.copyWith(
      displayLarge: GoogleFonts.manrope(textStyle: baseTextTheme.displayLarge?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.02)),
      displayMedium: GoogleFonts.manrope(textStyle: baseTextTheme.displayMedium?.copyWith(fontWeight: FontWeight.w700)),
      displaySmall: GoogleFonts.manrope(textStyle: baseTextTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700)),
      headlineLarge: GoogleFonts.manrope(textStyle: baseTextTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w600)),
      headlineMedium: GoogleFonts.manrope(textStyle: baseTextTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600)),
      headlineSmall: GoogleFonts.manrope(textStyle: baseTextTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
      titleLarge: GoogleFonts.manrope(textStyle: baseTextTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
      titleMedium: GoogleFonts.manrope(textStyle: baseTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
      titleSmall: GoogleFonts.manrope(textStyle: baseTextTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
      labelLarge: GoogleFonts.manrope(textStyle: baseTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700)),
      labelMedium: GoogleFonts.manrope(textStyle: baseTextTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.01)),
      labelSmall: GoogleFonts.manrope(textStyle: baseTextTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
      bodyLarge: GoogleFonts.workSans(textStyle: baseTextTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400)),
      bodyMedium: GoogleFonts.workSans(textStyle: baseTextTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400)),
      bodySmall: GoogleFonts.workSans(textStyle: baseTextTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400)),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
    );
  }

  static ThemeData dark() {
    return light(); // For this demo, force light theme due to specific pastel neumorphic design
  }
}
