import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../navigation/user_home_navigation.dart';
import '../../modules/driver_shell/controllers/driver_shell_controller.dart';
import '../../modules/driver_shell/widgets/driver_shell_bottom_nav.dart';
import '../../modules/home/controllers/home_controller.dart';
import '../../routes/app_pages.dart';
import 'tripmates/tm_bottom_nav.dart';

/// Passenger: [TmBottomNav]. Verified driver: [DriverShellBottomNav] matching the driver shell.
///
/// When [highlightPublishInFlow] is true (e.g. make-new-ride / date-time / prefs), the center
/// publish tab appears active while the user is in the publish stack.
class DriverAwareBottomNav extends StatelessWidget {
  const DriverAwareBottomNav({
    super.key,
    this.highlightPublishInFlow = false,
  });

  final bool highlightPublishInFlow;

  static bool _onPublishFlowRoute(String name) =>
      name == Routes.MAKE_NEW_RIDE ||
      name == Routes.DATE_TIME ||
      name == Routes.TRIP_PREFERENCES;

  @override
  Widget build(BuildContext context) {
    if (!UserHomeNavigation.isDriver) {
      return TmBottomNav(
        selectedIndex: 0,
        onTap: (i) {
          if (Get.isRegistered<HomeController>()) {
            Get.find<HomeController>().onBottomNav(i);
          }
        },
      );
    }

    if (!Get.isRegistered<DriverShellController>()) {
      return TmBottomNav(
        selectedIndex: 0,
        onTap: (i) {
          if (Get.isRegistered<HomeController>()) {
            Get.find<HomeController>().onBottomNav(i);
          }
        },
      );
    }

    final shell = Get.find<DriverShellController>();
    return Obx(() {
      final _ = shell.tabIndex.value;
      final selected = highlightPublishInFlow ? 2 : shell.bottomNavSelection;
      return DriverShellBottomNav(
        selectedIndex: selected,
        onTap: (i) {
          final routeName = Get.currentRoute;
          if (_onPublishFlowRoute(routeName) && i != 2) {
            Get.until((route) => route.settings.name == Routes.DRIVER_HOME);
          }
          shell.onBottomTap(i);
        },
      );
    });
  }
}
