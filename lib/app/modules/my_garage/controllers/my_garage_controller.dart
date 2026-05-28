import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/local_storage_services/local_storage_services.dart';

class MyGarageController extends GetxController {
  final _picker = ImagePicker();

  final seats = 6.obs;
  final colorController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final prefs = LocalStorageService();
    final seatStr = prefs.getDriverSeatDisplay().trim();
    seats.value = int.tryParse(seatStr) ?? 6;
    colorController.text = prefs.getVehicleColorDisplay();
  }

  String get plateDisplay =>
      LocalStorageService().getVehicleRegistrationPlate().trim().isEmpty
          ? 'ABC1D23'
          : LocalStorageService().getVehicleRegistrationPlate().trim();

  String get modelDisplay => LocalStorageService().getDriverVehicleSummary();

  String get vehiclePhotoPath => LocalStorageService().getVehiclePhotoPath();

  void setSeats(int n) => seats.value = n.clamp(2, 9);

  Future<void> pickVehiclePhoto() async {
    final x = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 2000);
    if (x == null) return;
    await LocalStorageService().setVehiclePhotoPath(x.path);
    update(['vehiclePhoto']);
  }

  Future<void> saveEditableFields() async {
    await LocalStorageService().setVehicleColorDisplay(colorController.text.trim());
    await LocalStorageService().setDriverSeatDisplay('${seats.value}');
    Get.snackbar('driver_vehicle.saved_title'.tr, 'driver_vehicle.saved_body'.tr);
  }

  @override
  void onClose() {
    colorController.dispose();
    super.onClose();
  }
}
