import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class AccountController extends GetxController {
  void openSettings() => Get.toNamed<void>(Routes.SETTINGS);
  void openCountries() => Get.toNamed<void>(Routes.COUNTRIES);
  void openEditProfile() => Get.toNamed<void>(Routes.EDIT_PROFILE);
  void openTripHistory() => Get.toNamed<void>(Routes.TRIP_HISTORY);
  void openPaymentHistory() => Get.toNamed<void>(Routes.PAYMENT_HISTORY);
  void openProfileSetup() => Get.toNamed<void>(Routes.PROFILE_SETUP);
  void openPaymentsWallet() => Get.toNamed<void>(Routes.PAYMENTS_WALLET);
}

