import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_pages.dart';
import '../../../services/local_storage_services/local_storage_services.dart';
import '../../../services/signup_flow_service/signup_flow_service.dart';

class ProfilePhotoSignupController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final pickedPath = Rxn<String>();
  final busy = false.obs;

  Future<void> pickFromGallery() async {
    await _pick(ImageSource.gallery);
  }

  Future<void> pickFromCamera() async {
    await _pick(ImageSource.camera);
  }

  Future<void> _pick(ImageSource source) async {
    busy.value = true;
    try {
      final x = await _picker.pickImage(
        source: source,
        imageQuality: 88,
        preferredCameraDevice: CameraDevice.front,
      );
      if (x == null) return;
      final len = await File(x.path).length();
      if (len < 2000) {
        Get.snackbar(
          'signup.photo.small_title'.tr,
          'signup.photo.small_msg'.tr,
        );
        return;
      }
      pickedPath.value = x.path;
      SignupFlowService.I.profilePhotoPath = x.path;
      await LocalStorageService().setProfilePhotoPath(x.path);
    } finally {
      busy.value = false;
    }
  }

  void continueNext() {
    if (pickedPath.value == null || pickedPath.value!.isEmpty) {
      Get.snackbar(
        'signup.photo.required_title'.tr,
        'signup.photo.required_msg'.tr,
      );
      return;
    }
    Get.toNamed<void>(Routes.SELFIE_VERIFY_SIGNUP);
  }
}
