import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/auth/tm_auth_hero_shell.dart';
import '../../../routes/app_pages.dart';
import '../controllers/driver_onboarding_controller.dart';
import '../widgets/driver_onboarding_shell.dart';

class DriverUnderReviewView extends GetView<DriverOnboardingController> {
  const DriverUnderReviewView({super.key});

  static const String _hourglassAsset = 'assets/icons/hourglass.png';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DriverOnboardingShell(
      step: 5,
      title: 'driver_flow.under_review_title'.tr,
      onBack: () => Get.back<void>(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 32),
          Center(
            child: Image.asset(
              _hourglassAsset,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.hourglass_top_rounded,
                size: 96,
                color: TripMatesColors.blue.withValues(alpha: 0.55),
              ),
            ),
          ),
          const SizedBox(height: 48),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'driver_flow.under_review_body'.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                      color: isDark ? scheme.onSurface : TripMatesColors.text2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'driver_flow.under_review_sub'.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      height: 1.5,
                      color: isDark ? TripMatesColors.text4 : TripMatesColors.text3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'driver_flow.under_review_eta'.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: scheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomBar: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () => Get.toNamed<void>(Routes.DRIVER_APPROVED),
              style: TextButton.styleFrom(
                foregroundColor: TripMatesColors.accent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              child: Text(
                'driver_flow.continue_dummy'.tr,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
