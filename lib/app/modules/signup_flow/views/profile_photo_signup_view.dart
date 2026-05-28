import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/auth/tm_auth_hero_shell.dart';
import '../../../core/widgets/tripmates/tm_components.dart';
import '../controllers/profile_photo_signup_controller.dart';
import '../widgets/signup_flow_layout.dart';

class ProfilePhotoSignupView extends GetView<ProfilePhotoSignupController> {
  const ProfilePhotoSignupView({super.key});

  static const String _defaultAvatarAsset = 'assets/user.png';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SignupFlowPageScaffold(
      step: 4,
      title: 'signup.photo.title'.tr,
      scrollable: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          Text(
            'signup.photo.hint'.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 15,
              height: 1.55,
              fontWeight: FontWeight.w400,
              color: isDark ? TripMatesColors.text4 : TripMatesColors.text3,
            ),
          ),
          const SizedBox(height: 42),
          Center(
            child: Obx(() {
              final path = controller.pickedPath.value;
              final busy = controller.busy.value;
              const double diameter = 158;
              const double borderW = 3;

              Widget avatarFill() {
                if (path != null && path.isNotEmpty) {
                  return Image.file(
                    File(path),
                    width: diameter,
                    height: diameter,
                    fit: BoxFit.cover,
                  );
                }
                return Image.asset(
                  _defaultAvatarAsset,
                  width: diameter,
                  height: diameter,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => ColoredBox(
                    color: isDark
                        ? scheme.surfaceContainerHighest
                        : TripMatesColors.off,
                    child: Icon(
                      Icons.person_rounded,
                      size: 80,
                      color: scheme.onSurface.withValues(alpha: 0.35),
                    ),
                  ),
                );
              }

              return Stack(
                alignment: Alignment.bottomRight,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(borderW),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: TripMatesColors.green.withValues(alpha: 0.65),
                        width: borderW,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: TmAuthTokens.primaryGreen.withValues(
                            alpha: 0.12,
                          ),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: SizedBox(
                        width: diameter,
                        height: diameter,
                        child: avatarFill(),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Material(
                      color: TripMatesColors.green,
                      shape: const CircleBorder(),
                      elevation: 3,
                      shadowColor: TripMatesColors.green.withValues(
                        alpha: 0.45,
                      ),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: busy
                            ? null
                            : () async {
                                await controller.pickFromCamera();
                              },
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.photo_camera_rounded,
                            color: TripMatesColors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: SignupFlowLayout.tightGap + 4),
          Obx(() {
            final busy = controller.busy.value;
            return Center(
              child: TextButton.icon(
                onPressed: busy ? null : controller.pickFromGallery,
                icon: const Icon(Icons.photo_library_outlined, size: 20),
                label: Text('signup.photo.gallery'.tr),
                style: TextButton.styleFrom(
                  foregroundColor: TmAuthTokens.primaryGreen,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: SignupFlowLayout.tightGap),
          Obx(
            () => controller.busy.value
                ? const Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      bottom: [
        TmPrimaryButton(
          label: 'signup.photo.cta'.tr,
          onPressed: controller.continueNext,
        ),
        const SizedBox(height: 12),
        Text(
          'signup.photo.tip'.tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 12,
            height: 1.45,
            color: TripMatesColors.text4,
          ),
        ),
      ],
    );
  }
}
