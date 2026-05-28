import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/auth/tm_auth_hero_shell.dart';
import '../../../core/widgets/tripmates/tm_components.dart';
import '../../../routes/app_pages.dart';
import '../../signup_flow/widgets/signup_step_header.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  InputDecoration _fieldDecoration(
    BuildContext context, {
    required String label,
    required String hint,
    bool obscure = false,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: isDark
          ? scheme.surfaceContainerHighest.withValues(alpha: 0.35)
          : TripMatesColors.white,
      labelStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 13,
        color: scheme.onSurface.withValues(alpha: 0.65),
      ),
      hintStyle: GoogleFonts.inter(color: TripMatesColors.text4, fontSize: 15),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: scheme.outline.withValues(alpha: 0.35)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: scheme.outline.withValues(alpha: 0.28)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: TripMatesColors.green, width: 1.6),
      ),
      suffixIcon: obscure
          ? Icon(
              Icons.visibility_outlined,
              color: scheme.onSurface.withValues(alpha: 0.45),
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;

    return TmAuthHeroShell(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SignupStepHeader(step: 1, title: 'register.title'.tr),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                TmAuthLayout.hPad,
                TmAuthLayout.topPad,
                TmAuthLayout.hPad,
                TmAuthLayout.bodyBottomPad,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.fullNameController,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: scheme.onSurface,
                    ),
                    decoration: _fieldDecoration(
                      context,
                      label: 'register.full_name'.tr,
                      hint: 'register.full_name_hint'.tr,
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: scheme.onSurface,
                    ),
                    decoration: _fieldDecoration(
                      context,
                      label: 'register.email'.tr,
                      hint: 'login.email_hint'.tr,
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: controller.phoneController,
                    keyboardType: TextInputType.phone,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: scheme.onSurface,
                    ),
                    decoration: _fieldDecoration(
                      context,
                      label: 'register.phone'.tr,
                      hint: 'register.phone_hint'.tr,
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: controller.passwordController,
                    obscureText: true,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: scheme.onSurface,
                    ),
                    decoration: _fieldDecoration(
                      context,
                      label: 'register.password'.tr,
                      hint: 'register.password_hint'.tr,
                      obscure: true,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Obx(
                    () => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 26,
                          height: 26,
                          child: Checkbox(
                            value: controller.agreed.value,
                            onChanged: controller.toggleAgree,
                            activeColor: TripMatesColors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            side: BorderSide(
                              color: TripMatesColors.green.withValues(
                                alpha: 0.85,
                              ),
                              width: 1.8,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                height: 1.55,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : TripMatesColors.text3,
                              ),
                              children: [
                                TextSpan(text: 'register.agree_intro'.tr),
                                TextSpan(
                                  text: 'register.terms'.tr,
                                  style: const TextStyle(
                                    color: TripMatesColors.accent,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        Get.toNamed<void>(Routes.RULES),
                                ),
                                TextSpan(text: 'register.agree_between'.tr),
                                TextSpan(
                                  text: 'register.privacy'.tr,
                                  style: const TextStyle(
                                    color: TripMatesColors.accent,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        Get.toNamed<void>(Routes.PRIVACY),
                                ),
                                TextSpan(text: 'register.agree_end'.tr),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Obx(
                    () => TmPrimaryButton(
                      label: controller.isLoading.value
                          ? 'Please wait...'
                          : 'register.create'.tr,
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.register,
                    ),
                  ),
                  Obx(
                    () => controller.isLoading.value
                        ? const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: LinearProgressIndicator(minHeight: 2),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () => Get.back<void>(),
                      child: Text(
                        'register.have_account'.tr,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: TripMatesColors.accent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
