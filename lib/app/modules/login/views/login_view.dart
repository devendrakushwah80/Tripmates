import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/auth/tm_auth_hero_shell.dart';
import '../../../core/widgets/tripmates/tm_components.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final fill = Theme.of(context).colorScheme.surface;
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TmAuthHeroShell(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 12, 4),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Get.back<void>(),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: isDark
                        ? scheme.onSurface
                        : TmAuthTokens.primaryGreen,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: Text(
                    'login.title'.tr,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                      color: isDark
                          ? scheme.onSurface
                          : TmAuthTokens.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                color: TmAuthTokens.primaryGreen.withValues(
                  alpha: isDark ? 0.5 : 0.35,
                ),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
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
                  const TmAuthBrandedLogo(bottomGutter: 2),
                  const SizedBox(height: 10),
                  Text(
                    'login.subtitle'.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: isDark
                          ? scheme.onSurface.withValues(alpha: 0.65)
                          : TmAuthTokens.textSecondary,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      height: 1.45,
                      letterSpacing: 0.1,
                    ),
                  ),
                  const SizedBox(height: 18),
                  TmGlossCard(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'login.email'.tr,
                            hintText: 'login.email_hint'.tr,
                            filled: true,
                            fillColor: fill,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: PhosphorIcon(
                                PhosphorIconsRegular.envelopeSimple,
                                size: 22,
                                color: scheme.onSurface.withValues(alpha: 0.45),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Obx(
                          () => TextField(
                            controller: controller.passwordController,
                            obscureText: controller.obscurePassword.value,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: '••••••••',
                              filled: true,
                              fillColor: fill,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: PhosphorIcon(
                                  PhosphorIconsRegular.lockSimple,
                                  size: 22,
                                  color: scheme.onSurface.withValues(
                                    alpha: 0.45,
                                  ),
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: controller.toggleObscurePassword,
                                icon: PhosphorIcon(
                                  controller.obscurePassword.value
                                      ? PhosphorIconsRegular.eye
                                      : PhosphorIconsRegular.eyeSlash,
                                  size: 22,
                                  color: scheme.onSurface.withValues(
                                    alpha: 0.45,
                                  ),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () =>
                                Get.toNamed<void>(Routes.FORGOT_PASSWORD),
                            child: Text(
                              'login.forgot_password'.tr,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                color: TmAuthTokens.primaryGreen,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => TmPrimaryButton(
                            label: controller.isLoading.value
                                ? 'Please wait...'
                                : 'login.sign_in'.tr,
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.login,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 26),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: scheme.outline.withValues(alpha: 0.32),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          'common.or'.tr,
                          style: GoogleFonts.inter(
                            color: scheme.onSurface.withValues(alpha: 0.42),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            letterSpacing: 1.15,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: scheme.outline.withValues(alpha: 0.32),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _SocialAuthButton(
                          lottieAsset: 'assets/lottie/google_border.json',
                          label: 'login.google'.tr,
                          onPressed: controller.signInWithGoogle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SocialAuthButton(
                          imageAsset: 'assets/icons/icons8-apple.gif',
                          label: 'login.apple'.tr,
                          onPressed: controller.signInWithApple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: TextButton(
                      onPressed: controller.goRegister,
                      child: Text(
                        'login.new_here'.tr,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: TmAuthTokens.primaryGreen,
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

class _SocialAuthButton extends StatelessWidget {
  const _SocialAuthButton({
    this.imageAsset,
    this.lottieAsset,
    required this.label,
    required this.onPressed,
  }) : assert(
         (imageAsset != null) ^ (lottieAsset != null),
         'Use exactly one of imageAsset or lottieAsset',
       );

  final String? imageAsset;
  final String? lottieAsset;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = BorderRadius.circular(14);
    final isGif = imageAsset?.toLowerCase().endsWith('.gif') ?? false;

    return Material(
      color: Colors.transparent,
      borderRadius: r,
      child: InkWell(
        onTap: onPressed,
        borderRadius: r,
        child: Ink(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: r,
            border: Border.all(
              color: TripMatesColors.green.withValues(
                alpha: isDark ? 0.62 : 0.52,
              ),
              width: 1.35,
            ),
            boxShadow: [
              BoxShadow(
                color: TripMatesColors.blue.withValues(
                  alpha: isDark ? 0.22 : 0.07,
                ),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SizedBox(
            height: 54,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 26,
                    height: 26,
                    child: lottieAsset != null
                        ? Lottie.asset(
                            lottieAsset!,
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            repeat: true,
                            filterQuality: FilterQuality.high,
                          )
                        : Image.asset(
                            imageAsset!,
                            fit: BoxFit.contain,
                            filterQuality: isGif
                                ? FilterQuality.medium
                                : FilterQuality.high,
                          ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      letterSpacing: 0.1,
                      color: TripMatesColors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
