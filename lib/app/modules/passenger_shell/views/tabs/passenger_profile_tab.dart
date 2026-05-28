import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../routes/app_pages.dart';
import '../../../../services/local_storage_services/local_storage_services.dart';
import '../../controllers/passenger_flow_controller.dart';
import '../../controllers/passenger_shell_controller.dart';
import '../../theme/passenger_shell_theme.dart';

class PassengerProfileTab extends StatelessWidget {
  const PassengerProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final flow = Get.find<PassengerFlowController>();
    final photo = LocalStorageService().getProfilePhotoPath();
    final hasPhoto = photo.isNotEmpty && File(photo).existsSync();
    return ColoredBox(
      color: PassengerShellTheme.screenBg,
      child: ListView(
        padding: EdgeInsets.fromLTRB(18, PassengerShellTheme.topContentPadding(context), 18, 28),
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 44,
                  backgroundColor: PassengerShellTheme.softGreenBg,
                  backgroundImage: hasPhoto ? FileImage(File(photo)) : null,
                  child: !hasPhoto ? PhosphorIcon(PhosphorIconsRegular.user, size: 44, color: PassengerShellTheme.primaryGreen) : null,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  flow.personalName.text.isEmpty ? 'Rahul Jain' : flow.personalName.text,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lexend(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: PassengerShellTheme.textPrimary,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: PassengerShellTheme.softGreenBg,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PhosphorIcon(PhosphorIconsRegular.sealCheck, color: PassengerShellTheme.primaryGreen, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'passenger_profile.verified'.tr,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: PassengerShellTheme.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          _Menu(icon: PhosphorIconsRegular.userCircle, title: 'passenger_profile.personal'.tr, onTap: () => Get.toNamed<void>(Routes.PASSENGER_PERSONAL_DETAILS)),
          _Menu(icon: PhosphorIconsRegular.translate, title: 'settings.language'.tr, onTap: () => Get.toNamed<void>(Routes.SETTINGS)),
          _Menu(icon: PhosphorIconsRegular.car, title: 'passenger_profile.my_rides'.tr, onTap: () => Get.find<PassengerShellController>().goToTab(2)),
          _Menu(icon: PhosphorIconsRegular.shieldCheck, title: 'passenger_profile.safety'.tr, onTap: () => Get.find<PassengerShellController>().goToTab(3)),
          _Menu(icon: PhosphorIconsRegular.lifebuoy, title: 'passenger_profile.support'.tr, onTap: () => Get.toNamed<void>(Routes.PASSENGER_SUPPORT)),
          _Menu(icon: PhosphorIconsRegular.fileText, title: 'passenger_profile.terms'.tr, onTap: () => Get.toNamed<void>(Routes.TERMS)),
          _Menu(icon: PhosphorIconsRegular.lockKey, title: 'passenger_profile.privacy'.tr, onTap: () => Get.toNamed<void>(Routes.PRIVACY)),
          const SizedBox(height: 8),
          _Menu(
            icon: PhosphorIconsRegular.signOut,
            title: 'passenger_profile.logout'.tr,
            danger: true,
            onTap: () async {
              await LocalStorageService().logout();
              Get.offAllNamed<void>(Routes.WELCOME);
            },
          ),
        ],
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  const _Menu({required this.icon, required this.title, required this.onTap, this.danger = false});

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final c = danger ? PassengerShellTheme.danger : PassengerShellTheme.primaryGreen;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: PassengerShellTheme.cardWhite,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                PhosphorIcon(icon, color: c, size: 22),
                const SizedBox(width: 12),
                Expanded(child: Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15, color: danger ? c : PassengerShellTheme.textPrimary))),
                PhosphorIcon(PhosphorIconsRegular.caretRight, color: PassengerShellTheme.textSecondary, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
