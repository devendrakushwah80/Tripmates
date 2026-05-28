import 'package:get/get.dart';

import '../controllers/passenger_flow_controller.dart';
import '../controllers/passenger_shell_controller.dart';

class PassengerShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PassengerFlowController>(
      () => PassengerFlowController(),
      fenix: true,
    );
    Get.lazyPut<PassengerShellController>(
      () => PassengerShellController(),
      fenix: true,
    );
  }
}

class PassengerFlowBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<PassengerFlowController>()) {
      Get.lazyPut<PassengerFlowController>(() => PassengerFlowController(), fenix: true);
    }
  }
}
