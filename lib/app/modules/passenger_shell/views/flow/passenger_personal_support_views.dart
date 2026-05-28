import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../controllers/passenger_flow_controller.dart';
import '../../theme/passenger_shell_theme.dart';

class PassengerPersonalDetailsView extends GetView<PassengerFlowController> {
  const PassengerPersonalDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PassengerShellTheme.screenBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TmMintAppBar(title: 'passenger_personal.title'.tr, showBack: true, onBack: controller.popFlowOrShell),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                children: [
                  Text('passenger_personal.sub'.tr, style: GoogleFonts.inter(color: PassengerShellTheme.textSecondary, height: 1.45)),
                  const SizedBox(height: 20),
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: PassengerShellTheme.softGreenBg,
                          child: PhosphorIcon(PhosphorIconsRegular.user, size: 48, color: PassengerShellTheme.primaryGreen),
                        ),
                        Positioned(
                          right: -4,
                          bottom: -4,
                          child: Material(
                            color: PassengerShellTheme.primaryGreen,
                            shape: const CircleBorder(),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () => Get.snackbar('passenger_personal.photo'.tr, 'passenger_search.pick_hint'.tr),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      onPressed: () => Get.snackbar('passenger_personal.change_photo'.tr, 'passenger_search.pick_hint'.tr),
                      child: Text('passenger_personal.change_photo'.tr, style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: PassengerShellTheme.primaryGreen)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _LabeledField(label: 'passenger_personal.name'.tr, controller: controller.personalName),
                  const SizedBox(height: 12),
                  _LabeledField(label: 'passenger_personal.email'.tr, controller: controller.personalEmail, keyboard: TextInputType.emailAddress),
                  const SizedBox(height: 12),
                  _LabeledField(label: 'passenger_personal.phone'.tr, controller: controller.personalPhone, keyboard: TextInputType.phone),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.22), blurRadius: 12, offset: const Offset(0, 5))],
                ),
                child: FilledButton(
                  onPressed: () async {
                    await controller.savePersonalDetails();
                    Get.back<void>();
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: PassengerShellTheme.primaryGreen,
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text('passenger_personal.save'.tr, style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.controller, this.keyboard});

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboard;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: PassengerShellTheme.textSecondary)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboard,
          decoration: InputDecoration(
            filled: true,
            fillColor: PassengerShellTheme.cardWhite,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ],
    );
  }
}

class PassengerSupportView extends GetView<PassengerFlowController> {
  const PassengerSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PassengerShellTheme.screenBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TmMintAppBar(title: 'passenger_support.title'.tr, showBack: true, onBack: controller.popFlowOrShell),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                children: [
                  Text('passenger_support.sub'.tr, style: GoogleFonts.inter(color: PassengerShellTheme.textSecondary, height: 1.45)),
                  const SizedBox(height: 18),
                  _Tile(icon: PhosphorIconsRegular.chatCircle, title: 'passenger_support.faqs'.tr, onTap: () => controller.dummySupport('passenger_support.faqs')),
                  _Tile(icon: PhosphorIconsRegular.chatCircleText, title: 'passenger_support.contact'.tr, onTap: () => controller.dummySupport('passenger_support.contact')),
                  _Tile(icon: PhosphorIconsRegular.flag, title: 'passenger_support.report'.tr, onTap: () => controller.dummySupport('passenger_support.report')),
                  _Tile(icon: PhosphorIconsRegular.info, title: 'passenger_support.about'.tr, onTap: () => controller.dummySupport('passenger_support.about')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.icon, required this.title, required this.onTap});

  final IconData icon;
  final String title;
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
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: PassengerShellTheme.softGreenBg, borderRadius: BorderRadius.circular(12)),
                  child: PhosphorIcon(icon, color: PassengerShellTheme.primaryGreen, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 15))),
                PhosphorIcon(PhosphorIconsRegular.caretRight, color: PassengerShellTheme.textSecondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
