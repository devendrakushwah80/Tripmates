import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// Passenger UI is designed for light surfaces. When the app uses [ThemeMode.dark],
/// inherited text styles would stay “light on dark” colors and become invisible on
/// white cards. This scope pins the subtree to [AppTheme.lightTheme].
class PassengerLightThemeScope extends StatelessWidget {
  const PassengerLightThemeScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.lightTheme,
      child: child,
    );
  }
}
