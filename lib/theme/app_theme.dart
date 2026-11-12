import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.canvas,
      colorScheme: const ColorScheme.light(
        primary: AppColors.brand,
        onPrimary: Colors.white,
        secondary: AppColors.lime,
        onSecondary: AppColors.ink,
        surface: AppColors.surface,
        onSurface: AppColors.ink,
        error: AppColors.danger,
      ),
    );

    const textTheme = TextTheme(
      displayLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.6,
        height: 1.1,
      ),
      displayMedium: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.3,
        height: 1.12,
      ),
      displaySmall: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        letterSpacing: -1,
        height: 1.15,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        height: 1.2,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        height: 1.25,
      ),
      titleLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
        height: 1.3,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
        height: 1.35,
      ),
      titleSmall: TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
        height: 1.35,
      ),
      bodyLarge: TextStyle(fontSize: 14, height: 1.55),
      bodyMedium: TextStyle(fontSize: 12.5, height: 1.5),
      bodySmall: TextStyle(fontSize: 11, height: 1.45),
      labelLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      labelMedium: TextStyle(
        fontSize: 10.5,
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
      labelSmall: TextStyle(
        fontSize: 9,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        height: 1.3,
      ),
    );

    return base.copyWith(
      textTheme: textTheme.apply(
        bodyColor: AppColors.ink,
        displayColor: AppColors.ink,
      ),
      splashFactory: InkRipple.splashFactory,
      dividerTheme: const DividerThemeData(
        color: AppColors.line,
        thickness: 1,
        space: 1,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        modalBackgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.ink,
        contentTextStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.brand,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.brand,
        selectionColor: AppColors.brandSoft,
        selectionHandleColor: AppColors.brand,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.brand,
        linearTrackColor: AppColors.line,
      ),
      iconTheme: const IconThemeData(color: AppColors.ink),
    );
  }
}
