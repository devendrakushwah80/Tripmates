import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/navigation/user_home_navigation.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_service.dart';
import '../../../services/local_storage_services/local_storage_services.dart';
import '../../../services/social_auth_service/social_auth_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool obscurePassword = true.obs;
  final RxBool isLoading = false.obs;

  SocialAuthService get _social => Get.find<SocialAuthService>();

  void toggleObscurePassword() => obscurePassword.toggle();

  bool _isValidEmail(String value) {
    final v = value.trim();
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v);
  }

  Future<void> login() async {
    if (isLoading.value) return;

    final email = emailController.text.trim();
    final password = passwordController.text;

    if (!_isValidEmail(email)) {
      Get.snackbar('Invalid email', 'Enter a valid email address.');
      return;
    }

    if (password.isEmpty) {
      Get.snackbar('Password required', 'Enter your password.');
      return;
    }

    isLoading.value = true;
    try {
      final result = await ApiService().login(email: email, password: password);

      if (!result.ok) {
        Get.snackbar('Login failed', result.message);
        return;
      }

      // Save local login state so splash/auto-login checks can find a session.
      final data = result.data;
      final user = data['user'] is Map
          ? Map<String, dynamic>.from(data['user'] as Map)
          : data;
      final token =
          '${data['token'] ?? data['auth_token'] ?? 'php_login:$email'}';

      await LocalStorageService().setAuthToken(token);
      await LocalStorageService().setEmailId('${user['email'] ?? email}');
      await LocalStorageService().setUserName('${user['name'] ?? ''}'.trim());
      if (user['id'] != null) {
        await LocalStorageService().setUserId('${user['id']}');
      }

      Get.snackbar('Success', result.message);
      UserHomeNavigation.offAllToUserHome();
    } catch (e) {
      Get.snackbar('Login failed', 'Unexpected error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void goRegister() {
    Get.toNamed<void>(Routes.REGISTER);
  }

  Future<void> signInWithGoogle() => _social.signInWithGoogle();

  Future<void> signInWithApple() => _social.signInWithApple();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
