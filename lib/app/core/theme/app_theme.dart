import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const/app_colors.dart';

class AppTheme {
  AppTheme._();

  // ─────────────────────────────────────────────────────────
  // LIGHT THEME
  // ─────────────────────────────────────────────────────────
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Nunito',

    // ── Color Scheme ──────────────────────────────────────
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.white,
      primaryContainer: Color(0xFFE8F5EE),
      onPrimaryContainer: TripMatesColors.blue,

      secondary: AppColors.accentBlue,
      onSecondary: AppColors.white,
      secondaryContainer: TripMatesColors.sky,
      onSecondaryContainer: TripMatesColors.blue,

      surface: AppColors.card,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.cardSecondary,

      outline: AppColors.borderLight,
      outlineVariant: TripMatesColors.divider,

      error: AppColors.red,
      onError: AppColors.white,
      errorContainer: TripMatesColors.chipErrorBg,
      onErrorContainer: AppColors.red,
    ),

    // ── Scaffold ──────────────────────────────────────────
    scaffoldBackgroundColor: AppColors.backgroundLight,
    // ── AppBar ────────────────────────────────────────────
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.backgroundLight,
      foregroundColor: TripMatesColors.blue,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: TripMatesColors.blue,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),

    // ── Card ──────────────────────────────────────────────
    cardTheme: CardThemeData(
      color: AppColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TripMatesColors.radiusSm),
        side: const BorderSide(color: TripMatesColors.divider),
      ),
    ),

    // ── Divider ───────────────────────────────────────────
    dividerTheme: const DividerThemeData(
      color: TripMatesColors.divider,
      thickness: 1,
      space: 0,
    ),

    // ── Input ─────────────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputFieldBg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: TripMatesColors.divider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: TripMatesColors.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: TripMatesColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: TripMatesColors.error, width: 1.5),
      ),
      hintStyle: const TextStyle(
        color: AppColors.textMuted,
        fontSize: 14,
      ),
      labelStyle: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 14,
      ),
      errorStyle: const TextStyle(color: TripMatesColors.error, fontSize: 12),
    ),

    // ── Elevated Button ───────────────────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor, // #1A7A3D
        foregroundColor: AppColors.white,
        disabledBackgroundColor: TripMatesColors.divider,
        disabledForegroundColor: AppColors.textMuted,
        elevation: 0,
        shadowColor: Colors.transparent,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TripMatesColors.radiusSm),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    ),

    // ── Outlined Button ───────────────────────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor, // #1A7A3D
        disabledForegroundColor: AppColors.textMuted,
        minimumSize: const Size(double.infinity, 52),
        side: const BorderSide(color: AppColors.primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TripMatesColors.radiusSm),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    ),

    // ── Text Button ───────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accentBlue, // #1B6FA8
        textStyle: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),

    // ── Bottom Navigation Bar ─────────────────────────────
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: TripMatesColors.white,
      selectedItemColor: AppColors.primaryColor, // #1A7A3D
      unselectedItemColor: TripMatesColors.text4, // #6B7280
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w700,
        fontSize: 10,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
        fontSize: 10,
      ),
    ),

    // ── Chip ──────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: TripMatesColors.mint, // #E8F5EE
      selectedColor: AppColors.primaryColor, // #1A7A3D
      disabledColor: TripMatesColors.divider,
      labelStyle: const TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: TripMatesColors.blue,
      ),
      secondaryLabelStyle: const TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: TripMatesColors.white,
      ),
      side: const BorderSide(color: TripMatesColors.divider),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    ),

    // ── Switch ────────────────────────────────────────────
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return TripMatesColors.white;
        return TripMatesColors.text4;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected))
          return AppColors.primaryColor;
        return TripMatesColors.divider;
      }),
    ),

    // ── List Tile ─────────────────────────────────────────
    listTileTheme: const ListTileThemeData(
      tileColor: TripMatesColors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      titleTextStyle: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: TripMatesColors.text1,
      ),
      subtitleTextStyle: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 13,
        color: TripMatesColors.text4,
      ),
    ),

    // ── Text Theme ────────────────────────────────────────
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w800,
        color: TripMatesColors.blue,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        color: TripMatesColors.blue,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        color: TripMatesColors.blue,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        color: TripMatesColors.blue,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: TripMatesColors.blue,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: TripMatesColors.blue,
        fontSize: 18,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        color: TripMatesColors.blue,
        fontSize: 15,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
        color: TripMatesColors.text1,
        fontSize: 13,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w400,
        color: TripMatesColors.text1,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w400,
        color: TripMatesColors.text1,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w400,
        color: TripMatesColors.text3,
        fontSize: 12,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
        fontSize: 10,
        letterSpacing: 0.5,
      ),
    ),
  );

  // ─────────────────────────────────────────────────────────
  // DARK THEME  (fully independent — no copyWith from light)
  // ─────────────────────────────────────────────────────────
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Nunito',

    // ── Color Scheme ──────────────────────────────────────
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.white,
      primaryContainer: TripMatesColors.greenDark,
      onPrimaryContainer: Color(0xFFB7F0CB),

      secondary: AppColors.accentBlue,
      onSecondary: AppColors.white,
      secondaryContainer: AppColors.darkSurface,
      onSecondaryContainer: AppColors.darkTextSecondary,

      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,
      surfaceContainerHighest: AppColors.darkSurfaceElevated,

      outline: AppColors.darkBorder,
      outlineVariant: Color(0xFF1A3254),

      error: AppColors.red,
      onError: AppColors.white,
      errorContainer: Color(0xFF7F1D1D),
      onErrorContainer: Color(0xFFFECACA),
    ),

    // ── Scaffold (matches HomeHubBody canvas: mint-white light / navy surface dark)
    scaffoldBackgroundColor: AppColors.darkSurface,
    // ── AppBar ────────────────────────────────────────────
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.darkTextPrimary,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.darkTextPrimary,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),

    // ── Card ──────────────────────────────────────────────
    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TripMatesColors.radiusSm),
        side: const BorderSide(color: AppColors.darkBorder),
      ),
    ),

    // ── Divider ───────────────────────────────────────────
    dividerTheme: const DividerThemeData(
      color: AppColors.darkBorder,
      thickness: 1,
      space: 0,
    ),

    // ── Input ─────────────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: TripMatesColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: TripMatesColors.error, width: 1.5),
      ),
      hintStyle: const TextStyle(
        color: AppColors.darkTextMuted,
        fontSize: 14,
      ),
      labelStyle: const TextStyle(
        color: AppColors.darkTextSecondary,
        fontSize: 14,
      ),
      errorStyle: const TextStyle(color: TripMatesColors.error, fontSize: 12),
    ),

    // ── Elevated Button ───────────────────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor, // #1A7A3D — same in dark
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.darkBorder,
        disabledForegroundColor: AppColors.darkTextMuted,
        elevation: 0,
        shadowColor: Colors.transparent,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TripMatesColors.radiusSm),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    ),

    // ── Outlined Button ───────────────────────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor:
            TripMatesColors.greenLight, // #2E9B54 lighter for dark bg
        disabledForegroundColor: AppColors.darkTextMuted,
        minimumSize: const Size(double.infinity, 52),
        side: const BorderSide(color: TripMatesColors.greenLight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TripMatesColors.radiusSm),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    ),

    // ── Text Button ───────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.darkTextSecondary, // #C4D3E8
        textStyle: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),

    // ── Bottom Navigation Bar ─────────────────────────────
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface, // #0B2248
      selectedItemColor: TripMatesColors.greenLight, // #2E9B54
      unselectedItemColor: AppColors.darkTextMuted, // #9CB3D0
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w700,
        fontSize: 10,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
        fontSize: 10,
      ),
    ),

    // ── Chip ──────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.darkSurfaceElevated, // #12315D
      selectedColor: AppColors.primaryColor,
      disabledColor: AppColors.darkBorder,
      labelStyle: const TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: AppColors.darkTextSecondary,
      ),
      secondaryLabelStyle: const TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: TripMatesColors.white,
      ),
      side: const BorderSide(color: AppColors.darkBorder),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    ),

    // ── Switch ────────────────────────────────────────────
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return TripMatesColors.white;
        return AppColors.darkTextMuted;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected))
          return AppColors.primaryColor;
        return AppColors.darkBorder;
      }),
    ),

    // ── List Tile ─────────────────────────────────────────
    listTileTheme: const ListTileThemeData(
      tileColor: AppColors.darkSurface,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      titleTextStyle: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextPrimary,
      ),
      subtitleTextStyle: TextStyle(
        fontFamily: 'Nunito',
        fontSize: 13,
        color: AppColors.darkTextMuted,
      ),
    ),

    // ── Text Theme ────────────────────────────────────────
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w800,
        color: AppColors.darkTextPrimary,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        color: AppColors.darkTextPrimary,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        color: AppColors.darkTextPrimary,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        color: AppColors.darkTextPrimary,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextPrimary,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        color: AppColors.darkTextPrimary,
        fontSize: 18,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextPrimary,
        fontSize: 15,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextSecondary,
        fontSize: 13,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextPrimary,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextPrimary,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextSecondary,
        fontSize: 12,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: AppColors.darkTextPrimary,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: AppColors.darkTextSecondary,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
        fontSize: 10,
        color: AppColors.darkTextMuted,
        letterSpacing: 0.5,
      ),
    ),
  );
}
