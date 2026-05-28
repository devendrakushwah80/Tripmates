import 'package:get/get.dart';

import '../controllers/driver_onboarding_controller.dart';

class DriverOnboardingBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<DriverOnboardingController>()) {
      Get.put<DriverOnboardingController>(
        DriverOnboardingController(),
        permanent: true,
      );
    }
  }
}
