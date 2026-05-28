import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../controllers/passenger_flow_controller.dart';
import '../../theme/passenger_shell_theme.dart';

class PassengerSearchTab extends GetView<PassengerFlowController> {
  const PassengerSearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    final top = PassengerShellTheme.topContentPadding(context);
    return ColoredBox(
      color: PassengerShellTheme.screenBg,
      child: ListView(
        padding: EdgeInsets.fromLTRB(20, top, 20, 28),
        children: [
          Text(
            'passenger_search.title'.tr,
            style: GoogleFonts.lexend(
              fontSize: 21,
              fontWeight: FontWeight.w600,
              color: PassengerShellTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'passenger_search.sub'.tr,
            style: GoogleFonts.inter(
              fontSize: 14,
              height: 1.45,
              fontWeight: FontWeight.w400,
              color: PassengerShellTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 22),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Obx(
                    () => _SearchField(
                      label: 'passenger_home.from'.tr,
                      value: controller.origin.value,
                      onTap: () => controller.openPlacePicker(true),
                    ),
                  ),
                  const SizedBox(height: 44),
                  Obx(
                    () => _SearchField(
                      label: 'passenger_home.to'.tr,
                      value: controller.destination.value,
                      onTap: () => controller.openPlacePicker(false),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 52,
                child: Center(
                  child: Material(
                    color: PassengerShellTheme.primaryGreen,
                    shape: const CircleBorder(),
                    elevation: 0,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: controller.swapRoute,
                      child: Ink(
                        height: 46,
                        width: 46,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              PassengerShellTheme.primaryGreen,
                              PassengerShellTheme.primaryGreen.withValues(alpha: 0.85),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.25),
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
              ),
            ],
          ),
          const SizedBox(height: 14),
          Obx(
            () => _SearchField(
              label: 'passenger_home.date'.tr,
              value: controller.dateLabel,
              onTap: () => controller.pickTravelDate(),
            ),
          ),
          const SizedBox(height: 22),
          _GlossyCta(label: 'passenger_home.search_cta'.tr, onPressed: controller.goRideResults),
          const SizedBox(height: 28),
          Text(
            'passenger_search.recent'.tr,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: PassengerShellTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _RecentTile(
            title: 'Jaipur → Delhi',
            subtitle: DateFormat.MMMd().format(DateTime.now().add(const Duration(days: 1))),
            onTap: () {
              controller.origin.value = 'Jaipur, Rajasthan';
              controller.destination.value = 'Delhi, NCR';
              controller.goRideResults();
            },
          ),
          const SizedBox(height: 10),
          _RecentTile(
            title: 'Stockholm → Göteborg',
            subtitle: DateFormat.MMMd().format(DateTime.now()),
            onTap: () {
              controller.origin.value = 'Stockholm';
              controller.destination.value = 'Göteborg';
              controller.goRideResults();
            },
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.label, required this.value, required this.onTap});

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PassengerShellTheme.cardWhite,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.06),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
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
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: PassengerShellTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              PhosphorIcon(PhosphorIconsRegular.caretRight, color: PassengerShellTheme.textSecondary.withValues(alpha: 0.55), size: 18),
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
                style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RecentTile extends StatelessWidget {
  const _RecentTile({required this.title, required this.subtitle, required this.onTap});

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PassengerShellTheme.cardWhite,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.06),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              PhosphorIcon(PhosphorIconsRegular.clockCounterClockwise, color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.88), size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: PassengerShellTheme.textPrimary,
                      ),
                    ),
                    Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: PassengerShellTheme.textSecondary)),
                  ],
                ),
              ),
              PhosphorIcon(PhosphorIconsRegular.caretRight, color: PassengerShellTheme.textSecondary.withValues(alpha: 0.55), size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
