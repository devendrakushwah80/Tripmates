import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../modules/passenger_shell/theme/passenger_shell_theme.dart';

abstract class Toasts {
  static void _showCustomToast({
    required String title,
    required String message,
    required Color color,
    required IconData icon,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1E293B) : Colors.white,
      colorText: Get.isDarkMode ? Colors.white : const Color(0xFF0F172A),
      icon: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      duration: const Duration(seconds: 3),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: Text(
          'Dismiss',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: PassengerShellTheme.primaryGreen,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      titleText: Text(
        title,
        style: GoogleFonts.lexend(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Get.isDarkMode ? Colors.white : const Color(0xFF0F172A),
        ),
      ),
      messageText: Text(
        message,
        style: GoogleFonts.inter(
          fontSize: 13,
          color: Get.isDarkMode ? Colors.white.withValues(alpha: 0.7) : const Color(0xFF64748B),
        ),
      ),
    );
  }

  static Future<void> getErrorToast({required String? text}) async {
    if (text == null) return;
    _showCustomToast(
      title: 'Error',
      message: text,
      color: const Color(0xFFEF4444),
      icon: PhosphorIconsFill.xCircle,
    );
  }

  static Future<void> getSuccessToast({required String? text}) async {
    if (text == null) return;
    _showCustomToast(
      title: 'Success',
      message: text,
      color: const Color(0xFF10B981),
      icon: PhosphorIconsFill.checkCircle,
    );
  }

  static Future<void> getWarningToast({required String? text}) async {
    if (text == null) return;
    _showCustomToast(
      title: 'Warning',
      message: text,
      color: const Color(0xFFF59E0B),
      icon: PhosphorIconsFill.warningCircle,
    );
  }
}
