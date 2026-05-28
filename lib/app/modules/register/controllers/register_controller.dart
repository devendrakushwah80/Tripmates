import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../services/api_service.dart';
import '../../../services/local_storage_services/local_storage_services.dart';
import '../../../services/signup_flow_service/signup_flow_service.dart';
import '../../../services/social_auth_service/social_auth_service.dart';

class RegisterController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final agreed = false.obs;
  final isLoading = false.obs;

  SocialAuthService get _social => Get.find<SocialAuthService>();

  void toggleAgree(bool? v) => agreed.value = v ?? false;

  bool _isValidEmail(String value) {
    final v = value.trim();
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v);
  }

  Future<void> register() async {
    if (isLoading.value) return;

    final name = fullNameController.text.trim();
    if (name.isEmpty) {
      Get.snackbar('register.err_name'.tr, 'register.err_name_msg'.tr);
      return;
    }

    final email = emailController.text.trim();
    if (!_isValidEmail(email)) {
      Get.snackbar('register.err_email'.tr, 'register.err_email_msg'.tr);
      return;
    }

    final phone = phoneController.text.trim();
    final digits = phone.replaceAll(RegExp(r'\s'), '');
    if (digits.length < 8) {
      Get.snackbar('register.err_phone'.tr, 'register.err_phone_msg'.tr);
      return;
    }

    final pw = passwordController.text;
    if (pw.length < 8) {
      Get.snackbar('register.err_password'.tr, 'register.err_password_msg'.tr);
      return;
    }

    if (!agreed.value) {
      Get.snackbar('register.err_consent'.tr, 'register.err_consent_msg'.tr);
      return;
    }

    isLoading.value = true;
    try {
      final result = await ApiService().register(
        name: name,
        email: email,
        phone: phone,
        password: pw,
      );

      if (!result.ok) {
        Get.snackbar('Registration failed', result.message);
        return;
      }

      // Keep the existing signup flow data available for later signup screens.
      SignupFlowService.ensureRegistered();
      final flow = SignupFlowService.I;
      flow.fullName.value = name;
      flow.email.value = email;
      flow.phone.value = phone;
      flow.password.value = pw;

      await LocalStorageService().setLegalGateAccepted(true);
      await LocalStorageService().setEmailId(email);
      await LocalStorageService().setUserName(name);
      await LocalStorageService().setUserPhone(phone);

      Get.snackbar('Success', result.message);
      Get.toNamed<void>(Routes.OTP_VERIFY);
    } catch (e) {
      Get.snackbar('Registration failed', 'Unexpected error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() => _social.signInWithGoogle();

  Future<void> signInWithApple() => _social.signInWithApple();

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
