import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/const/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/driver_onboarding_controller.dart';
import '../widgets/driver_onboarding_shell.dart';

class DriverReviewView extends GetView<DriverOnboardingController> {
  const DriverReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DriverOnboardingShell(
      step: 4,
      title: 'driver_flow.review_title'.tr,
      onBack: () => Get.back<void>(),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (controller.isLockedAfterSubmit) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: TripMatesColors.chipSuccess.withValues(alpha: isDark ? 0.35 : 0.65),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: TripMatesColors.green.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  children: [
                    PhosphorIcon(
                      PhosphorIconsFill.lockSimple,
                      size: 22,
                      color: TripMatesColors.green,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'driver_flow.review_submitted_hint'.tr,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                          color: isDark ? scheme.onSurface : TripMatesColors.text2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            _ReviewLine(
              text: 'driver_flow.review_license'.tr,
              ok: controller.licenseFrontPath.value != null &&
                  controller.licenseFrontPath.value!.isNotEmpty &&
                  controller.licenseBackPath.value != null &&
                  controller.licenseBackPath.value!.isNotEmpty,
              scheme: scheme,
              isDark: isDark,
            ),
            const SizedBox(height: 14),
            _ReviewLine(
              text: 'driver_flow.review_rc'.tr,
              ok: controller.rcImagePath.value != null &&
                  controller.rcImagePath.value!.isNotEmpty &&
                  controller.rcNumberController.text.trim().isNotEmpty,
              scheme: scheme,
              isDark: isDark,
            ),
            const SizedBox(height: 14),
            _ReviewLine(
              text: 'driver_flow.review_vehicle'.tr,
              ok: controller.canContinueVehicle,
              scheme: scheme,
              isDark: isDark,
            ),
          ],
        ),
      ),
      bottomBar: Obx(
        () {
          if (controller.isLockedAfterSubmit) {
            return DriverNavyCta(
              label: 'driver_flow.view_status'.tr,
              onPressed: () => Get.offNamed<void>(Routes.DRIVER_UNDER_REVIEW),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: TextButton(
                  onPressed: controller.canSubmitReview
                      ? controller.navigateBackToEditFromReview
                      : null,
                  child: Text(
                    'driver_flow.edit_details'.tr,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: controller.canSubmitReview
                          ? TripMatesColors.accent
                          : scheme.onSurface.withValues(alpha: 0.35),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              DriverNavyCta(
                label: 'driver_flow.submit'.tr,
                enabled: controller.canSubmitReview,
                onPressed: controller.canSubmitReview
                    ? controller.submitReviewAndContinue
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ReviewLine extends StatelessWidget {
  const _ReviewLine({
    required this.text,
    required this.ok,
    required this.scheme,
    required this.isDark,
  });

  final String text;
  final bool ok;
  final ColorScheme scheme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDark
            ? scheme.surfaceContainerHighest.withValues(alpha: 0.35)
            : TripMatesColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: scheme.outline.withValues(alpha: isDark ? 0.3 : 0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.15 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          PhosphorIcon(
            ok ? PhosphorIconsFill.checkCircle : PhosphorIconsRegular.circle,
            size: 26,
            color: ok
                ? TripMatesColors.green
                : scheme.outline.withValues(alpha: 0.45),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isDark ? scheme.onSurface : TripMatesColors.text2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
