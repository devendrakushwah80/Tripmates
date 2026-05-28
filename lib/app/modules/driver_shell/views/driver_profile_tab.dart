import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/const/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../../../services/local_storage_services/local_storage_services.dart';

class DriverProfileTab extends StatelessWidget {
  const DriverProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.backgroundLight;
    final storage = LocalStorageService();
    final name = storage.getUserName().trim().isEmpty ? 'driver_hub.demo_name'.tr : storage.getUserName();
    final photoPath = storage.getProfilePhotoPath();

    return ColoredBox(
      color: bg,
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
          children: [
            Text(
              'driver_hub.profile_title'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.darkTextPrimary : TripMatesColors.text2,
              ),
            ),
            const SizedBox(height: 22),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: TripMatesColors.sky,
                    backgroundImage: photoPath.isNotEmpty && File(photoPath).existsSync()
                        ? FileImage(File(photoPath))
                        : null,
                    child: photoPath.isEmpty || !File(photoPath).existsSync()
                        ? PhosphorIcon(
                            PhosphorIconsRegular.user,
                            size: 48,
                            color: TripMatesColors.accent,
                          )
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkTextPrimary : TripMatesColors.text2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star_rounded, size: 20, color: TripMatesColors.warn),
                      const SizedBox(width: 4),
                      Text(
                        '4.8 (102 reviews)',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: TripMatesColors.text3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            _ProfileTile(
              icon: PhosphorIconsRegular.identificationCard,
              title: 'driver_hub.menu_docs'.tr,
              onTap: () => Get.toNamed<void>(Routes.DRIVER_IDENTITY_DETAILS),
            ),
            _ProfileTile(
              icon: PhosphorIconsRegular.car,
              title: 'driver_hub.menu_vehicle'.tr,
              onTap: () => Get.toNamed<void>(Routes.MY_GARAGE),
            ),
            _ProfileTile(
              icon: PhosphorIconsRegular.currencyCircleDollar,
              title: 'driver_hub.menu_bank'.tr,
              onTap: () => Get.toNamed<void>(Routes.BANK_DETAILS),
            ),
            _ProfileTile(
              icon: PhosphorIconsRegular.translate,
              title: 'settings.language'.tr,
              onTap: () => Get.toNamed<void>(Routes.SETTINGS),
            ),
            _ProfileTile(
              icon: PhosphorIconsRegular.gearSix,
              title: 'driver_hub.menu_settings'.tr,
              onTap: () => Get.toNamed<void>(Routes.SETTINGS),
            ),
            _ProfileTile(
              icon: PhosphorIconsRegular.question,
              title: 'driver_hub.menu_help'.tr,
              onTap: () => Get.snackbar('driver_hub.help_title'.tr, 'driver_hub.help_hint'.tr),
            ),
            const SizedBox(height: 8),
            _ProfileTile(
              icon: PhosphorIconsRegular.signOut,
              title: 'driver_hub.menu_logout'.tr,
              danger: true,
              onTap: () async {
                await LocalStorageService().logout();
                Get.offAllNamed<void>(Routes.WELCOME);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.danger = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final card = isDark ? AppColors.darkSurfaceElevated : TripMatesColors.white;
    final iconColor = danger ? TripMatesColors.error : scheme.onSurface.withValues(alpha: 0.55);
    final textColor = danger ? TripMatesColors.error : scheme.onSurface;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: card,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                PhosphorIcon(icon, size: 22, color: iconColor),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: scheme.onSurface.withValues(alpha: 0.3)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
