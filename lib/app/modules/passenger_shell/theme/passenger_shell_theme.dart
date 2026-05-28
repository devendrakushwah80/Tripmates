import 'package:flutter/material.dart';
import '../../../core/const/app_colors.dart';

/// Passenger shell — TripMates brand.
/// Pointing to global AppColors for centralized dark mode support.
abstract final class PassengerShellTheme {
  static Color get primaryGreen => AppColors.primaryColor;
  static Color get softGreenBg =>
      AppColors.isDark ? const Color(0xFF0D2D1A) : const Color(0xFFEAF7EF);
  static Color get screenBg => AppColors.background;
  static Color get textPrimary => AppColors.textMain;
  static Color get textSecondary => AppColors.textSub;
  static Color get cardWhite => AppColors.surface;
  static Color get success => TripMatesColors.greenLight;
  static Color get danger => AppColors.red;
  static Color get fieldBg =>
      AppColors.isDark ? AppColors.darkSurfaceElevated : Colors.white;

  /// Extra space below status bar / notch.
  static double topContentPadding(BuildContext context) =>
      MediaQuery.paddingOf(context).top + 14;

  static List<BoxShadow> get cardShadow => AppColors.isDark
      ? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ]
      : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ];

  /// Lighter elevation for passenger cards.
  static List<BoxShadow> get cardShadowSoft => AppColors.isDark
      ? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ]
      : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.045),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ];
}
