import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/navigation/user_home_navigation.dart';
import '../../../routes/app_pages.dart';
import '../../../services/local_storage_services/local_storage_services.dart';
import '../../../services/signup_flow_service/signup_flow_service.dart';

class RoleSelectionController extends GetxController {
  final selected = ''.obs;

  void selectDriver() {
    selected.value = 'driver';
    SignupFlowService.I.selectedRole.value = 'driver';
  }

  void selectPassenger() {
    selected.value = 'passenger';
    SignupFlowService.I.selectedRole.value = 'passenger';
  }

  Future<void> finishAndEnterApp() async {
    if (selected.value.isEmpty) {
      Get.snackbar(
        'signup.role.required_title'.tr,
        'signup.role.required_msg'.tr,
      );
      return;
    }
    await LocalStorageService().setUserName(SignupFlowService.I.fullName.value);
    await LocalStorageService().setEmailId(SignupFlowService.I.email.value);
    // Demo token so home treats user as logged in if needed
    await LocalStorageService().setAuthToken('demo_signup_token');

    final role = selected.value;

    if (Get.isRegistered<SignupFlowService>()) {
      SignupFlowService.I.clear();
      Get.delete<SignupFlowService>(force: true);
    }

    if (role == 'passenger') {
      Get.snackbar(
        'app.name'.tr,
        'driver_flow.passenger_welcome'.tr,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
      );
      await LocalStorageService().setUserRole('passenger');
      await Future<void>.delayed(const Duration(milliseconds: 350));
      UserHomeNavigation.offAllToUserHome();
    } else {
      Get.toNamed<void>(Routes.DRIVER_LICENSE);
    }
  }
}
