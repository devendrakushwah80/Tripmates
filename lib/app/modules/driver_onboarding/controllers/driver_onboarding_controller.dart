import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_pages.dart';
import '../../../services/local_storage_services/local_storage_services.dart';

/// Driver verification wizard state + image picks (gallery / camera).
class DriverOnboardingController extends GetxController {
  /// Dropdown sentinel for "Other" + manual entry.
  static const String kOther = '__other__';

  final ImagePicker _picker = ImagePicker();

  final licenseFrontPath = RxnString();
  final licenseBackPath = RxnString();
  final rcImagePath = RxnString();

  late final TextEditingController rcNumberController;
  late final TextEditingController modelOtherController;
  late final TextEditingController colorOtherController;
  late final TextEditingController seatsOtherController;

  final selectedModel = ''.obs;
  final selectedColor = ''.obs;
  final selectedSeats = ''.obs;

  static const List<String> carModels = [
    'Toyota Innova',
    'Maruti Swift',
    'Honda City',
    'Hyundai Creta',
    'Mahindra XUV700',
  ];
  static const List<String> carColors = [
    'White',
    'Black',
    'Silver',
    'Blue',
    'Grey',
  ];
  static const List<String> seatCounts = ['4', '5', '6', '7'];

  /// After user taps **Review & Submit**, licence / RC / vehicle cannot be edited.
  final submittedForReview = false.obs;

  bool get isLockedAfterSubmit => submittedForReview.value;

  bool get canContinueLicense =>
      (licenseFrontPath.value != null && licenseFrontPath.value!.isNotEmpty) &&
      (licenseBackPath.value != null && licenseBackPath.value!.isNotEmpty);

  bool get canContinueRc =>
      rcNumberController.text.trim().isNotEmpty &&
      (rcImagePath.value != null && rcImagePath.value!.isNotEmpty);

  bool _otherSectionOk(String value, TextEditingController other) {
    if (value == kOther) return other.text.trim().isNotEmpty;
    return value.isNotEmpty;
  }

  bool get canContinueVehicle =>
      _otherSectionOk(selectedModel.value, modelOtherController) &&
      _otherSectionOk(selectedColor.value, colorOtherController) &&
      _otherSectionOk(selectedSeats.value, seatsOtherController);

  bool get canSubmitReview => canContinueLicense && canContinueRc && canContinueVehicle;

  /// Resolved labels for review / storage (uses custom text when Other).
  String get effectiveModelDisplay => selectedModel.value == kOther
      ? modelOtherController.text.trim()
      : selectedModel.value;

  String get effectiveColorDisplay => selectedColor.value == kOther
      ? colorOtherController.text.trim()
      : selectedColor.value;

  String get effectiveSeatsDisplay => selectedSeats.value == kOther
      ? seatsOtherController.text.trim()
      : selectedSeats.value;

  @override
  void onInit() {
    rcNumberController = TextEditingController();
    rcNumberController.addListener(() => update(['rc']));
    modelOtherController = TextEditingController();
    colorOtherController = TextEditingController();
    seatsOtherController = TextEditingController();

    selectedModel.value = carModels.first;
    selectedColor.value = carColors.first;
    selectedSeats.value = seatCounts[2]; // "6"

    super.onInit();
  }

  @override
  void onClose() {
    rcNumberController.dispose();
    modelOtherController.dispose();
    colorOtherController.dispose();
    seatsOtherController.dispose();
    super.onClose();
  }

  void submitReviewAndContinue() {
    if (!canSubmitReview || submittedForReview.value) return;
    submittedForReview.value = true;
    Get.offNamed<void>(Routes.DRIVER_UNDER_REVIEW);
  }

  /// From Review (before submit): return to licence step to edit earlier screens.
  void navigateBackToEditFromReview() {
    if (submittedForReview.value) return;
    if (Get.currentRoute != Routes.DRIVER_REVIEW) return;
    Get.back<void>();
    Get.back<void>();
    Get.back<void>();
  }

  Future<ImageSource?> _askImageSource(BuildContext context) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'driver_flow.pick_source_title'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(ctx).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: Text('driver_flow.pick_gallery'.tr),
                  onTap: () => Navigator.pop(ctx, ImageSource.gallery),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera_outlined),
                  title: Text('driver_flow.pick_camera'.tr),
                  onTap: () => Navigator.pop(ctx, ImageSource.camera),
                ),
                ListTile(
                  leading: const Icon(Icons.close),
                  title: Text('common.cancel'.tr),
                  onTap: () => Navigator.pop(ctx),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> pickLicenseImage(BuildContext context, {required bool front}) async {
    if (submittedForReview.value) return;
    final source = await _askImageSource(context);
    if (source == null || !context.mounted) return;
    try {
      final x = await _picker.pickImage(
        source: source,
        maxWidth: 2400,
        imageQuality: 88,
      );
      if (x == null) return;
      if (!context.mounted) return;
      if (front) {
        licenseFrontPath.value = x.path;
      } else {
        licenseBackPath.value = x.path;
      }
    } catch (e) {
      Get.snackbar('common.error'.tr, e.toString());
    }
  }

  Future<void> pickRcImage(BuildContext context) async {
    if (submittedForReview.value) return;
    final source = await _askImageSource(context);
    if (source == null || !context.mounted) return;
    try {
      final x = await _picker.pickImage(
        source: source,
        maxWidth: 2400,
        imageQuality: 88,
      );
      if (x == null) return;
      if (!context.mounted) return;
      rcImagePath.value = x.path;
      update(['rc']);
    } catch (e) {
      Get.snackbar('common.error'.tr, e.toString());
    }
  }

  void disposeDriverFlow() {
    if (Get.isRegistered<DriverOnboardingController>()) {
      Get.delete<DriverOnboardingController>(force: true);
    }
  }

  Future<void> goHome() async {
    final plate = rcNumberController.text.trim();
    final summary = '$effectiveModelDisplay ($effectiveColorDisplay)';
    await LocalStorageService().setDriverVehicleSummary(summary);
    await LocalStorageService().setDriverSeatDisplay(effectiveSeatsDisplay);
    if (plate.isNotEmpty) {
      await LocalStorageService().setVehicleRegistrationPlate(plate);
    }
    await LocalStorageService().setUserRole('driver');
    disposeDriverFlow();
    Get.offAllNamed<void>(Routes.DRIVER_HOME);
  }
}
