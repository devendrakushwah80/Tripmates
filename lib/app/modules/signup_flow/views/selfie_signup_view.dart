import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/auth/tm_auth_hero_shell.dart';
import '../../../core/widgets/tripmates/tm_components.dart';
import '../controllers/selfie_signup_controller.dart';
import '../widgets/signup_flow_layout.dart';

class SelfieSignupView extends GetView<SelfieSignupController> {
  const SelfieSignupView({super.key});

  static const String _lottiePath = 'assets/lottie/facial recognition.json';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;

    return SignupFlowPageScaffold(
      step: 5,
      title: 'signup.selfie.title'.tr,
      scrollable: LayoutBuilder(
        builder: (context, constraints) {
          final side = math.min(
            (constraints.maxHeight * 0.38).clamp(168.0, 248.0),
            constraints.maxWidth * 0.9,
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: side,
                  height: side,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDark
                            ? scheme.outline.withValues(alpha: 0.35)
                            : TripMatesColors.divider.withValues(alpha: 0.9),
                        width: 1,
                      ),
                      color: isDark
                          ? TripMatesColors.blueDark.withValues(alpha: 0.28)
                          : TripMatesColors.off,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(23),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Obx(() {
                          final path = controller.selfiePath.value;
                          final busy = controller.busy.value;
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              if (path != null && path.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    File(path),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              else
                                Lottie.asset(
                                  _lottiePath,
                                  fit: BoxFit.contain,
                                  alignment: Alignment.center,
                                  repeat: true,
                                  filterQuality: FilterQuality.high,
                                ),
                              if (busy)
                                ColoredBox(
                                  color: Colors.black.withValues(alpha: 0.12),
                                  child: const Center(
                                    child: SizedBox(
                                      width: 28,
                                      height: 28,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: TripMatesColors.green,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'signup.selfie.subtitle'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                  color: isDark ? TripMatesColors.text4 : TripMatesColors.text3,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'signup.selfie.instructions_title'.tr,
                textAlign: TextAlign.start,
                style: GoogleFonts.lexend(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                  color: isDark ? TripMatesColors.white : TripMatesColors.text2,
                ),
              ),
              const SizedBox(height: 12),
              _Bullet(text: 'signup.selfie.bullet_1'.tr, isDark: isDark),
              const SizedBox(height: 8),
              _Bullet(text: 'signup.selfie.bullet_2'.tr, isDark: isDark),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
      bottom: [
        Obx(() {
          final has = controller.selfiePath.value != null &&
              controller.selfiePath.value!.isNotEmpty;
          final busy = controller.busy.value;
          return TmPrimaryButton(
            label: (has
                    ? 'signup.selfie.cta_continue'
                    : 'signup.selfie.cta_capture')
                .tr,
            onPressed: busy
                ? null
                : (has ? controller.continueNext : controller.captureSelfie),
          );
        }),
      ],
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text, required this.isDark});

  final String text;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: TripMatesColors.green.withValues(alpha: 0.88),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14,
              height: 1.55,
              fontWeight: FontWeight.w400,
              color: isDark ? TripMatesColors.text4 : TripMatesColors.text3,
            ),
          ),
        ),
      ],
    );
  }
}
