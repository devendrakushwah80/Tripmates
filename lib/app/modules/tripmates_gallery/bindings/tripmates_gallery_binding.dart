import 'package:get/get.dart';

import '../controllers/tripmates_gallery_controller.dart';

class TripmatesGalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripmatesGalleryController>(() => TripmatesGalleryController());
  }
}

