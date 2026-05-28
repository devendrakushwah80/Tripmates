import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../driver_shell/theme/driver_shell_theme.dart';
import '../../../services/local_storage_services/local_storage_services.dart';
import '../controllers/driver_identity_controller.dart';

class DriverIdentityDetailsView extends GetView<DriverIdentityController> {
  const DriverIdentityDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DriverShellTheme.screenBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TmMintAppBar(title: 'driver_identity.title'.tr, showBack: true),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
                children: [
                  Text(
                    'driver_identity.intro'.tr,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      height: 1.45,
                      fontWeight: FontWeight.w500,
                      color: DriverShellTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _GlassCard(
                    child: Column(
                      children: [
                        GetBuilder<DriverIdentityController>(
                          id: 'photo',
                          builder: (c) {
                            final path = LocalStorageService().getProfilePhotoPath();
                            final has = path.isNotEmpty && File(path).existsSync();
                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: 52,
                                  backgroundColor: DriverShellTheme.softGreenBg,
                                  backgroundImage: has ? FileImage(File(path)) : null,
                                  child: !has
                                      ? Icon(Icons.person_rounded, size: 52, color: DriverShellTheme.textSecondary)
                                      : null,
                                ),
                                Positioned(
                                  right: -4,
                                  bottom: 4,
                                  child: Material(
                                    color: DriverShellTheme.primaryGreen,
                                    shape: const CircleBorder(),
                                    child: InkWell(
                                      customBorder: const CircleBorder(),
                                      onTap: c.pickProfilePhoto,
                                      child: const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: DriverShellTheme.softGreenBg,
                            borderRadius: BorderRadius.circular(99),
                            boxShadow: DriverShellTheme.badgeShadow,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.verified_rounded, size: 18, color: DriverShellTheme.primaryGreen),
                              const SizedBox(width: 6),
                              Text(
                                'driver_identity.verified'.tr,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                  color: DriverShellTheme.primaryGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  _GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'driver_identity.section_contact'.tr,
                          style: GoogleFonts.lexend(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: DriverShellTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: controller.nameController,
                          decoration: _inputDec('driver_identity.full_name'.tr),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _inputDec('driver_identity.email'.tr),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: _inputDec('driver_identity.phone'.tr),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  _GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'driver_identity.section_license'.tr,
                          style: GoogleFonts.lexend(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: DriverShellTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _ReadOnlyRow('driver_identity.license_number'.tr, controller.licenseNumber),
                        const SizedBox(height: 8),
                        _ReadOnlyRow('driver_identity.license_expiry'.tr, controller.licenseExpiryDisplay),
                        const SizedBox(height: 8),
                        _ReadOnlyRow('driver_identity.driver_status'.tr, 'driver_identity.status_verified'.tr),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  _GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'driver_identity.selfie_heading'.tr,
                                style: GoogleFonts.lexend(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: DriverShellTheme.textPrimary,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: DriverShellTheme.textSecondary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'driver_identity.locked'.tr,
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: DriverShellTheme.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'driver_identity.selfie_hint'.tr,
                          style: GoogleFonts.inter(fontSize: 12, color: DriverShellTheme.textSecondary, height: 1.35),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: AspectRatio(
                            aspectRatio: 4 / 3,
                            child: _SelfiePreview(controller: controller),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: DriverShellTheme.primaryGreen.withValues(alpha: 0.25),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: FilledButton(
                      onPressed: controller.saveEdits,
                      style: FilledButton.styleFrom(
                        backgroundColor: DriverShellTheme.primaryGreen,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(
                        'driver_identity.save'.tr,
                        style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: Colors.white),
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

  static InputDecoration _inputDec(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.65),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    );
  }
}

class _SelfiePreview extends StatelessWidget {
  const _SelfiePreview({required this.controller});

  final DriverIdentityController controller;

  @override
  Widget build(BuildContext context) {
    final p = controller.lockedSelfiePath;
    final has = p.isNotEmpty && File(p).existsSync();
    if (!has) {
      return ColoredBox(
        color: DriverShellTheme.softGreenBg,
        child: Center(
          child: Icon(Icons.face_retouching_natural, size: 56, color: DriverShellTheme.textSecondary),
        ),
      );
    }
    return Image.file(File(p), fit: BoxFit.cover);
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DriverShellTheme.cardWhite.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.65)),
        boxShadow: DriverShellTheme.cardShadow,
      ),
      child: child,
    );
  }
}

class _ReadOnlyRow extends StatelessWidget {
  const _ReadOnlyRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: DriverShellTheme.softGreenBg.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: DriverShellTheme.primaryGreen.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: DriverShellTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: DriverShellTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
