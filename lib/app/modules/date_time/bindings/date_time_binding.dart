import 'package:get/get.dart';

import '../controllers/date_time_controller.dart';

class DateTimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DateTimeController>(() => DateTimeController());
  }
}

