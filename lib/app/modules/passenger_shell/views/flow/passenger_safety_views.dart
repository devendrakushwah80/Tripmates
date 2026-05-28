import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../controllers/passenger_flow_controller.dart';
import '../../theme/passenger_shell_theme.dart';

class PassengerSafetyShareView extends GetView<PassengerFlowController> {
  const PassengerSafetyShareView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PassengerShellTheme.screenBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TmMintAppBar(
              title: 'passenger_share.title'.tr,
              showBack: true,
              onBack: controller.popFlowOrShell,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    const Spacer(),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: PassengerShellTheme.softGreenBg,
                        boxShadow: [
                          BoxShadow(
                            color: PassengerShellTheme.primaryGreen.withValues(
                              alpha: 0.15,
                            ),
                            blurRadius: 24,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: PhosphorIcon(
                        PhosphorIconsRegular.shareNetwork,
                        size: 52,
                        color: PassengerShellTheme.primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'passenger_share.sub'.tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        height: 1.5,
                        color: PassengerShellTheme.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: PassengerShellTheme.primaryGreen.withValues(
                              alpha: 0.25,
                            ),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: FilledButton(
                        onPressed: controller.dummyShareLocation,
                        style: FilledButton.styleFrom(
                          backgroundColor: PassengerShellTheme.primaryGreen,
                          minimumSize: const Size(double.infinity, 52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'passenger_share.cta'.tr,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PassengerSafetyEmergencyView extends GetView<PassengerFlowController> {
  const PassengerSafetyEmergencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PassengerShellTheme.screenBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TmMintAppBar(
              title: 'passenger_emergency.title'.tr,
              showBack: true,
              onBack: controller.popFlowOrShell,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(22),
                children: [
                  Material(
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
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            PhosphorIcon(
                              PhosphorIconsRegular.phoneCall,
                              size: 48,
                              color: PassengerShellTheme.primaryGreen,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'passenger_emergency.sub'.tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                height: 1.45,
                                color: PassengerShellTheme.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 22),
                            Text(
                              'Alex Andersson',
                              style: GoogleFonts.lexend(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: PassengerShellTheme.textPrimary,
                              ),
                            ),
                            Text(
                              '+46 70 123 45 67',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                color: PassengerShellTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: controller.dummyEmergencyCall,
                    icon: const Icon(
                      Icons.phone_in_talk_rounded,
                      color: Colors.white,
                    ),
                    label: Text(
                      'passenger_emergency.call'.tr,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: PassengerShellTheme.primaryGreen,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
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

class PassengerSafetySosView extends StatelessWidget {
  const PassengerSafetySosView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PassengerFlowController>();
    final isDark = Get.isDarkMode;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF450A0A), const Color(0xFF1E0505)]
                : [const Color(0xFFFFE4E6), const Color(0xFFFEF2F2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: c.popFlowOrShell,
                  icon: PhosphorIcon(
                    PhosphorIconsRegular.caretLeft,
                    color: isDark
                        ? Colors.white
                        : PassengerShellTheme.textPrimary,
                    size: 28,
                  ),
                ),
              ),
              Text(
                'passenger_sos.title'.tr,
                style: GoogleFonts.lexend(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: PassengerShellTheme.danger,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  'passenger_sos.sub'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.75)
                        : PassengerShellTheme.textSecondary,
                    height: 1.45,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (isDark ? Colors.black : Colors.white).withValues(
                    alpha: 0.35,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: PassengerShellTheme.danger.withValues(alpha: 0.45),
                      blurRadius: 32,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: PassengerShellTheme.danger,
                      boxShadow: [
                        BoxShadow(
                          color: PassengerShellTheme.danger.withValues(
                            alpha: 0.5,
                          ),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'SOS',
                        style: GoogleFonts.lexend(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 12),
                child: FilledButton(
                  onPressed: c.dummySosSend,
                  style: FilledButton.styleFrom(
                    backgroundColor: PassengerShellTheme.danger,
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'passenger_sos.send'.tr,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
                child: OutlinedButton(
                  onPressed: c.dummySosCancel,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    side: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.5)
                          : const Color(0xFF991B1B),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'passenger_sos.cancel'.tr,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : const Color(0xFF991B1B),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
