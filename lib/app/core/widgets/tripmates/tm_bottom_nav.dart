import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../navigation/user_home_navigation.dart';
import '../../../modules/driver_shell/widgets/driver_shell_bottom_nav.dart';
import '../../../modules/passenger_shell/widgets/passenger_bottom_nav.dart';

/// A global wrapper that displays either the Driver or Passenger bottom navigation bar
/// based on the user's current role.
class TmBottomNav extends StatelessWidget {
  const TmBottomNav({super.key, this.selectedIndex = 0, this.onTap});

  final int selectedIndex;
  final void Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    final isDriver = UserHomeNavigation.isDriver;

    if (isDriver) {
      return DriverShellBottomNav(
        selectedIndex: selectedIndex,
        onTap: onTap ?? UserHomeNavigation.handleGlobalBottomTap,
      );
    } else {
      return PassengerBottomNav(
        currentIndex: selectedIndex,
        onTap: onTap ?? UserHomeNavigation.handleGlobalBottomTap,
      );
    }
  }
}
