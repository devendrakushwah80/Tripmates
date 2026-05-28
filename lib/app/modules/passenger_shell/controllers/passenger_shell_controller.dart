import 'package:get/get.dart';

class PassengerShellController extends GetxController {
  final tabIndex = 0.obs;

  void goToTab(int i) {
    if (i >= 0 && i < 5) tabIndex.value = i;
  }

  void onBottomTap(int i) => goToTab(i);
}
