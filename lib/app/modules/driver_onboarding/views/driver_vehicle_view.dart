import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/driver_onboarding_controller.dart';
import '../widgets/driver_onboarding_shell.dart';

class DriverVehicleView extends GetView<DriverOnboardingController> {
  const DriverVehicleView({super.key});

  InputDecoration _fieldDeco(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InputDecoration(
      filled: true,
      fillColor: scheme.surface,
      hintStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        color: scheme.onSurface.withValues(alpha: 0.4),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  InputDecoration _dropdownDeco(BuildContext context, String label) {
    final scheme = Theme.of(context).colorScheme;
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: scheme.surface,
      labelStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    );
  }

  List<DropdownMenuItem<String>> _withOther(List<String> base) {
    return [
      ...base.map(
        (e) => DropdownMenuItem(
          value: e,
          child: Text(e, style: GoogleFonts.inter()),
        ),
      ),
      DropdownMenuItem(
        value: DriverOnboardingController.kOther,
        child: Text(
          'driver_flow.other'.tr,
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final c = controller;

    Widget block({
      required String label,
      required RxString selected,
      required List<String> options,
      required TextEditingController otherController,
      required bool locked,
    }) {
      return Obx(
        () {
          final v = selected.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputDecorator(
                decoration: _dropdownDeco(context, label),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: v,
                    borderRadius: BorderRadius.circular(12),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface,
                    ),
                    items: _withOther(options),
                    onChanged: locked
                        ? null
                        : (nv) {
                            if (nv != null) {
                              selected.value = nv;
                              c.update(['vehicle']);
                            }
                          },
                  ),
                ),
              ),
              if (v == DriverOnboardingController.kOther) ...[
                const SizedBox(height: 10),
                TextField(
                  controller: otherController,
                  readOnly: locked,
                  onChanged: (_) => c.update(['vehicle']),
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: _fieldDeco(context).copyWith(
                    hintText: 'driver_flow.specify_other_hint'.tr,
                  ),
                ),
              ],
            ],
          );
        },
      );
    }

    return DriverOnboardingShell(
      step: 3,
      title: 'driver_flow.vehicle_title'.tr,
      onBack: () => Get.back<void>(),
      body: Obx(
        () {
          final locked = c.isLockedAfterSubmit;
          return AbsorbPointer(
            absorbing: locked,
            child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 6),
          block(
            label: 'driver_flow.car_model'.tr,
            selected: c.selectedModel,
            options: DriverOnboardingController.carModels,
            otherController: c.modelOtherController,
            locked: locked,
          ),
          const SizedBox(height: 20),
          block(
            label: 'driver_flow.car_color'.tr,
            selected: c.selectedColor,
            options: DriverOnboardingController.carColors,
            otherController: c.colorOtherController,
            locked: locked,
          ),
          const SizedBox(height: 20),
          block(
            label: 'driver_flow.seats'.tr,
            selected: c.selectedSeats,
            options: DriverOnboardingController.seatCounts,
            otherController: c.seatsOtherController,
            locked: locked,
          ),
          const SizedBox(height: 28),
        ],
      ),
          );
        },
      ),
      bottomBar: GetBuilder<DriverOnboardingController>(
        id: 'vehicle',
        builder: (ctrl) => DriverNavyCta(
          label: 'driver_flow.continue'.tr,
          enabled: ctrl.canContinueVehicle,
          onPressed: ctrl.canContinueVehicle
              ? () => Get.toNamed<void>(Routes.DRIVER_REVIEW)
              : null,
        ),
      ),
    );
  }
}
