import 'package:get/get.dart';

import '../../../core/trust/trip_eligibility.dart';
import '../../../routes/app_pages.dart';

class SearchRidesController extends GetxController {
  final origin = 'Stockholm'.obs;
  final destination = 'Göteborg'.obs;
  final includeAuto = true.obs;

  void swapRoute() {
    final current = origin.value;
    origin.value = destination.value;
    destination.value = current;
  }

  Future<void> openResults() async {
    if (!TripEligibility.hasRegisteredVehicle) {
      await TripEligibility.showVehicleRequiredSheet(forDriver: false);
      return;
    }
    Get.toNamed<void>(Routes.RIDE_RESULTS);
  }
}
