import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../routes/app_pages.dart';
import '../../theme/passenger_shell_theme.dart';

class PassengerSafetyTab extends StatelessWidget {
  const PassengerSafetyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: PassengerShellTheme.screenBg,
      child: ListView(
        padding: EdgeInsets.fromLTRB(18, PassengerShellTheme.topContentPadding(context), 18, 24),
        children: [
          Text(
            'passenger_safety.title'.tr,
            style: GoogleFonts.lexend(fontSize: 22, fontWeight: FontWeight.w800, color: PassengerShellTheme.textPrimary),
          ),
          const SizedBox(height: 6),
          Text(
            'passenger_safety.sub'.tr,
            style: GoogleFonts.inter(fontSize: 14, color: PassengerShellTheme.textSecondary, height: 1.45),
          ),
          const SizedBox(height: 20),
          _Tile(icon: PhosphorIconsRegular.shareNetwork, title: 'passenger_safety.share_live'.tr, sub: 'passenger_safety.share_live_sub'.tr, onTap: () => Get.toNamed<void>(Routes.PASSENGER_SAFETY_SHARE)),
          _Tile(icon: PhosphorIconsRegular.phone, title: 'passenger_safety.emergency'.tr, sub: 'passenger_safety.emergency_sub'.tr, onTap: () => Get.toNamed<void>(Routes.PASSENGER_SAFETY_EMERGENCY)),
          _Tile(icon: PhosphorIconsRegular.warningCircle, title: 'passenger_safety.sos'.tr, sub: 'passenger_safety.sos_sub'.tr, onTap: () => Get.toNamed<void>(Routes.PASSENGER_SAFETY_SOS)),
          _Tile(icon: PhosphorIconsRegular.lightbulb, title: 'passenger_safety.tips'.tr, sub: 'passenger_safety.tips_sub'.tr, onTap: () => Get.snackbar('passenger_safety.tips'.tr, 'passenger_safety.tips_hint'.tr)),
          const SizedBox(height: 16),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.25), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: FilledButton.icon(
              onPressed: () => Get.snackbar('passenger_safety.im_safe'.tr, 'passenger_safety.im_safe_hint'.tr),
              style: FilledButton.styleFrom(
                backgroundColor: PassengerShellTheme.primaryGreen,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              icon: const Icon(Icons.verified_user_outlined, color: Colors.white),
              label: Text('passenger_safety.im_safe'.tr, style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.icon, required this.title, required this.sub, required this.onTap});

  final IconData icon;
  final String title;
  final String sub;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: PassengerShellTheme.cardWhite,
        borderRadius: BorderRadius.circular(16),
        elevation: 1,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(color: PassengerShellTheme.softGreenBg, borderRadius: BorderRadius.circular(14)),
                  child: PhosphorIcon(icon, color: PassengerShellTheme.primaryGreen, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 15)),
                      Text(sub, style: GoogleFonts.inter(fontSize: 12, color: PassengerShellTheme.textSecondary)),
                    ],
                  ),
                ),
                PhosphorIcon(PhosphorIconsRegular.caretRight, color: PassengerShellTheme.textSecondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
