import 'package:get/get.dart';

import '../controllers/trip_preferences_controller.dart';

class TripPreferencesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripPreferencesController>(() => TripPreferencesController());
  }
}

