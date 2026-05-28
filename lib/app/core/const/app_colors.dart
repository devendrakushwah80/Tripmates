import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// TripMates — mirrors `:root` in [TripMates_Complete_App.html] (same hex tokens).
class TripMatesColors {
  TripMatesColors._();

  // ── Brand Greens ──────────────────────────────────────────
  /// Primary brand green. CTA buttons, active nav icons, badges, key accents.
  static const Color green = Color(0xFF1A7A3D); // --g

  /// Darker green. Hover/pressed states on primary buttons.
  static const Color greenDark = Color(0xFF145E2F); // --gd

  /// Lighter green. Success indicators, subtle highlights, softer icon fills.
  static const Color greenLight = Color(0xFF2E9B54); // --gl

  // ── Brand Blues ───────────────────────────────────────────
  /// Primary deep navy. Headings, app bar titles, text on mint/white surfaces.
  static const Color blue = Color(0xFF163A5F); // --b

  /// Darkest navy. Dark status bars, gradient start, deep overlay surfaces.
  static const Color blueDark = Color(0xFF0F2A47); // --bd

  /// Accent blue. Links, inline text links, informational interactive elements.
  static const Color accent = Color(0xFF1B6FA8); // --ac

  // ── Backgrounds & Surfaces ────────────────────────────────
  /// Legacy mint token mapped to white to keep light screens neutral.
  static const Color mint = white; // --mint

  /// Sky blue tint. Alternate section background and map overlays.
  static const Color sky = Color(0xFFE4EEF8); // --sky

  /// Legacy alias for pure white. Prefer `Theme.of(context).scaffoldBackgroundColor`
  /// (`AppColors.backgroundLight` / dark surface) for screen canvases.
  static const Color appBackground = white; // --app

  /// Pure white. Cards, bottom nav, modals, primary content surfaces.
  static const Color white = Color(0xFFFFFFFF); // --white

  /// Off-white screen base. Secondary list items, alternating rows.
  static const Color off = Color(0xFFF7FAFB); // --off

  /// Divider lines between list rows, bottom nav borders, card separators.
  static const Color divider = Color(0xFFD8E4EC); // --div

  // ── Text ──────────────────────────────────────────────────
  /// Primary body text. Main content, labels, data values.
  static const Color text1 = Color(0xFF1F2937); // --t1

  /// Deep navy headings. Screen titles, section headers, Poppins headings.
  static const Color text2 = Color(0xFF163A5F); // --t2

  /// Secondary text. Subtitles, descriptions, supporting information.
  static const Color text3 = Color(0xFF4B5563); // --t3

  /// Muted/hint text. Placeholders, inactive tabs, timestamps, metadata.
  static const Color text4 = Color(0xFF6B7280); // --t4

  // ── Status / Semantic ─────────────────────────────────────
  /// Success badge background. "Confirmed", "active", "completed" states.
  static const Color chipSuccess = Color(0xFFD1F0DC); // --sg

  /// Warning badge background. Pending, in-progress, attention-needed states.
  static const Color chipWarnBg = Color(0xFFFEF3CD); // --sw

  /// Error badge background. Cancelled, failed, destructive action states.
  static const Color chipErrorBg = Color(0xFFFEE2E2); // --se

  /// Info badge background. Informational chips, tips, neutral notices.
  static const Color chipInfoBg = Color(0xFFDBEAFE); // --si

  /// Solid warning amber. Icons, text labels, toast notifications.
  static const Color warn = Color(0xFFF59E0B); // --warn

  /// Solid error red. Destructive actions, validation errors, critical alerts.
  static const Color error = Color(0xFFDC2626); // --err

  // ── Map Colors ────────────────────────────────────────────
  /// Map route lines and origin/destination markers.
  static const Color mapBlue = Color(0xFF2563EB);

  /// Map destination pin and active waypoint.
  static const Color mapGreen = Color(0xFF16A34A);

  // ── Border Radii ──────────────────────────────────────────
  static const double radiusSm = 14; // --r1
  static const double radiusMd = 18; // --r2
  static const double radiusLg = 24; // --r3

