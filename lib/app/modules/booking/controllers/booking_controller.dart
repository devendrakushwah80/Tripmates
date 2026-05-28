import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class BookingController extends GetxController {
  void openLiveMap() => Get.toNamed<void>(Routes.LIVE_TRIP);
  void openMyRides() => Get.offAllNamed<void>(Routes.MY_RIDES);
}

