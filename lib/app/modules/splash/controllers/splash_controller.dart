import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/navigation/user_home_navigation.dart';
import '../../../services/local_storage_services/local_storage_services.dart';
import '../../auth_screens/views/onboard_1_view.dart';

class SplashController extends GetxController {
  /// Called when the splash animation sequence finishes.
  void completeToStart() {
    final loggedIn = LocalStorageService().isLoggedIn();
    const duration = Duration(milliseconds: 380);
    const curve = Curves.easeOutCubic;

    if (loggedIn) {
      UserHomeNavigation.offAllToUserHome();
    } else {
      Get.offAll(
        () => const Onboard1View(),
        transition: Transition.fadeIn,
        duration: duration,
        curve: curve,
      );
    }
  }
}
