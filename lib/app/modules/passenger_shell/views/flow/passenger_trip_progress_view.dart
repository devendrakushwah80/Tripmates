import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../controllers/passenger_flow_controller.dart';
import '../../theme/passenger_shell_theme.dart';
import '../../widgets/passenger_road_tracking_map.dart';
import '../../widgets/passenger_shell_assets.dart';

class PassengerTripProgressView extends GetView<PassengerFlowController> {
  const PassengerTripProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PassengerShellTheme.screenBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TmMintAppBar(
              title: 'passenger_trip.title'.tr,
              showBack: true,
              onBack: controller.popFlowOrShell,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
                children: [
                  Obx(
                    () => _DriverTripCard(
                      name: controller.driverName.value,
                      vehicle: controller.vehicleName.value,
                      plate: controller.vehiclePlate.value,
                      time: controller.departureTime.value,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'passenger_trip.route'.tr,
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: PassengerShellTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Text(
                      '${controller.origin.value} → ${controller.destination.value}',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        color: PassengerShellTheme.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const PassengerRoadTrackingMap(
                    height: 168,
                    animateDriver: false,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: controller.goLiveTracking,
                      icon: PhosphorIcon(
                        PhosphorIconsRegular.mapPin,
                        color: PassengerShellTheme.primaryGreen,
                        size: 20,
                      ),
                      label: Text(
                        'passenger_trip.live_map'.tr,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: PassengerShellTheme.primaryGreen,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'passenger_trip.safety'.tr,
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: PassengerShellTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _SafetyMini(
                    icon: PhosphorIconsRegular.shareNetwork,
                    title: 'passenger_trip.share_live'.tr,
                    onTap: controller.goSafetyShare,
                  ),
                  _SafetyMini(
                    icon: PhosphorIconsRegular.phone,
                    title: 'passenger_trip.emergency'.tr,
                    onTap: controller.goSafetyEmergency,
                  ),
                  _SafetyMini(
                    icon: PhosphorIconsRegular.warningCircle,
                    title: 'passenger_trip.sos'.tr,
                    onTap: controller.goSafetySos,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: PassengerShellTheme.primaryGreen.withValues(
                    alpha: 0.2,
                  ),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  PassengerShellTheme.primaryGreen.withValues(alpha: 0.97),
                  PassengerShellTheme.primaryGreen.withValues(alpha: 0.86),
                ],
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: controller.snackImSafe,
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: Center(
                    child: Text(
                      'passenger_trip.im_safe'.tr,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DriverTripCard extends StatelessWidget {
  const _DriverTripCard({
    required this.name,
    required this.vehicle,
    required this.plate,
    required this.time,
  });

  final String name;
  final String vehicle;
  final String plate;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PassengerShellTheme.cardWhite,
      borderRadius: BorderRadius.circular(20),
      elevation: 0,
      child: Ink(
        decoration: BoxDecoration(
          color: PassengerShellTheme.cardWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: PassengerShellTheme.cardShadowSoft,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: const AssetImage(
                  PassengerShellAssets.driverPortrait,
                ),
                backgroundColor: PassengerShellTheme.softGreenBg,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.lexend(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: PassengerShellTheme.textPrimary,
                      ),
                    ),
                    Text(
                      vehicle,
                      style: GoogleFonts.inter(
                        color: PassengerShellTheme.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      plate,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: PassengerShellTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        PhosphorIcon(
                          PhosphorIconsRegular.clock,
                          size: 16,
                          color: PassengerShellTheme.textSecondary.withValues(
                            alpha: 0.85,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          time,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            color: PassengerShellTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SafetyMini extends StatelessWidget {
  const _SafetyMini({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: PassengerShellTheme.cardWhite,
        borderRadius: BorderRadius.circular(14),
        elevation: 0,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Ink(
            decoration: BoxDecoration(
              color: PassengerShellTheme.cardWhite,
              borderRadius: BorderRadius.circular(14),
              boxShadow: PassengerShellTheme.cardShadowSoft,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: PassengerShellTheme.softGreenBg.withValues(
                        alpha: 0.7,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: PhosphorIcon(
                      icon,
                      color: PassengerShellTheme.primaryGreen.withValues(
                        alpha: 0.88,
                      ),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: PassengerShellTheme.textPrimary,
                      ),
                    ),
                  ),
                  PhosphorIcon(
                    PhosphorIconsRegular.caretRight,
                    color: PassengerShellTheme.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
