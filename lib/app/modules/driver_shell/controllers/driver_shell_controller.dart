import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class DriverShellController extends GetxController {
  /// IndexedStack: 0 home, 1 rides, 2 earnings, 3 profile (publish is nav-only).
  final tabIndex = 0.obs;

  int get bottomNavSelection {
    switch (tabIndex.value) {
      case 0:
        return 0;
      case 1:
        return 1;
      case 2:
        return 3;
      case 3:
        return 4;
      default:
        return 0;
    }
  }

  void onBottomTap(int navIndex) {
    if (navIndex == 2) {
      openPublishRide();
      return;
    }
    final stackIdx = navIndex < 2 ? navIndex : navIndex - 1;
    tabIndex.value = stackIdx;
  }

  void goToTab(int stackIdx) {
    if (stackIdx >= 0 && stackIdx <= 3) tabIndex.value = stackIdx;
  }

  Future<void> openPublishRide() async {
    await Future<void>.microtask(() async {
      final here = Get.currentRoute;
      if (here == Routes.MAKE_NEW_RIDE ||
          here == Routes.DATE_TIME ||
          here == Routes.TRIP_PREFERENCES) {
        return;
      }
      await Get.toNamed<void>(Routes.MAKE_NEW_RIDE);
    });
  }
}
