import 'package:get/get.dart';

import '../controllers/passenger_mode_controller.dart';

class PassengerModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PassengerModeController>(() => PassengerModeController());
  }
}

