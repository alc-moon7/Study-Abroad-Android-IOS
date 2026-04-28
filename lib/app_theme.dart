import 'package:flutter/material.dart';

abstract final class AppPalette {
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundAlt = Color(0xFFFAFAFA);
  static const Color surface = Colors.white;
  static const Color surfaceSoft = Color(0xFFFAFAFA);
  static const Color surfaceTint = Color(0xFFF6F6F6);
  static const Color primary = Color(0xFF2F2D2C);
  static const Color primaryDark = Color(0xFF171717);
  static const Color primarySoft = Color(0xFFF7F7F7);
  static const Color primaryBorder = Color(0xFFE5E5E5);
  static const Color border = Color(0xFFE9E9E9);
  static const Color divider = Color(0xFFF0F0F0);
  static const Color textPrimary = Color(0xFF1D1B20);
  static const Color textStrong = Color(0xFF1E1C22);
  static const Color textSecondary = Color(0xFF625F5D);
  static const Color textMuted = Color(0xFF84817F);
  static const Color textSoft = Color(0xFF7C7977);
  static const Color labelMuted = Color(0xFFA9A6A3);
  static const Color shadow = Color(0xFF000000);
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
