import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/sounds/ui_sounds.dart';
import '../../../core/widgets/auth/tm_auth_hero_shell.dart';
import '../controllers/driver_onboarding_controller.dart';
import '../widgets/driver_onboarding_shell.dart';

class DriverApprovedView extends StatefulWidget {
  const DriverApprovedView({super.key});

  @override
  State<DriverApprovedView> createState() => _DriverApprovedViewState();
}

class _DriverApprovedViewState extends State<DriverApprovedView> {
  static const String _successLottie = 'assets/lottie/Success.json';

  static const Duration _successSoundDelay = Duration(milliseconds: 200);
  Timer? _successSoundTimer;

  @override
  void initState() {
    super.initState();
    _successSoundTimer = Timer(_successSoundDelay, () {
      if (!mounted) return;
      UiSounds.playDriverAccountVerified();
    });
  }

  @override
  void dispose() {
    _successSoundTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DriverOnboardingController>();
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DriverOnboardingShell(
      step: 6,
      title: 'driver_flow.approved_title'.tr,
      onBack: () => Get.back<void>(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: TripMatesColors.green.withValues(alpha: isDark ? 0.14 : 0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: TripMatesColors.green.withValues(alpha: 0.35),
              ),
            ),
            child: Text(
              'driver_flow.after_approval_banner'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.lexend(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
                color: TripMatesColors.green,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: SizedBox(
              height: 280,
              width: double.infinity,
              child: Transform.scale(
                scale: 1.25,
                alignment: Alignment.center,
                child: Lottie.asset(
                  _successLottie,
                  fit: BoxFit.contain,
                  repeat: true,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'driver_flow.approved_body'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 1.35,
                color: isDark ? scheme.onSurface : TripMatesColors.text2,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      bottomBar: DriverNavyCta(
        label: 'driver_flow.go_home'.tr,
        onPressed: controller.goHome,
      ),
    );
  }
}
