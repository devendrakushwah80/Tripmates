import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/auth/tm_auth_hero_shell.dart';
import '../../../core/widgets/tripmates/tm_components.dart';
import '../../../routes/app_pages.dart';
import '../../../services/local_storage_services/local_storage_services.dart';

/// Camera-only captures to reduce gallery random-image abuse (production: add ML liveness).
class IdentityVerifyView extends StatefulWidget {
  const IdentityVerifyView({super.key});

  @override
  State<IdentityVerifyView> createState() => _IdentityVerifyViewState();
}

class _IdentityVerifyViewState extends State<IdentityVerifyView> {
  final ImagePicker _picker = ImagePicker();
  String? _profilePath;
  String? _selfie1;
  String? _selfie2;
  bool _busy = false;

  Future<bool> _validateCapture(String path) async {
    final len = await File(path).length();
    if (len < 9000) {
      Get.snackbar('Photo too small', 'Please retake with better lighting.');
      return false;
    }
    return true;
  }

  Future<void> _pickProfile() async {
    setState(() => _busy = true);
    try {
      final x = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 88,
      );
      if (x == null) return;
      if (!await _validateCapture(x.path)) return;
      setState(() => _profilePath = x.path);
      await LocalStorageService().setProfilePhotoPath(x.path);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _pickSelfie(int which) async {
    setState(() => _busy = true);
    try {
      final x = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 82,
      );
      if (x == null) return;
      if (!await _validateCapture(x.path)) return;
      setState(() {
        if (which == 1) {
          _selfie1 = x.path;
        } else {
          _selfie2 = x.path;
        }
      });
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _finish() async {
    if (_profilePath == null || _selfie1 == null || _selfie2 == null) {
      Get.snackbar('Incomplete', 'Profile photo and two live captures are required.');
      return;
    }
    if (_selfie1 == _selfie2) {
      Get.snackbar('Liveness', 'Please take two separate captures.');
      return;
    }
    await LocalStorageService().setSelfieVerificationPaths('$_selfie1|$_selfie2');
    await LocalStorageService().setSelfieVerified(true);
    if (mounted) {
      Get.snackbar('Verified', 'Identity check saved for this device (demo).');
      Get.offAllNamed<void>(Routes.ACCOUNT);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TmAuthHeroShell(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 12, 4),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Get.back<void>(),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: isDark ? scheme.onSurface : TmAuthTokens.primaryGreen,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Trust & verification',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDark ? scheme.onSurface : TmAuthTokens.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                color: TmAuthTokens.primaryGreen.withValues(alpha: isDark ? 0.5 : 0.35),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                TmAuthLayout.hPad,
                TmAuthLayout.topPad,
                TmAuthLayout.hPad,
                TmAuthLayout.bottomPad,
              ),
              children: [
                  const SizedBox(height: 12),
                  Text(
                    'Real identity helps keep TripMates safe.',
                    style: GoogleFonts.lexend(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Use your camera only. We compare two sequential selfies as a lightweight liveness step before you drive or book.',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      height: 1.5,
                      color: scheme.onSurface.withValues(alpha: 0.72),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _glassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('1 · Profile photo', style: GoogleFonts.lexend(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: _busy ? null : _pickProfile,
                          icon: const Icon(Icons.photo_camera_front_outlined),
                          label: Text(_profilePath == null ? 'Capture with camera' : 'Retake'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _glassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('2 · Live selfie A', style: GoogleFonts.lexend(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: _busy ? null : () => _pickSelfie(1),
                          icon: const Icon(Icons.face_retouching_natural),
                          label: Text(_selfie1 == null ? 'Capture (neutral)' : 'Retake A'),
                        ),
                        const SizedBox(height: 12),
                        Text('3 · Live selfie B', style: GoogleFonts.lexend(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: _busy ? null : () => _pickSelfie(2),
                          icon: const Icon(Icons.face),
                          label: Text(_selfie2 == null ? 'Capture (slight smile)' : 'Retake B'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  TmPrimaryButton(
                    label: _busy ? 'Please wait…' : 'Submit verification',
                    onPressed: _busy ? null : _finish,
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}

Widget _glassCard({required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0.95),
          const Color(0xFFE8F5EE).withValues(alpha: 0.9),
        ],
      ),
      border: Border.all(color: TripMatesColors.divider),
      boxShadow: TripMatesColors.glossyCardShadow,
    ),
    child: child,
  );
}
