import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class EmailVerifyController extends GetxController {
  void continueNext() => Get.toNamed<void>(Routes.PROFILE_PHOTO_SIGNUP);

  void resend() {
    Get.snackbar(
      'signup.email.resend_title'.tr,
      'signup.email.resend_msg'.tr,
    );
  }
}
