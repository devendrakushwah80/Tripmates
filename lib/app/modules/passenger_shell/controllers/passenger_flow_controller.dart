import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/maps/geo_place.dart';
import '../../../routes/app_pages.dart';
import '../../../services/local_storage_services/local_storage_services.dart';
import 'passenger_shell_controller.dart';
import '../widgets/passenger_place_picker_sheet.dart';

/// Shared dummy state for passenger booking flow (no backend).
class PassengerFlowController extends GetxController {
  final origin = 'Jaipur, Rajasthan'.obs;
  final destination = 'Delhi, NCR'.obs;
  final travelDate = DateTime.now().add(const Duration(days: 2)).obs;

  final driverName = 'Rahul Verma'.obs;
  final driverRating = 4.8.obs;
  final vehicleName = 'Maruti Swift Dzire'.obs;
  final vehiclePlate = 'RJ 14 CB 2044'.obs;
  final departureTime = '06:30 AM'.obs;
  final seatsLeft = 3.obs;
  final pricePerSeat = 150.obs;
  final etaLabel = '~4h 20m'.obs;

  final selectedSeats = 1.obs;
  final bookingId = 'TM-2026-0514-8842'.obs;

  final reviewStars = 0.obs;
  final reviewChips = RxMap<String, bool>({
    'safe': false,
    'clean': false,
    'friendly': false,
    'ontime': false,
  });

  final TextEditingController reviewComment = TextEditingController();

  final TextEditingController personalName = TextEditingController();
  final TextEditingController personalEmail = TextEditingController();
  final TextEditingController personalPhone = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final s = LocalStorageService();
    personalName.text = s.getUserName().trim().isEmpty ? 'Rahul Jain' : s.getUserName();
    personalEmail.text = s.getEmailId().trim().isEmpty ? 'rahul@example.com' : s.getEmailId();
    personalPhone.text = s.getUserPhone();
  }

  @override
  void onClose() {
    reviewComment.dispose();
    personalName.dispose();
    personalEmail.dispose();
    personalPhone.dispose();
    super.onClose();
  }

  String get dateLabel => DateFormat.yMMMd().format(travelDate.value);

  void swapRoute() {
    final a = origin.value;
    origin.value = destination.value;
    destination.value = a;
  }

  Future<void> openPlacePicker(bool forOrigin) async {
    final p = await Get.bottomSheet<GeoPlace>(
      PassengerPlacePickerSheet(forOrigin: forOrigin),
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
    if (p == null) return;
    if (forOrigin) {
      origin.value = p.displayName;
    } else {
      destination.value = p.displayName;
    }
  }

  Future<void> pickTravelDate() async {
    final ctx = Get.context;
    if (ctx == null || !ctx.mounted) return;
    final d = await showDatePicker(
      context: ctx,
      initialDate: travelDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (d != null) travelDate.value = d;
  }

  void setSeats(int n) => selectedSeats.value = n.clamp(1, seatsLeft.value);

  void toggleReviewChip(String key) {
    reviewChips[key] = !(reviewChips[key] ?? false);
    reviewChips.refresh();
  }

  Future<void> savePersonalDetails() async {
    final s = LocalStorageService();
    await s.setUserName(personalName.text.trim());
    await s.setEmailId(personalEmail.text.trim());
    await s.setUserPhone(personalPhone.text.trim());
    Get.snackbar('passenger_flow.saved'.tr, 'passenger_flow.saved_hint'.tr);
  }

  void goRideResults() => Get.toNamed<void>(Routes.PASSENGER_RIDE_RESULTS);

  void goRideDetail() => Get.toNamed<void>(Routes.PASSENGER_RIDE_DETAIL);

  void goBookRide() => Get.toNamed<void>(Routes.PASSENGER_BOOK_RIDE);

  /// Pops the booking / trip stack when possible; otherwise returns to the shell
  /// on the tab the user was on (so bottom tabs feel consistent).
  void popFlowOrShell() {
    final nav = Get.key.currentState;
    if (nav != null && nav.canPop()) {
      Get.back<void>();
      return;
    }
    var tab = 0;
    if (Get.isRegistered<PassengerShellController>()) {
      tab = Get.find<PassengerShellController>().tabIndex.value;
    }
    goPassengerShellTab(tab);
  }

  Future<void> confirmBooking() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    Get.offNamed<void>(Routes.PASSENGER_BOOKING_CONFIRMED);
  }

  /// Keep [Routes.PASSENGER_SHELL] under this route so back returns to the tab shell.
  void goTripProgress() => Get.toNamed<void>(Routes.PASSENGER_TRIP_PROGRESS);

  void goLiveTracking() => Get.toNamed<void>(Routes.PASSENGER_LIVE_TRACKING);

  /// Replace confirmation with live map; stack below (e.g. shell → … → book) stays intact.
  void trackRideFromBooking() => Get.offNamed<void>(Routes.PASSENGER_LIVE_TRACKING);

  void viewMyRidesAfterBooking() => goPassengerShellTab(2);

  void goPassengerShellTab(int tab) {
    Get.offAllNamed<void>(Routes.PASSENGER_SHELL, arguments: {'tab': tab});
  }

  /// Replace live tracking only so back can return through the trip stack when needed.
  void goTripCompleted() => Get.offNamed<void>(Routes.PASSENGER_TRIP_COMPLETED);

  void goReviewDriver() => Get.toNamed<void>(Routes.PASSENGER_REVIEW_DRIVER);

  void finishReviewToShell() {
    Get.offAllNamed<void>(Routes.PASSENGER_SHELL, arguments: {'tab': 2});
  }

  Future<void> submitReview() async {
    await Future<void>.delayed(const Duration(milliseconds: 320));
    finishReviewToShell();
  }

  void goSafetyShare() => Get.toNamed<void>(Routes.PASSENGER_SAFETY_SHARE);

  void goSafetyEmergency() => Get.toNamed<void>(Routes.PASSENGER_SAFETY_EMERGENCY);

  void goSafetySos() => Get.toNamed<void>(Routes.PASSENGER_SAFETY_SOS);

  void snackImSafe() {
    Get.snackbar('passenger_trip.im_safe'.tr, 'passenger_safety.im_safe_hint'.tr);
  }

  void dummyShareTrip() {
    Get.snackbar('passenger_live.share'.tr, 'passenger_share.sub'.tr);
  }

  void dummyCallDriver() {
    Get.snackbar('passenger_live.call'.tr, 'passenger_emergency.sub'.tr);
  }

  void dummyShareLocation() {
    Get.snackbar('passenger_share.cta'.tr, 'passenger_share.sub'.tr);
  }

  void dummyEmergencyCall() {
    Get.snackbar('passenger_emergency.call'.tr, '+46 70 000 00 00');
  }

  void dummySosSend() {
    Get.snackbar('passenger_sos.send'.tr, 'passenger_sos.sub'.tr);
  }

  void dummySosCancel() {
    Get.snackbar('passenger_sos.cancel'.tr, 'common.ok'.tr);
    popFlowOrShell();
  }

  void dummySupport(String key) {
    Get.snackbar(key.tr, 'passenger_search.pick_hint'.tr);
  }
}
