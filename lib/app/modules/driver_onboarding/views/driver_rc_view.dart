import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/const/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/driver_onboarding_controller.dart';
import '../widgets/driver_onboarding_shell.dart';

class DriverRcView extends GetView<DriverOnboardingController> {
  const DriverRcView({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fill = scheme.surface;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DriverOnboardingShell(
      step: 2,
      title: 'driver_flow.rc_title'.tr,
      onBack: () => Get.back<void>(),
      body: Obx(
        () {
          final locked = controller.isLockedAfterSubmit;
          return AbsorbPointer(
            absorbing: locked,
            child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'driver_flow.rc_number_label'.tr,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? scheme.onSurface : TripMatesColors.text3,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller.rcNumberController,
            readOnly: locked,
            textCapitalization: TextCapitalization.characters,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: fill,
              hintText: 'driver_flow.rc_number_hint'.tr,
              hintStyle: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                color: scheme.onSurface.withValues(alpha: 0.38),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(height: 26),
          Text(
            'driver_flow.rc_upload_label'.tr,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? scheme.onSurface : TripMatesColors.text3,
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Obx(
                () {
                  final path = controller.rcImagePath.value;
                  final has = path != null && path.isNotEmpty;
                  return Material(
                    color: isDark
                        ? scheme.surfaceContainerHighest.withValues(alpha: 0.25)
                        : const Color(0xFFF0F4F8),
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: locked ? null : () => controller.pickRcImage(context),
                      borderRadius: BorderRadius.circular(20),
                      child: Ink(
                        height: 204,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: has
                                ? TripMatesColors.green.withValues(alpha: 0.5)
                                : scheme.outline.withValues(alpha: 0.25),
                            width: has ? 2 : 1,
                          ),
                        ),
                        child: has
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.file(
                                      File(path),
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      right: 12,
                                      top: 12,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(alpha: 0.45),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: PhosphorIcon(
                                            PhosphorIconsRegular.pencilSimple,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      PhosphorIcon(
                                        PhosphorIconsRegular.fileArrowUp,
                                        size: 52,
                                        color: TripMatesColors.blue.withValues(alpha: 0.65),
                                      ),
                                      const SizedBox(height: 14),
                                      Text(
                                        'driver_flow.rc_tap_upload'.tr,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          height: 1.35,
                                          color: isDark
                                              ? scheme.onSurface.withValues(alpha: 0.78)
                                              : TripMatesColors.text3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
          );
        },
      ),
      bottomBar: GetBuilder<DriverOnboardingController>(
        id: 'rc',
        builder: (c) => DriverNavyCta(
          label: 'driver_flow.continue'.tr,
          enabled: c.canContinueRc,
          onPressed: c.canContinueRc
              ? () => Get.toNamed<void>(Routes.DRIVER_VEHICLE)
              : null,
        ),
      ),
    );
  }
}
