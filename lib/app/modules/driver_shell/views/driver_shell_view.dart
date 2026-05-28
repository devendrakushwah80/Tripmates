import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/driver_shell_controller.dart';
import '../theme/driver_shell_theme.dart';
import '../widgets/driver_shell_bottom_nav.dart';
import 'driver_earnings_tab.dart';
import 'driver_home_tab.dart';
import 'driver_my_rides_tab.dart';
import 'driver_profile_tab.dart';

class DriverShellView extends GetView<DriverShellController> {
  const DriverShellView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DriverShellTheme.screenBg,
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            DriverHomeTab(onPublishRide: controller.openPublishRide),
            const DriverMyRidesTab(),
            const DriverEarningsTab(),
            const DriverProfileTab(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => DriverShellBottomNav(
          selectedIndex: controller.bottomNavSelection,
          onTap: controller.onBottomTap,
        ),
      ),
    );
  }
}
