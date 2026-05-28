import 'dart:async';

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class LiveTripController extends GetxController {
  final Rx<LatLng> driver = LatLng(59.332, 18.04).obs;

  static final List<LatLng> _path = [
    LatLng(59.332, 18.04),
    LatLng(59.338, 18.03),
    LatLng(59.345, 18.025),
    LatLng(59.352, 18.015),
    LatLng(59.358, 18.005),
    LatLng(59.365, 17.995),
    LatLng(59.375, 17.98),
    LatLng(59.385, 17.965),
    LatLng(59.395, 17.95),
  ];

  Timer? _timer;
  int _i = 0;

  @override
  void onInit() {
    super.onInit();
    _timer = Timer.periodic(const Duration(milliseconds: 850), (_) {
      _i = (_i + 1) % _path.length;
      driver.value = _path[_i];
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
