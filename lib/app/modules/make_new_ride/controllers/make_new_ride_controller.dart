import 'package:get/get.dart';

import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/trust/trip_eligibility.dart';
import '../../../routes/app_pages.dart';

class MakeNewRideController extends GetxController {
  Future<void> openDateTime() async {
    if (!UserHomeNavigation.isDriver) {
      if (!TripEligibility.hasRegisteredVehicle) {
        await TripEligibility.showVehicleRequiredSheet(forDriver: false);
        return;
      }
    }
    Get.toNamed<void>(Routes.DATE_TIME);
  }
}

