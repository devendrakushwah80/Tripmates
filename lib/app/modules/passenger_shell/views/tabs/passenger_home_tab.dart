import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../routes/app_pages.dart';
import '../../controllers/passenger_flow_controller.dart';
import '../../controllers/passenger_shell_controller.dart';
import '../../theme/passenger_shell_theme.dart';

class PassengerHomeTab extends GetView<PassengerFlowController> {
  const PassengerHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final shell = Get.find<PassengerShellController>();
    final top = PassengerShellTheme.topContentPadding(context);
    final firstName = controller.personalName.text.trim().isEmpty
        ? 'Rahul'
        : controller.personalName.text.split(' ').first;

    return ColoredBox(
      color: PassengerShellTheme.screenBg,
      child: ListView(
        padding: EdgeInsets.fromLTRB(20, top, 20, 28),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'passenger_home.greeting'.trParams({'name': firstName}),
                      style: GoogleFonts.lexend(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: PassengerShellTheme.textPrimary,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'passenger_home.sub'.tr,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        height: 1.45,
                        fontWeight: FontWeight.w400,
                        color: PassengerShellTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Material(
                color: PassengerShellTheme.cardWhite,
                shape: const CircleBorder(),
                elevation: 0,
                shadowColor: Colors.transparent,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => Get.snackbar('passenger_home.notifications'.tr, 'passenger_home.notifications_hint'.tr),
                  child: Ink(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: PassengerShellTheme.cardShadowSoft,
                      border: Border.all(color: PassengerShellTheme.softGreenBg),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: PhosphorIcon(
                        PhosphorIconsRegular.bell,
                        color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.88),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            decoration: BoxDecoration(
              color: PassengerShellTheme.cardWhite,
              borderRadius: BorderRadius.circular(22),
              boxShadow: PassengerShellTheme.cardShadowSoft,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'passenger_home.search_card_title'.tr,
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: PassengerShellTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Obx(
                                () => _SearchRow(
                                  label: 'passenger_home.from'.tr,
                                  value: controller.origin.value,
                                  onTap: () => controller.openPlacePicker(true),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10, top: 2, bottom: 2),
                                child: Divider(
                                  height: 1,
                                  color: PassengerShellTheme.textSecondary.withValues(alpha: 0.08),
                                ),
                              ),
                              Obx(
                                () => _SearchRow(
                                  label: 'passenger_home.to'.tr,
                                  value: controller.destination.value,
                                  onTap: () => controller.openPlacePicker(false),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Center(
                          child: Material(
                            color: PassengerShellTheme.primaryGreen,
                            shape: const CircleBorder(),
                            elevation: 0,
                            shadowColor: PassengerShellTheme.primaryGreen.withValues(alpha: 0.35),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: controller.swapRoute,
                              child: Ink(
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      PassengerShellTheme.primaryGreen,
                                      PassengerShellTheme.primaryGreen.withValues(alpha: 0.82),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.28),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.swap_vert_rounded, color: Colors.white, size: 22),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () => _SearchRow(
                      label: 'passenger_home.date'.tr,
                      value: controller.dateLabel,
                      onTap: () => controller.pickTravelDate(),
                      showCalendar: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _GlossyCta(
                    label: 'passenger_home.search_cta'.tr,
                    onPressed: controller.goRideResults,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 26),
          Text(
            'passenger_home.quick'.tr,
            style: GoogleFonts.lexend(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
              color: PassengerShellTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _QuickCircle(icon: PhosphorIconsRegular.car, label: 'passenger_home.q_rides'.tr, onTap: () => shell.goToTab(2))),
              const SizedBox(width: 10),
              Expanded(child: _QuickCircle(icon: PhosphorIconsRegular.shieldCheck, label: 'passenger_home.q_safety'.tr, onTap: () => shell.goToTab(3))),
              const SizedBox(width: 10),
              Expanded(child: _QuickCircle(icon: PhosphorIconsRegular.user, label: 'passenger_home.q_profile'.tr, onTap: () => shell.goToTab(4))),
              const SizedBox(width: 10),
              Expanded(child: _QuickCircle(icon: PhosphorIconsRegular.lifebuoy, label: 'passenger_home.q_support'.tr, onTap: () => Get.toNamed<void>(Routes.PASSENGER_SUPPORT))),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchRow extends StatelessWidget {
  const _SearchRow({
    required this.label,
    required this.value,
    required this.onTap,
    this.showCalendar = false,
  });

  final String label;
  final String value;
  final VoidCallback onTap;
  final bool showCalendar;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PassengerShellTheme.screenBg.withValues(alpha: 0.65),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
          child: Row(
            children: [
              if (showCalendar)
                PhosphorIcon(PhosphorIconsRegular.calendarBlank, size: 18, color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.85))
              else
                PhosphorIcon(PhosphorIconsRegular.mapPinLine, size: 18, color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.85)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15,
                        color: PassengerShellTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
              PhosphorIcon(PhosphorIconsRegular.caretRight, size: 16, color: PassengerShellTheme.textSecondary.withValues(alpha: 0.5)),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlossyCta extends StatelessWidget {
  const _GlossyCta({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.22),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            PassengerShellTheme.primaryGreen.withValues(alpha: 0.98),
            PassengerShellTheme.primaryGreen.withValues(alpha: 0.88),
          ],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickCircle extends StatelessWidget {
  const _QuickCircle({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: PassengerShellTheme.softGreenBg.withValues(alpha: 0.55),
                  border: Border.all(color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.22)),
                  boxShadow: PassengerShellTheme.cardShadowSoft,
                ),
                child: PhosphorIcon(icon, size: 22, color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.9)),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  color: PassengerShellTheme.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
