import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/widgets/tripmates/tm_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../../routes/app_pages.dart';
import '../../driver_shell/theme/driver_shell_theme.dart';
import '../controllers/my_garage_controller.dart';

class MyGarageScreenContent extends StatelessWidget {
  const MyGarageScreenContent({super.key, required this.controller, this.showBack = false});

  final MyGarageController controller;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TmMintAppBar(title: 'driver_vehicle.title'.tr, showBack: showBack),
        Expanded(
          child: Container(
            color: DriverShellTheme.screenBg,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
              children: [
                Text(
                  'driver_vehicle.intro'.tr,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                    color: DriverShellTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                _Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'driver_vehicle.section_vehicle'.tr,
                              style: GoogleFonts.lexend(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: DriverShellTheme.textPrimary,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: DriverShellTheme.softGreenBg,
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Text(
                              'driver_vehicle.reg_verified'.tr,
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: DriverShellTheme.primaryGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        controller.modelDisplay,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: DriverShellTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 14),
                      GetBuilder<MyGarageController>(
                        id: 'vehiclePhoto',
                        builder: (c) {
                          final path = c.vehiclePhotoPath;
                          final has = path.isNotEmpty && File(path).existsSync();
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: AspectRatio(
                              aspectRatio: 16 / 10,
                              child: has
                                  ? Image.file(File(path), fit: BoxFit.cover)
                                  : Image.asset(
                                      'assets/pexels-vadutskevich-15296469.jpg',
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          Container(
                                        color: DriverShellTheme.softGreenBg,
                                        child: Center(
                                          child: Icon(
                                            Icons.directions_car_filled_outlined,
                                            size: 48,
                                            color: DriverShellTheme.primaryGreen
                                                .withValues(alpha: 0.4),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: controller.pickVehiclePhoto,
                        icon: const Icon(Icons.photo_camera_outlined, size: 20),
                        label: Text('driver_vehicle.change_photo'.tr, style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: DriverShellTheme.primaryGreen,
                          side: BorderSide(color: DriverShellTheme.primaryGreen, width: 1.2),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'driver_vehicle.section_registration'.tr,
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: DriverShellTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'driver_vehicle.plate_locked_hint'.tr,
                        style: GoogleFonts.inter(fontSize: 12, color: DriverShellTheme.textSecondary, height: 1.35),
                      ),
                      const SizedBox(height: 12),
                      _LockedField(
                        label: 'driver_vehicle.plate'.tr,
                        value: controller.plateDisplay,
                      ),
                      const SizedBox(height: 12),
                      _LockedField(
                        label: 'driver_vehicle.rc_status'.tr,
                        value: 'driver_vehicle.rc_verified'.tr,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'driver_vehicle.section_editable'.tr,
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: DriverShellTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: controller.colorController,
                        decoration: InputDecoration(
                          labelText: 'driver_vehicle.color'.tr,
                          filled: true,
                          fillColor: DriverShellTheme.cardWhite,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'driver_vehicle.seats'.tr,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: DriverShellTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() {
                        return Row(
                          children: [
                            IconButton.filledTonal(
                              onPressed: controller.seats.value > 2 ? () => controller.setSeats(controller.seats.value - 1) : null,
                              icon: const Icon(Icons.remove_rounded),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  '${controller.seats.value}',
                                  style: GoogleFonts.lexend(fontSize: 24, fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                            IconButton.filledTonal(
                              onPressed: controller.seats.value < 9 ? () => controller.setSeats(controller.seats.value + 1) : null,
                              icon: const Icon(Icons.add_rounded),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: DriverShellTheme.primaryGreen.withValues(alpha: 0.25),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: FilledButton(
                    onPressed: controller.saveEditableFields,
                    style: FilledButton.styleFrom(
                      backgroundColor: DriverShellTheme.primaryGreen,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text(
                      'driver_vehicle.save'.tr,
                      style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DriverShellTheme.cardWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: DriverShellTheme.cardShadow,
        border: Border.all(color: DriverShellTheme.textSecondary.withValues(alpha: 0.08)),
      ),
      child: child,
    );
  }
}

class _LockedField extends StatelessWidget {
  const _LockedField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: DriverShellTheme.softGreenBg.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: DriverShellTheme.textSecondary.withValues(alpha: 0.12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lock_outline_rounded, size: 18, color: DriverShellTheme.textSecondary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: DriverShellTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: DriverShellTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyGarageView extends GetView<MyGarageController> {
  const MyGarageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DriverShellTheme.screenBg,
      body: SafeArea(child: MyGarageScreenContent(controller: controller, showBack: true)),
      bottomNavigationBar: TmBottomNav(
        selectedIndex: 2,
        onTap: (i) {
          if (i == 0) UserHomeNavigation.offAllToUserHome();
          if (i == 1) Get.offAllNamed<void>(Routes.SEARCH_RIDES);
          if (i == 3) Get.offAllNamed<void>(Routes.ACCOUNT);
        },
      ),
    );
  }
}
