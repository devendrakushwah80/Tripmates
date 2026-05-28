import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../services/local_storage_services/local_storage_services.dart';

/// Resolves the correct root shell after login / splash / “go home” actions.
abstract final class UserHomeNavigation {
  static bool get isDriver =>
      LocalStorageService().getUserRole().toLowerCase() == 'driver';

  static String get homeRoute =>
      isDriver ? Routes.DRIVER_HOME : Routes.PASSENGER_SHELL;

  /// Clears the stack and opens passenger [HomeView] or [DriverShellView].
  static void offAllToUserHome() {
    Get.offAllNamed<void>(homeRoute);
  }

  /// Handles bottom navigation taps across different screens.
  static void handleGlobalBottomTap(int i) {
    offAllToUserHome();
  }
}
