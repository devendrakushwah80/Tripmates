import 'package:get/get.dart';

import '../controllers/ride_results_controller.dart';

class RideResultsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideResultsController>(() => RideResultsController());
  }
}

