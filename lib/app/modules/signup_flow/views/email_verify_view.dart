import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/auth/tm_auth_hero_shell.dart';
import '../controllers/email_verify_controller.dart';
import '../widgets/signup_flow_layout.dart';

class EmailVerifyView extends GetView<EmailVerifyController> {
  const EmailVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;
    final iconColor = isDark
        ? scheme.onSurface.withValues(alpha: 0.9)
        : TmAuthTokens.primaryGreen;

    return SignupFlowPageScaffold(
      step: 3,
      title: 'signup.email.title'.tr,
      scrollable: LayoutBuilder(
        builder: (context, c) {
          final iconSize = TmAuthLayout.decorativeIconSize(
            maxHeight: c.maxHeight.isFinite
                ? c.maxHeight
                : MediaQuery.sizeOf(context).height * 0.4,
            maxWidth: c.maxWidth,
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Center(
                child: SvgPicture.asset(
                  'assets/icons/mail.svg',
                  width: iconSize,
                  height: iconSize,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
              ),
              const SizedBox(height: 48),
              Text(
                'signup.email.body'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: isDark ? TripMatesColors.text4 : TripMatesColors.text1,
                ),
              ),
            ],
          );
        },
      ),
      bottom: [
        _EmailVerifyContinueButton(onPressed: controller.continueNext),
        const SizedBox(height: SignupFlowLayout.betweenPrimarySecondary),
        Center(
          child: TextButton(
            onPressed: controller.resend,
            style: TextButton.styleFrom(
              foregroundColor: TmAuthTokens.primaryGreen,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: Text(
              'signup.email.resend_link'.tr,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _EmailVerifyContinueButton extends StatelessWidget {
  const _EmailVerifyContinueButton({required this.onPressed});

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
                'signup.email.continue_cta'.tr,
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
