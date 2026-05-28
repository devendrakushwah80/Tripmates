import 'package:flutter/material.dart';
import '../../../core/const/app_colors.dart';

/// Driver shell — reference palette.
/// Pointing to global AppColors for centralized dark mode support.
abstract final class DriverShellTheme {
  static Color get primaryGreen => AppColors.primaryColor;
  static Color get primaryGreenDark => AppColors.primaryDark;
  static Color get softGreenBg =>
      AppColors.isDark ? const Color(0xFF0D2D1A) : const Color(0xFFEAF7EF);
  static Color get screenBg => AppColors.background;
  static Color get textPrimary => AppColors.textMain;
  static Color get textSecondary => AppColors.textSub;
  static Color get cardWhite => AppColors.surface;

  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: AppColors.isDark
          ? Colors.black.withValues(alpha: 0.25)
          : Colors.black.withValues(alpha: 0.06),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: primaryGreen.withValues(alpha: 0.04),
      blurRadius: 1,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get badgeShadow => [
    BoxShadow(
      color: primaryGreen.withValues(alpha: 0.12),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];
}
