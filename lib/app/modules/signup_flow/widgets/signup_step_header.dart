import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/widgets/auth/tm_auth_hero_shell.dart';
import 'signup_flow_tokens.dart';

/// Top progress + back + title — lighter hierarchy, TripMates greens (no blue chrome).
class SignupStepHeader extends StatelessWidget {
  const SignupStepHeader({
    super.key,
    required this.step,
    this.totalSteps = 7,
    required this.title,
    this.showBack = true,
    this.onBack,
  });

  final int step;
  final int totalSteps;
  final String title;
  final bool showBack;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;
    final iconColor =
        isDark ? scheme.onSurface : TmAuthTokens.primaryGreen;
    final titleColor =
        isDark ? scheme.onSurface : TmAuthTokens.textPrimary;
    final clamped = step.clamp(1, totalSteps);
    final progress = clamped / totalSteps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            SignupFlowLayout.hPad,
            10,
            SignupFlowLayout.hPad,
            0,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 3,
              backgroundColor: TmAuthTokens.softGreen,
              color: TmAuthTokens.primaryGreen,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 10, 2, 8),
          child: Row(
            children: [
              SizedBox(
                width: 44,
                child: showBack
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: iconColor,
                          size: 18,
                        ),
                        onPressed: onBack ?? () => Get.back<void>(),
                      )
                    : const SizedBox.shrink(),
              ),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexend(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.25,
                    height: 1.25,
                    color: titleColor,
                  ),
                ),
              ),
              SizedBox(
                width: 44,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '$clamped/$totalSteps',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15,
                      color: titleColor.withValues(alpha: 0.48),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SignupFlowLayout.hPad),
          child: Divider(
            height: 1,
            thickness: 1,
            color: scheme.outline.withValues(alpha: isDark ? 0.28 : 0.12),
          ),
        ),
      ],
    );
  }
}
