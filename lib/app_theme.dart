import 'package:flutter/material.dart';

abstract final class AppPalette {
  static const Color background = Color(0xFFFFFBF7);
  static const Color backgroundAlt = Color(0xFFFFF8F4);
  static const Color surface = Colors.white;
  static const Color surfaceSoft = Color(0xFFFFF8F4);
  static const Color surfaceTint = Color(0xFFFFF5EF);
  static const Color primary = Color(0xFFE8665D);
  static const Color primaryDark = Color(0xFFB94D45);
  static const Color primarySoft = Color(0xFFFFEFEF);
  static const Color primaryBorder = Color(0xFFFFD8D3);
  static const Color border = Color(0xFFF0E6DE);
  static const Color divider = Color(0xFFF2ECE6);
  static const Color textPrimary = Color(0xFF1D1B20);
  static const Color textStrong = Color(0xFF1E1C22);
  static const Color textSecondary = Color(0xFF6B625D);
  static const Color textMuted = Color(0xFF897F78);
  static const Color textSoft = Color(0xFF837974);
  static const Color labelMuted = Color(0xFFB2A49B);
  static const Color shadow = Color(0xFF7A3F00);
}

abstract final class StudyAbroadTheme {
  static ThemeData get data {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppPalette.primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppPalette.primary,
      onPrimary: AppPalette.surface,
      secondary: AppPalette.primaryDark,
      surface: AppPalette.surface,
      onSurface: AppPalette.textPrimary,
      surfaceTint: AppPalette.surfaceTint,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppPalette.background,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppPalette.primary,
        selectionColor: AppPalette.primaryBorder,
        selectionHandleColor: AppPalette.primary,
      ),
    );
  }
}
