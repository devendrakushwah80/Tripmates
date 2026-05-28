import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class VerificationCompleteController extends GetxController {
  void continueNext() => Get.toNamed<void>(Routes.ROLE_SELECTION);
}
