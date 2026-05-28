import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class OtpVerifyController extends GetxController {
  static const String demoValidOtp = '123456';

  final TextEditingController hiddenInput = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final code = ''.obs;
  final isFocused = false.obs;

  @override
  void onInit() {
    super.onInit();
    hiddenInput.addListener(_syncDigits);
    focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    isFocused.value = focusNode.hasFocus;
  }

  void _syncDigits() {
    final raw = hiddenInput.text.replaceAll(RegExp(r'\D'), '');
    final clipped = raw.length > 6 ? raw.substring(0, 6) : raw;
    if (clipped != hiddenInput.text) {
      hiddenInput.value = TextEditingValue(
        text: clipped,
        selection: TextSelection.collapsed(offset: clipped.length),
      );
    }
    code.value = clipped;
  }

  void verify() {
    if (code.value != demoValidOtp) {
      Get.snackbar(
        'otp.err_invalid_title'.tr,
        'otp.err_invalid_msg'.tr,
      );
      return;
    }
    Get.toNamed<void>(Routes.EMAIL_VERIFY);
  }

  @override
  void onClose() {
    hiddenInput.removeListener(_syncDigits);
    hiddenInput.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