  // ── Shell / Prototype ─────────────────────────────────────
  /// HTML gallery backdrop behind phone frames.
  static const Color galleryBackdrop = Color(0xFFB0C4B8);

  /// Outer phone bezel ring color.
  static const Color phoneRingOuter = Color(0xFF1A1A1E);

  /// Inner phone bezel ring color.
  static const Color phoneRingInner = Color(0xFF2A2A2E);

  // ── Glossy Surface Tokens ─────────────────────────────────
  static const Color glossyHighlight = Color(0xFFFFFFFF);
  static const double glossyHighlightAlpha = 0.28;
  static const double glossyOverlayAlpha = 0.12;

  static Gradient get glossyGradientLight => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      glossyHighlight.withValues(alpha: glossyHighlightAlpha),
      Colors.transparent,
    ],
  );

  static Gradient get glossyGradientDark => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [glossyHighlight.withValues(alpha: 0.12), Colors.transparent],
  );

  // ── Elevation Recipes ─────────────────────────────────────
  static List<BoxShadow> get glossyCardShadow => [
    BoxShadow(
      color: blue.withValues(alpha: 0.08),
      blurRadius: 28,
      offset: const Offset(0, 14),
    ),
    BoxShadow(
      color: green.withValues(alpha: 0.08),
      blurRadius: 18,
      offset: const Offset(0, 6),
    ),
  ];

  static List<BoxShadow> get glossyButtonShadow => [
    BoxShadow(
      color: green.withValues(alpha: 0.22),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  // ── Shadows ───────────────────────────────────────────────
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: blue.withValues(alpha: 0.05),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get primaryButtonShadow => [
    BoxShadow(
      color: green.withValues(alpha: 0.2),
      blurRadius: 18,
      offset: const Offset(0, 7),
    ),
  ];

  static List<BoxShadow> get phoneShadow => [
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.5),
      blurRadius: 100,
      offset: Offset(0, 40),
    ),
  ];
}

class AppColors {
  AppColors._();

  // ── Theme Detection ───────────────────────────────────────
  static bool get isDark => Get.isDarkMode;

  // ── Dynamic Semantic Colors ──────────────────────────────
  static Color get background => isDark ? darkBackground : backgroundLight;
  static Color get surface => isDark ? darkSurface : card;
  static Color get surfaceElevated => isDark ? darkSurfaceElevated : card;
  static Color get border => isDark ? darkBorder : borderLight;
  static Color get textMain => isDark ? darkTextPrimary : textPrimary;
  static Color get textSub => isDark ? darkTextSecondary : textSecondary;
  static Color get textHint => isDark ? darkTextMuted : textMuted;

  // ── Brand Colors ──────────────────────────────────────────
  static const Color primaryColor = TripMatesColors.green;
  static const Color primaryDark = TripMatesColors.greenDark;
  static const Color accentBlue = TripMatesColors.accent;
  static const Color white = TripMatesColors.white;
  static const Color red = TripMatesColors.error;

  // ── Light Theme (Constants) ───────────────────────────────
  static const Color backgroundLight = Color(0xFFF5FAF8);
  static const Color pageBackground = TripMatesColors.galleryBackdrop;
  static const Color card = TripMatesColors.white;
  static const Color cardSecondary = TripMatesColors.off;
  static const Color inputFieldBg = TripMatesColors.white;
  static const Color borderLight = TripMatesColors.divider;
  static const Color textPrimary = TripMatesColors.text1;
  static const Color textSecondary = TripMatesColors.text3;
  static const Color textMuted = TripMatesColors.text4;

  // ── Dark Theme (Constants) ────────────────────────────────
  static const Color darkBackground = Color(0xFF06183A);
  static const Color darkSurface = Color(0xFF0B2248);
  static const Color darkSurfaceElevated = Color(0xFF12315D);
  static const Color darkBorder = Color(0xFF21436F);
  static const Color darkTextPrimary = Color(0xFFEAF2FB);
  static const Color darkTextSecondary = Color(0xFFC4D3E8);
  static const Color darkTextMuted = Color(0xFF9CB3D0);
}
