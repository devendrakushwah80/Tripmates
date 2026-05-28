import 'package:get/get.dart';

import '../controllers/make_new_ride_controller.dart';

class MakeNewRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MakeNewRideController>(() => MakeNewRideController());
  }
}

