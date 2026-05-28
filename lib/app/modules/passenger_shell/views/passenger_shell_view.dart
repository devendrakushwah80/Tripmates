import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/passenger_shell_controller.dart';
import '../theme/passenger_shell_theme.dart';
import '../widgets/passenger_bottom_nav.dart';
import 'tabs/passenger_home_tab.dart';
import 'tabs/passenger_my_rides_tab.dart';
import 'tabs/passenger_profile_tab.dart';
import 'tabs/passenger_safety_tab.dart';
import 'tabs/passenger_search_tab.dart';

class PassengerShellView extends GetView<PassengerShellController> {
  const PassengerShellView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PassengerShellTheme.screenBg,
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: const [
            PassengerHomeTab(),
            PassengerSearchTab(),
            PassengerMyRidesTab(),
            PassengerSafetyTab(),
            PassengerProfileTab(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => PassengerBottomNav(
          currentIndex: controller.tabIndex.value,
          onTap: controller.onBottomTap,
        ),
      ),
    );
  }
}
