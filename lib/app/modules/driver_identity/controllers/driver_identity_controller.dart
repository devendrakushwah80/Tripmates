import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/local_storage_services/local_storage_services.dart';

class DriverIdentityController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    final s = LocalStorageService();
    nameController.text = s.getUserName().trim().isEmpty ? 'Rishi Jain' : s.getUserName();
    emailController.text = s.getEmailId().trim().isEmpty ? 'rishi@example.com' : s.getEmailId();
    phoneController.text = s.getUserPhone();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  Future<void> saveEdits() async {
    final s = LocalStorageService();
    await s.setUserName(nameController.text.trim());
    await s.setEmailId(emailController.text.trim());
    await s.setUserPhone(phoneController.text.trim());
    Get.snackbar('driver_identity.saved_title'.tr, 'driver_identity.saved_body'.tr);
  }

  Future<void> pickProfilePhoto() async {
    final x = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 1600);
    if (x == null) return;
    await LocalStorageService().setProfilePhotoPath(x.path);
    update(['photo']);
  }

  String get licenseNumber => LocalStorageService().getDriverLicenseNumber();

  String get licenseExpiryDisplay {
    final raw = LocalStorageService().getDriverLicenseExpiry();
    try {
      final d = DateTime.parse(raw);
      return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return raw;
    }
  }

  String get lockedSelfiePath {
    final csv = LocalStorageService().getSelfieVerificationPaths();
    final parts = csv.split('|').where((e) => e.trim().isNotEmpty).toList();
    if (parts.isEmpty) return '';
    return parts.first.trim();
  }
}
