import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/maps/geo_place.dart';
import '../../../core/maps/nominatim_geocode_service.dart';
import '../../../core/maps/osrm_route_client.dart';
import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/sounds/ui_sounds.dart';
import '../../../routes/app_pages.dart';
import '../../driver_shell/controllers/driver_shell_controller.dart';

class PublishRideController extends GetxController {
  late final PageController pageController;

  final stepIndex = 0.obs;

  final originPlace = Rxn<GeoPlace>();
  final destPlace = Rxn<GeoPlace>();
  final routePoints = <LatLng>[].obs;
  final routeLoading = false.obs;

  final travelDate = DateTime.now().obs;
  final pickupTime = TimeOfDay.now().obs;

  final seats = 3.obs;
  final priceController = TextEditingController(text: '600');
  final isRoundTrip = false.obs;

  final luggageOk = false.obs;
  final womenOnly = false.obs;
  final petsOk = false.obs;

  final paying = false.obs;

  /// `card` | `paypal` | `swish`
  final selectedPaymentMethod = 'card'.obs;

  Timer? _routeDebounce;

  final formRevision = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    priceController.addListener(() => formRevision.value++);
  }

  @override
  void onClose() {
    _routeDebounce?.cancel();
    pageController.dispose();
    priceController.dispose();
    super.onClose();
  }

  Future<List<GeoPlace>> searchPlaces(String query) =>
      NominatimGeocodeService.search(query);

  void setOrigin(GeoPlace p) {
    originPlace.value = p;
    _scheduleRouteFetch();
  }

  void setDestination(GeoPlace p) {
    destPlace.value = p;
    _scheduleRouteFetch();
  }

  void swapEndpoints() {
    final o = originPlace.value;
    final d = destPlace.value;
    originPlace.value = d;
    destPlace.value = o;
    _scheduleRouteFetch();
  }

  void _scheduleRouteFetch() {
    _routeDebounce?.cancel();
    _routeDebounce = Timer(const Duration(milliseconds: 400), () {
      unawaited(fetchRouteIfReady());
    });
  }

  Future<void> fetchRouteIfReady() async {
    final o = originPlace.value;
    final d = destPlace.value;
    if (o == null || d == null) {
      routePoints.clear();
      return;
    }

    final a = LatLng(o.lat, o.lon);
    final b = LatLng(d.lat, d.lon);

    routeLoading.value = true;
    try {
      final pts = await OsrmRouteClient.drivingRoute(a, b);
      routePoints.assignAll(pts);
    } catch (_) {
      routePoints.assignAll([a, b]);
    } finally {
      routeLoading.value = false;
    }
  }

  bool get canContinueRoute =>
      originPlace.value != null && destPlace.value != null && !routeLoading.value;

  bool get canContinueDetails {
    formRevision.value;
    final n = seats.value;
    if (n < 1 || n > 8) return false;
    final p = int.tryParse(priceController.text.replaceAll(RegExp(r'[^0-9]'), ''));
    return p != null && p > 0;
  }

  void setSeats(int n) => seats.value = n.clamp(1, 8);

  void onPageChanged(int i) => stepIndex.value = i;

  Future<void> animateToStep(int i) async {
    await pageController.animateToPage(
      i,
      duration: const Duration(milliseconds: 340),
      curve: Curves.easeOutCubic,
    );
    stepIndex.value = i;
  }

  Future<void> goNextFromRoute() async {
    if (!canContinueRoute) return;
    await animateToStep(1);
  }

  Future<void> goNextFromDate() async => animateToStep(2);

  Future<void> goNextFromDetails() async {
    if (!canContinueDetails) return;
    await animateToStep(3);
  }

  Future<void> goNextFromReview() async => animateToStep(4);

  void selectPaymentMethod(String id) => selectedPaymentMethod.value = id;

  Future<void> goBack() async {
    final i = stepIndex.value;
    if (i <= 0) {
      Get.back<void>();
      return;
    }
    await animateToStep(i - 1);
  }

  Future<void> handleAppBarBack() async {
    if (stepIndex.value >= 5) {
      finishToHome();
      return;
    }
    await goBack();
  }

  Future<void> pickDate(BuildContext context) async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: travelDate.value,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 2, 12, 31),
    );
    if (d != null) travelDate.value = d;
  }

  Future<void> pickTime(BuildContext context) async {
    final t = await showTimePicker(
      context: context,
      initialTime: pickupTime.value,
    );
    if (t != null) pickupTime.value = t;
  }

  DateTime get combinedDateTime {
    final d = travelDate.value;
    final t = pickupTime.value;
    return DateTime(d.year, d.month, d.day, t.hour, t.minute);
  }

  Future<void> payAndPublishRide() async {
    if (paying.value) return;
    paying.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 680));
    paying.value = false;
    unawaited(UiSounds.playSuccessChime());
    await animateToStep(5);
  }

  void finishToHome() {
    UserHomeNavigation.offAllToUserHome();
  }

  void finishToMyRidesTab() {
    if (UserHomeNavigation.isDriver) {
      Get.offAllNamed<void>(Routes.DRIVER_HOME);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Get.isRegistered<DriverShellController>()) {
          Get.find<DriverShellController>().goToTab(1);
        }
      });
    } else {
      Get.offAllNamed<void>(Routes.MY_RIDES);
    }
  }

  void finishToDriverHomeTab() {
    if (UserHomeNavigation.isDriver) {
      Get.offAllNamed<void>(Routes.DRIVER_HOME);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Get.isRegistered<DriverShellController>()) {
          Get.find<DriverShellController>().goToTab(0);
        }
      });
    } else {
      UserHomeNavigation.offAllToUserHome();
    }
  }
}
