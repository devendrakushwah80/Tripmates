import 'package:get/get.dart';

import '../controllers/email_verify_controller.dart';
import '../controllers/profile_photo_signup_controller.dart';
import '../controllers/role_selection_controller.dart';
import '../controllers/selfie_signup_controller.dart';
import '../controllers/verification_complete_controller.dart';

class EmailVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailVerifyController>(() => EmailVerifyController());
  }
}

class ProfilePhotoSignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePhotoSignupController>(
      () => ProfilePhotoSignupController(),
    );
  }
}

class SelfieSignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelfieSignupController>(() => SelfieSignupController());
  }
}

class VerificationCompleteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationCompleteController>(
      () => VerificationCompleteController(),
    );
  }
}

class RoleSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleSelectionController>(() => RoleSelectionController());
  }
}
