import 'package:get/get.dart';

import '../controllers/my_garage_controller.dart';

class MyGarageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyGarageController>(() => MyGarageController());
  }
}

