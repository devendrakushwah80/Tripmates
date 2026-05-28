import 'package:get/get.dart';

import '../../../services/settings_service/settings_service.dart';

class SettingsController extends GetxController {
  void setEnglish() => Get.find<SettingsService>().applyLanguage('en');
  void setSwedish() => Get.find<SettingsService>().applyLanguage('sv');
  void setArabic() => Get.find<SettingsService>().applyLanguage('ar');
}

