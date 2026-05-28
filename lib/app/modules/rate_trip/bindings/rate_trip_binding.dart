import 'package:get/get.dart';

import '../controllers/rate_trip_controller.dart';

class RateTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RateTripController>(() => RateTripController());
  }
}
