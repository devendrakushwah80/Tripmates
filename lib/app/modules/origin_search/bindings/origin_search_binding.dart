import 'package:get/get.dart';

import '../controllers/origin_search_controller.dart';

class OriginSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OriginSearchController>(() => OriginSearchController());
  }
}

