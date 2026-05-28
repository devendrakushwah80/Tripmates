import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../core/const/app_colors.dart';
import '../controllers/verification_complete_controller.dart';
import '../widgets/signup_flow_layout.dart';

class VerificationCompleteView extends GetView<VerificationCompleteController> {
  const VerificationCompleteView({super.key});

  static const String _lottiePath = 'assets/lottie/Success.json';
  static const double _lottieSide = 220;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SignupFlowPageScaffold(
      step: 6,
      title: 'signup.complete.title'.tr,
      scrollable: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Center(
            child: SizedBox(
              width: _lottieSide,
              height: _lottieSide,
              child: Lottie.asset(
                _lottiePath,
                fit: BoxFit.contain,
                alignment: Alignment.center,
                repeat: false,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'signup.complete.body'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                height: 1.5,
                fontWeight: FontWeight.w400,
                color: isDark ? TripMatesColors.text4 : TripMatesColors.text2,
              ),
            ),
          ),
        ],
      ),
      bottom: [
        _VerificationCompleteContinueButton(
          onPressed: controller.continueNext,
        ),
      ],
    );
  }
}

class _VerificationCompleteContinueButton extends StatelessWidget {
  const _VerificationCompleteContinueButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(TripMatesColors.radiusSm);
    return Material(
      color: Colors.transparent,
      borderRadius: r,
      child: InkWell(
        onTap: onPressed,
        borderRadius: r,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: r,
            color: TripMatesColors.blue,
            boxShadow: TripMatesColors.primaryButtonShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                'signup.complete.cta'.tr,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: TripMatesColors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
