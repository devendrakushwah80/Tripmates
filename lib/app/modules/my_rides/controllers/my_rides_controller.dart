import 'package:get/get.dart';

class MyRidesController extends GetxController {
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    Future<void>.delayed(const Duration(milliseconds: 1100), () {
      isLoading.value = false;
    });
  }
}

