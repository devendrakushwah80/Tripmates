import 'package:get/get.dart';

import '../controllers/driver_shell_controller.dart';

class DriverShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(DriverShellController.new);
  }
}
