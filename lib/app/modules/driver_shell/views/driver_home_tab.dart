import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../routes/app_pages.dart';
import '../../../services/local_storage_services/local_storage_services.dart';
import '../controllers/driver_shell_controller.dart';
import '../theme/driver_shell_theme.dart';

class DriverHomeTab extends StatelessWidget {
  const DriverHomeTab({super.key, required this.onPublishRide});

  final Future<void> Function() onPublishRide;

  static const String _heroCarAsset = 'assets/pexels-vadutskevich-15296469.jpg';

  static String _timeGreeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'driver_hub.greet_morning'.tr;
    if (h < 17) return 'driver_hub.greet_afternoon'.tr;
    return 'driver_hub.greet_evening'.tr;
  }

  @override
  Widget build(BuildContext context) {
    final storage = LocalStorageService();
    final fullName = storage.getUserName().trim().isEmpty
        ? 'driver_hub.demo_name'.tr
        : storage.getUserName();
    final first = fullName.split(RegExp(r'\s+')).first;
    final vehicleLine = storage.getDriverVehicleSummary();
    final plate = storage.getVehicleRegistrationPlate().trim().isEmpty
        ? 'RJ14 AB 1234'
        : storage.getVehicleRegistrationPlate();
    final photoPath = storage.getProfilePhotoPath();
    final seats = storage.getDriverSeatDisplay();

    return ColoredBox(
      color: DriverShellTheme.screenBg,
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DriverHeader(
                firstName: first,
                timeGreeting: _timeGreeting(),
                photoPath: photoPath,
              ),
              const SizedBox(height: 12),
              const _VerifiedBadge(),
              const SizedBox(height: 16),
              _VehicleCard(
                vehicleLine: vehicleLine,
                plate: plate,
                seats: seats,
                onEdit: () => Get.toNamed<void>(Routes.MY_GARAGE),
              ),
              const SizedBox(height: 16),
              _PublishRideCta(onTap: () => onPublishRide()),
              const SizedBox(height: 20),
              Text(
                'driver_hub.shortcuts_title'.tr,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                  color: DriverShellTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 10),
              const _ShortcutsGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DriverHeader extends StatelessWidget {
  const _DriverHeader({
    required this.firstName,
    required this.timeGreeting,
    required this.photoPath,
  });

  final String firstName;
  final String timeGreeting;
  final String photoPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProfileAvatar(photoPath: photoPath),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'driver_hub.greeting'.trParams({'name': firstName}),
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  color: DriverShellTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                timeGreeting,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: DriverShellTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Material(
          color: DriverShellTheme.cardWhite,
          shape: const CircleBorder(),
          elevation: 0,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => Get.snackbar(
              'driver_hub.notifications_title'.tr,
              'driver_hub.notifications_hint'.tr,
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(16),
              borderRadius: 14,
            ),
            child: Ink(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: DriverShellTheme.cardWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: PhosphorIcon(
                      PhosphorIconsRegular.bell,
                      size: 22,
                      color: DriverShellTheme.textPrimary.withValues(
                        alpha: 0.75,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: DriverShellTheme.primaryGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '3',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.photoPath});

  final String photoPath;

  @override
  Widget build(BuildContext context) {
    final has = photoPath.isNotEmpty && File(photoPath).existsSync();
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: DriverShellTheme.softGreenBg, width: 2),
        boxShadow: DriverShellTheme.cardShadow,
      ),
      child: ClipOval(
        child: has
            ? Image.file(File(photoPath), fit: BoxFit.cover)
            : ColoredBox(
                color: DriverShellTheme.softGreenBg,
                child: Center(
                  child: PhosphorIcon(
                    PhosphorIconsRegular.user,
                    size: 26,
                    color: DriverShellTheme.primaryGreen,
                  ),
                ),
              ),
      ),
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
        decoration: BoxDecoration(
          color: DriverShellTheme.softGreenBg,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: DriverShellTheme.primaryGreen.withValues(alpha: 0.18),
          ),
          boxShadow: DriverShellTheme.badgeShadow,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PhosphorIcon(
              PhosphorIconsRegular.sealCheck,
              size: 17,
              color: DriverShellTheme.primaryGreen,
            ),
            const SizedBox(width: 6),
            Text(
              'driver_hub.verified'.tr,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
                color: DriverShellTheme.primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VehicleCard extends StatelessWidget {
  const _VehicleCard({
    required this.vehicleLine,
    required this.plate,
    required this.seats,
    required this.onEdit,
  });

  final String vehicleLine;
  final String plate;
  final String seats;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DriverShellTheme.cardWhite.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.8)),
        boxShadow: DriverShellTheme.cardShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 10, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 100,
                      height: 78,
                      child: Image.asset(
                        DriverHomeTab._heroCarAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            ColoredBox(
                              color: DriverShellTheme.softGreenBg,
                              child: Center(
                                child: PhosphorIcon(
                                  PhosphorIconsRegular.car,
                                  size: 32,
                                  color: DriverShellTheme.primaryGreen,
                                ),
                              ),
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicleLine,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                            color: DriverShellTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          plate,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: DriverShellTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onEdit,
                    visualDensity: VisualDensity.compact,
                    style: IconButton.styleFrom(
                      backgroundColor: DriverShellTheme.softGreenBg,
                      foregroundColor: DriverShellTheme.primaryGreen,
                    ),
                    icon: PhosphorIcon(
                      PhosphorIconsRegular.pencilSimple,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Divider(
                height: 1,
                color: DriverShellTheme.textSecondary.withValues(alpha: 0.15),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _StatCell(
                      icon: PhosphorIconsRegular.star,
                      value: '4.8',
                      label: 'driver_hub.stat_rating'.tr,
                    ),
                  ),
                  Expanded(
                    child: _StatCell(
                      icon: PhosphorIconsRegular.briefcase,
                      value: '45',
                      label: 'driver_hub.stat_trips'.tr,
                    ),
                  ),
                  Expanded(
                    child: _StatCell(
                      icon: PhosphorIconsRegular.armchair,
                      value: seats,
                      label: 'driver_hub.stat_seats'.tr,
                    ),
                  ),
                  Expanded(
                    child: _StatCell(
                      icon: PhosphorIconsRegular.currencyInr,
                      value: '₹1,850',
                      label: 'driver_hub.stat_today'.tr,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: DriverShellTheme.softGreenBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: PhosphorIcon(
              icon,
              size: 18,
              color: DriverShellTheme.primaryGreen,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: DriverShellTheme.textPrimary,
          ),
        ),
        Text(
          label,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 9.5,
            fontWeight: FontWeight.w500,
            height: 1.15,
            color: DriverShellTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _PublishRideCta extends StatelessWidget {
  const _PublishRideCta({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                DriverShellTheme.primaryGreen,
                DriverShellTheme.primaryGreenDark,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: DriverShellTheme.primaryGreen.withValues(alpha: 0.35),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.22),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                  ),
                ),
                child: Center(
                  child: PhosphorIcon(
                    PhosphorIconsRegular.carProfile,
                    size: 26,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'driver_hub.publish_ride'.tr,
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'driver_hub.publish_subtitle'.tr,
                      style: GoogleFonts.inter(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        height: 1.25,
                        color: Colors.white.withValues(alpha: 0.92),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: DriverShellTheme.primaryGreen,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShortcutsGrid extends StatelessWidget {
  const _ShortcutsGrid();

  @override
  Widget build(BuildContext context) {
    final shell = Get.find<DriverShellController>();

    Widget tile({
      required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap,
    }) {
      return Material(
        color: DriverShellTheme.cardWhite,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: DriverShellTheme.textSecondary.withValues(alpha: 0.12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: DriverShellTheme.softGreenBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: PhosphorIcon(
                      icon,
                      size: 22,
                      color: DriverShellTheme.primaryGreen,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: DriverShellTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                    color: DriverShellTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.22,
      children: [
        tile(
          icon: PhosphorIconsRegular.carSimple,
          title: 'driver_hub.tile_my_rides'.tr,
          subtitle: 'driver_hub.tile_my_rides_sub'.tr,
          onTap: () => shell.goToTab(1),
        ),
        tile(
          icon: PhosphorIconsRegular.wallet,
          title: 'driver_hub.tile_earnings'.tr,
          subtitle: 'driver_hub.tile_earnings_sub'.tr,
          onTap: () => shell.goToTab(2),
        ),
        tile(
          icon: PhosphorIconsRegular.usersThree,
          title: 'driver_hub.tile_requests'.tr,
          subtitle: 'driver_hub.tile_requests_sub'.tr,
          onTap: () => Get.snackbar(
            'driver_hub.requests_title'.tr,
            'driver_hub.requests_hint'.tr,
          ),
        ),
        tile(
          icon: PhosphorIconsRegular.steeringWheel,
          title: 'driver_hub.tile_vehicle'.tr,
          subtitle: 'driver_hub.tile_vehicle_sub'.tr,
          onTap: () => Get.toNamed<void>(Routes.MY_GARAGE),
        ),
        tile(
          icon: PhosphorIconsRegular.shieldCheck,
          title: 'driver_hub.tile_safety'.tr,
          subtitle: 'driver_hub.tile_safety_sub'.tr,
          onTap: () => Get.toNamed<void>(Routes.RULES),
        ),
        tile(
          icon: PhosphorIconsRegular.identificationCard,
          title: 'driver_hub.tile_documents'.tr,
          subtitle: 'driver_hub.tile_documents_sub'.tr,
          onTap: () => Get.toNamed<void>(Routes.DRIVER_IDENTITY_DETAILS),
        ),
      ],
    );
  }
}
