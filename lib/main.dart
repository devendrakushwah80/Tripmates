import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'app/core/theme/app_theme.dart';
import 'app/core/translations/app_translations.dart';
import 'app/routes/app_pages.dart';
import 'app/services/local_storage_services/local_storage_services.dart';
import 'app/services/settings_service/settings_service.dart';
import 'app/services/social_auth_service/social_auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();
  await Get.putAsync(() => SettingsService().init());
  await Get.putAsync(() => SocialAuthService().init());
  runApp(const TripMatesApp());
}

class TripMatesApp extends StatelessWidget {
  const TripMatesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Get.find<SettingsService>();
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TripMates',
        translations: AppTranslations(),
        locale: settings.locale.value,
        fallbackLocale: const Locale('en', 'US'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('sv', 'SE'),
          Locale('ar', 'SA'),
        ],
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: settings.themeMode.value,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  }
}

