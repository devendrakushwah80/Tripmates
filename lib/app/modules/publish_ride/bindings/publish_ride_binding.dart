import 'package:get/get.dart';

import '../controllers/publish_ride_controller.dart';

class PublishRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublishRideController>(() => PublishRideController());
  }
}
