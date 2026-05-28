import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/widgets/tripmates/tm_bottom_nav.dart';
import '../../../routes/app_pages.dart';
import '../../../services/local_storage_services/local_storage_services.dart';
import '../../../services/settings_service/settings_service.dart';
import '../../../core/widgets/tripmates/tm_components.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../controllers/settings_controller.dart';

class SettingsScreenContent extends StatelessWidget {
  const SettingsScreenContent({
    super.key,
    this.showBack = false,
    this.controller,
  });

  final bool showBack;
  final SettingsController? controller;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        TmMintAppBar(title: 'settings.title'.tr, showBack: showBack),
        Expanded(
          child: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              children: [
                TmTile(
                  icon: Icons.notifications_none,
                  title: 'settings.notifications'.tr,
                  onTap: () => Get.snackbar(
                    'settings.notifications'.tr,
                    'settings.notifications_hint'.tr,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Text(
                    'settings.appearance'.tr,
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                      color: scheme.onSurface.withValues(alpha: 0.45),
                    ),
                  ),
                ),
                Obx(() {
                  final mode = Get.find<SettingsService>().themeMode.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SegmentedButton<ThemeMode>(
                      segments: [
                        ButtonSegment(
                          value: ThemeMode.light,
                          label: Text('settings.theme_light'.tr),
                          icon: const Icon(Icons.light_mode_outlined, size: 18),
                        ),
                        ButtonSegment(
                          value: ThemeMode.system,
                          label: Text('settings.theme_auto'.tr),
                          icon: const Icon(
                            Icons.phone_iphone_outlined,
                            size: 18,
                          ),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          label: Text('settings.theme_dark'.tr),
                          icon: const Icon(Icons.dark_mode_outlined, size: 18),
                        ),
                      ],
                      selected: {mode},
                      onSelectionChanged: (s) {
                        if (s.isEmpty) return;
                        Get.find<SettingsService>().setThemeMode(s.first);
                      },
                    ),
                  );
                }),
                const Divider(height: 1),
                TmTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'settings.privacy'.tr,
                  onTap: () => Get.toNamed<void>(Routes.PRIVACY),
                ),
                TmTile(
                  icon: Icons.article_outlined,
                  title: 'settings.terms'.tr,
                  onTap: () => Get.toNamed<void>(Routes.TERMS),
                ),
                TmTile(
                  icon: Icons.help_outline_rounded,
                  title: 'settings.help_center'.tr,
                  onTap: () => Get.snackbar(
                    'settings.help_center'.tr,
                    'settings.help_hint'.tr,
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(
                    Icons.language,
                    color: TripMatesColors.green,
                  ),
                  title: Text('settings.language'.tr),
                  subtitle: Text(Get.locale?.toLanguageTag() ?? 'en-US'),
                  trailing: Text(
                    'settings.change'.tr,
                    style: TextStyle(color: scheme.primary),
                  ),
                ),
                ListTile(
                  title: Text('language.english'.tr),
                  onTap: controller?.setEnglish,
                ),
                ListTile(
                  title: Text('language.swedish'.tr),
                  onTap: controller?.setSwedish,
                ),
                ListTile(
                  title: Text('language.arabic'.tr),
                  onTap: controller?.setArabic,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: TripMatesColors.error,
                  ),
                  title: Text(
                    'settings.logout'.tr,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                      color: TripMatesColors.error,
                    ),
                  ),
                  onTap: () async {
                    await LocalStorageService().logout();
                    Get.offAllNamed<void>(Routes.WELCOME);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SettingsScreenContent(showBack: true, controller: controller),
      ),
      bottomNavigationBar: TmBottomNav(
        selectedIndex: 4,
        onTap: UserHomeNavigation.handleGlobalBottomTap,
      ),
    );
  }
}
