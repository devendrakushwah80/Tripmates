import 'package:get/get.dart';

import '../controllers/chat_car_info_controller.dart';

class ChatCarInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatCarInfoController>(() => ChatCarInfoController());
  }
}

