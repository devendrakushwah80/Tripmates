import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../controllers/passenger_flow_controller.dart';
import '../../theme/passenger_shell_theme.dart';

class PassengerTripCompletedView extends GetView<PassengerFlowController> {
  const PassengerTripCompletedView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        controller.goPassengerShellTab(2);
      },
      child: Scaffold(
        backgroundColor: PassengerShellTheme.screenBg,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TmMintAppBar(
                title: 'passenger_completed.title'.tr,
                showBack: true,
                onBack: () => controller.goPassengerShellTab(2),
              ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 16),
                children: [
                  SizedBox(
                    height: 160,
                    child: Lottie.asset('assets/lottie/Success.json', repeat: false),
                  ),
                  Text('passenger_completed.sub'.tr, textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 15, color: PassengerShellTheme.textSecondary, height: 1.45)),
                  const SizedBox(height: 20),
                  Obx(() => Material(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${controller.origin.value} → ${controller.destination.value}',
                                  style: GoogleFonts.lexend(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: PassengerShellTheme.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: PassengerShellTheme.softGreenBg,
                                      child: PhosphorIcon(PhosphorIconsRegular.user, color: PassengerShellTheme.primaryGreen),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.driverName.value,
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w800,
                                            color: PassengerShellTheme.textPrimary,
                                          ),
                                        ),
                                        Text(
                                          controller.vehicleName.value,
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color: PassengerShellTheme.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
              child: Column(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [BoxShadow(color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.22), blurRadius: 12, offset: const Offset(0, 5))],
                    ),
                    child: FilledButton(
                      onPressed: controller.goReviewDriver,
                      style: FilledButton.styleFrom(
                        backgroundColor: PassengerShellTheme.primaryGreen,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text('passenger_completed.rate'.tr, style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () => controller.goPassengerShellTab(2),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      side: BorderSide(color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.45)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text('passenger_completed.rides'.tr, style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: PassengerShellTheme.primaryGreen)),
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
