import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/const/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/driver_onboarding_controller.dart';
import '../widgets/driver_onboarding_shell.dart';

class DriverLicenseView extends GetView<DriverOnboardingController> {
  const DriverLicenseView({super.key});

  static const String _heroAsset =
      'assets/ChatGPT Image May 13, 2026, 12_02_32 AM.png';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DriverOnboardingShell(
      step: 1,
      title: 'driver_flow.license_title'.tr,
      onBack: () => Get.back<void>(),
      body: Obx(
        () => AbsorbPointer(
          absorbing: controller.isLockedAfterSubmit,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(
                  aspectRatio: 16 / 11,
                  child: Image.asset(
                    _heroAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => ColoredBox(
                      color: TripMatesColors.sky.withValues(alpha: 0.5),
                      child: Icon(
                        Icons.badge_outlined,
                        size: 64,
                        color: TripMatesColors.blue.withValues(alpha: 0.45),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Obx(
                        () => _LicenseUploadSlot(
                          label: 'driver_flow.upload_front'.tr,
                          imagePath: controller.licenseFrontPath.value,
                          onTap: () =>
                              controller.pickLicenseImage(context, front: true),
                          scheme: scheme,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => _LicenseUploadSlot(
                          label: 'driver_flow.upload_back'.tr,
                          imagePath: controller.licenseBackPath.value,
                          onTap: () =>
                              controller.pickLicenseImage(context, front: false),
                          scheme: scheme,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomBar: Obx(
        () => DriverNavyCta(
          label: 'driver_flow.continue'.tr,
          enabled: controller.canContinueLicense,
          onPressed: controller.canContinueLicense
              ? () => Get.toNamed<void>(Routes.DRIVER_RC)
              : null,
        ),
      ),
    );
  }
}

class _LicenseUploadSlot extends StatelessWidget {
  const _LicenseUploadSlot({
    required this.label,
    required this.imagePath,
    required this.onTap,
    required this.scheme,
    required this.isDark,
  });

  final String label;
  final String? imagePath;
  final VoidCallback onTap;
  final ColorScheme scheme;
  final bool isDark;

  bool get hasImage => imagePath != null && imagePath!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark
          ? scheme.surfaceContainerHighest.withValues(alpha: 0.35)
          : TripMatesColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: hasImage
                  ? TripMatesColors.green.withValues(alpha: 0.55)
                  : scheme.outline.withValues(alpha: isDark ? 0.35 : 0.22),
              width: hasImage ? 1.8 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              if (hasImage) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(imagePath!),
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? scheme.onSurface : TripMatesColors.text2,
                  ),
                ),
              ),
              if (hasImage)
                PhosphorIcon(
                  PhosphorIconsRegular.pencilSimple,
                  size: 22,
                  color: TripMatesColors.green,
                )
              else
                PhosphorIcon(
                  PhosphorIconsRegular.identificationCard,
                  size: 28,
                  color: TripMatesColors.blue.withValues(alpha: 0.75),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
