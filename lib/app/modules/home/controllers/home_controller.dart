import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/trust/trip_eligibility.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    Future<void>.delayed(const Duration(milliseconds: 1200), () {
      isLoading.value = false;
    });
  }

  void openSearch() {
    Future<void>.microtask(() async {
      if (!TripEligibility.hasRegisteredVehicle) {
        await TripEligibility.showVehicleRequiredSheet(forDriver: false);
        return;
      }
      Get.toNamed<void>(Routes.SEARCH_RIDES);
    });
  }
  void openMyRides() => Get.toNamed<void>(Routes.MY_RIDES);
  void openAccount() => Get.toNamed<void>(Routes.ACCOUNT);
  void openGallery() => Get.toNamed<void>(Routes.TRIPMATES_GALLERY);
  void openMakeRide() {
    Future<void>.microtask(() async {
      if (!UserHomeNavigation.isDriver) {
        if (!TripEligibility.hasRegisteredVehicle) {
          await TripEligibility.showVehicleRequiredSheet(forDriver: false);
          return;
        }
      }
      Get.toNamed<void>(Routes.MAKE_NEW_RIDE);
    });
  }
  void openRideDetail() => Get.toNamed<void>(Routes.RIDE_DETAIL);
  void openTripHistory() => Get.toNamed<void>(Routes.TRIP_HISTORY);
  void openMyGarage() => Get.toNamed<void>(Routes.MY_GARAGE);
  void openTripPreferences() => Get.toNamed<void>(Routes.TRIP_PREFERENCES);
  void openPassengerMode() => Get.toNamed<void>(Routes.PASSENGER_MODE);
  void openPaymentsWallet() => Get.toNamed<void>(Routes.PAYMENTS_WALLET);
  void openSettings() => Get.toNamed<void>(Routes.SETTINGS);

  void openWishlist() {
    Future<void>.microtask(() async {
      if (!TripEligibility.hasRegisteredVehicle) {
        await TripEligibility.showVehicleRequiredSheet(forDriver: false);
        return;
      }
      Get.toNamed<void>(Routes.SEARCH_RIDES);
    });
  }

  void onBottomNav(int index) {
    if (index == 0) return; // Already on home
    UserHomeNavigation.handleGlobalBottomTap(index);
  }
}

