import 'package:get/get.dart';

import '../controllers/driver_identity_controller.dart';

class DriverIdentityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverIdentityController>(() => DriverIdentityController());
  }
}
