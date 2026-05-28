import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

import '../../../routes/app_pages.dart';
import '../../../services/local_storage_services/local_storage_services.dart';
import '../../../services/signup_flow_service/signup_flow_service.dart';
import '../views/selfie_camera_view.dart';

class SelfieSignupController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final selfiePath = Rxn<String>();
  final busy = false.obs;

  Future<void> captureSelfie() async {
    final xFile = await Get.to<XFile>(() => const SelfieCameraView());
    if (xFile == null) return;
    await _handlePickedFile(xFile);
  }

  Future<void> _handlePickedFile(XFile x) async {
    busy.value = true;
    try {
      final len = await File(x.path).length();
      if (len < 2000) {
        Get.snackbar(
          'signup.selfie.small_title'.tr,
          'signup.selfie.small_msg'.tr,
        );
        return;
      }
      selfiePath.value = x.path;
      SignupFlowService.I.selfiePath = x.path;
      await LocalStorageService().setSelfieVerificationPaths(x.path);
      await LocalStorageService().setSelfieVerified(true);
    } finally {
      busy.value = false;
    }
  }

  Future<void> _pick(ImageSource source) async {
    if (source == ImageSource.camera) {
      await captureSelfie();
      return;
    }
    busy.value = true;
    try {
      final x = await _picker.pickImage(
        source: source,
        imageQuality: 82,
        preferredCameraDevice: CameraDevice.front,
      );
      if (x == null) return;
      await _handlePickedFile(x);
    } finally {
      busy.value = false;
    }
  }

  void continueNext() {
    if (selfiePath.value == null || selfiePath.value!.isEmpty) {
      Get.snackbar(
        'signup.selfie.required_title'.tr,
        'signup.selfie.required_msg'.tr,
      );
      return;
    }
    Get.toNamed<void>(Routes.VERIFICATION_COMPLETE);
  }
}
