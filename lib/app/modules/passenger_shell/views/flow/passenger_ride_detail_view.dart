import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../controllers/passenger_flow_controller.dart';
import '../../theme/passenger_shell_theme.dart';
import '../../widgets/passenger_road_tracking_map.dart';
import '../../widgets/passenger_shell_assets.dart';

class PassengerRideDetailView extends GetView<PassengerFlowController> {
  const PassengerRideDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PassengerShellTheme.screenBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TmMintAppBar(
              title: 'passenger_detail.title'.tr,
              showBack: true,
              onBack: controller.popFlowOrShell,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                children: [
                  Obx(
                    () => _DriverHeader(
                      name: controller.driverName.value,
                      rating: controller.driverRating.value,
                      vehicle: controller.vehicleName.value,
                      plate: controller.vehiclePlate.value,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const PassengerRoadTrackingMap(
                    height: 176,
                    animateDriver: false,
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => _InfoCard(
                      children: [
                        _AssetLine(
                          PassengerShellAssets.pickupIcon,
                          'passenger_detail.pickup'.tr,
                          controller.origin.value,
                        ),
                        _AssetLine(
                          PassengerShellAssets.dropIcon,
                          'passenger_detail.drop'.tr,
                          controller.destination.value,
                        ),
                        _LineIcon(
                          Icons.schedule_rounded,
                          'passenger_detail.eta'.tr,
                          controller.etaLabel.value,
                        ),
                        _AssetLine(
                          PassengerShellAssets.seatsIcon,
                          'passenger_detail.seats'.tr,
                          '${controller.seatsLeft.value}',
                        ),
                        _LineIcon(
                          Icons.payments_outlined,
                          'passenger_detail.price'.tr,
                          '${controller.pricePerSeat.value} SEK',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'passenger_detail.prefs'.tr,
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: PassengerShellTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _PrefChip(text: 'passenger_detail.pref_no_smoke'.tr),
                      _PrefChip(text: 'passenger_detail.pref_no_pets'.tr),
                      _PrefChip(text: 'passenger_detail.pref_music'.tr),
                    ],
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
                  blurRadius: 14,
                  offset: const Offset(0, 6),
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
                onTap: controller.goBookRide,
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text(
                      'passenger_detail.book'.tr,
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

class _DriverHeader extends StatelessWidget {
  const _DriverHeader({
    required this.name,
    required this.rating,
    required this.vehicle,
    required this.plate,
  });

  final String name;
  final double rating;
  final String vehicle;
  final String plate;

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
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  PassengerShellAssets.driverPortrait,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, _) => CircleAvatar(
                    radius: 32,
                    backgroundColor: PassengerShellTheme.softGreenBg,
                    child: Icon(
                      Icons.person_rounded,
                      color: PassengerShellTheme.primaryGreen,
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
                      name,
                      style: GoogleFonts.lexend(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
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
                  ],
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    PassengerShellAssets.ratingIcon,
                    width: 17,
                    height: 17,
                    errorBuilder: (context, error, _) => Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: Colors.amber.shade600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$rating',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
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

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PassengerShellTheme.cardWhite,
      borderRadius: BorderRadius.circular(18),
      elevation: 0,
      child: Ink(
        decoration: BoxDecoration(
          color: PassengerShellTheme.cardWhite,
          borderRadius: BorderRadius.circular(18),
          boxShadow: PassengerShellTheme.cardShadowSoft,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: children),
        ),
      ),
    );
  }
}

class _AssetLine extends StatelessWidget {
  const _AssetLine(this.asset, this.label, this.value);

  final String asset;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: PassengerShellTheme.softGreenBg.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              asset,
              width: 22,
              height: 22,
              fit: BoxFit.contain,
              errorBuilder: (context, error, _) => Icon(
                Icons.place_outlined,
                size: 20,
                color: PassengerShellTheme.primaryGreen,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: PassengerShellTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                    color: PassengerShellTheme.textPrimary,
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

class _LineIcon extends StatelessWidget {
  const _LineIcon(this.icon, this.label, this.value);

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: PassengerShellTheme.softGreenBg.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 20,
              color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.88),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: PassengerShellTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                    color: PassengerShellTheme.textPrimary,
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

class _PrefChip extends StatelessWidget {
  const _PrefChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: PassengerShellTheme.softGreenBg.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: PassengerShellTheme.primaryGreen,
        ),
      ),
    );
  }
}
