import 'package:get/get.dart';

import '../controllers/live_trip_controller.dart';

class LiveTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveTripController>(() => LiveTripController());
  }
}
