import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/sounds/ui_sounds.dart';
import '../../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../controllers/passenger_flow_controller.dart';
import '../../theme/passenger_shell_theme.dart';
import '../../widgets/passenger_shell_assets.dart';

class PassengerBookingConfirmedView extends StatefulWidget {
  const PassengerBookingConfirmedView({super.key});

  @override
  State<PassengerBookingConfirmedView> createState() => _PassengerBookingConfirmedViewState();
}

class _PassengerBookingConfirmedViewState extends State<PassengerBookingConfirmedView> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future<void>.delayed(const Duration(milliseconds: 200), () {
        if (mounted) unawaited(UiSounds.playSuccessChime());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PassengerFlowController>();
    return Scaffold(
      backgroundColor: PassengerShellTheme.screenBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TmMintAppBar(title: 'passenger_confirmed.title'.tr, showBack: true, onBack: controller.popFlowOrShell),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  Center(
                    child: SizedBox(
                      height: 150,
                      child: Lottie.asset('assets/lottie/Success.json', repeat: false),
                    ),
                  ),
                  Text(
                    'passenger_confirmed.sub'.tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: PassengerShellTheme.textSecondary,
                      height: 1.45,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => Material(
                      color: PassengerShellTheme.cardWhite,
                      borderRadius: BorderRadius.circular(18),
                      elevation: 0,
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: PassengerShellTheme.cardShadowSoft,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'passenger_confirmed.booking_id'.tr,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: PassengerShellTheme.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                controller.bookingId.value,
                                style: GoogleFonts.lexend(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                  color: PassengerShellTheme.primaryGreen,
                                ),
                              ),
                              const Divider(height: 28),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundImage: const AssetImage(PassengerShellAssets.driverPortrait),
                                    backgroundColor: PassengerShellTheme.softGreenBg,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.driverName.value,
                                          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          controller.vehicleName.value,
                                          style: GoogleFonts.inter(fontSize: 13, color: PassengerShellTheme.textSecondary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                '${controller.origin.value} → ${controller.destination.value}',
                                style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                controller.dateLabel,
                                style: GoogleFonts.inter(fontSize: 13, color: PassengerShellTheme.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Column(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.2),
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
                        onTap: controller.trackRideFromBooking,
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Center(
                            child: Text(
                              'passenger_confirmed.track'.tr,
                              style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: controller.viewMyRidesAfterBooking,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      side: BorderSide(color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.35)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(
                      'passenger_confirmed.my_rides'.tr,
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: PassengerShellTheme.primaryGreen),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
