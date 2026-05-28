import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/auth/tm_auth_hero_shell.dart';
import '../../signup_flow/widgets/signup_flow_layout.dart';
import '../../signup_flow/widgets/signup_step_header.dart';

/// Shared chrome for the post-signup driver verification wizard.
class DriverOnboardingShell extends StatelessWidget {
  const DriverOnboardingShell({
    super.key,
    required this.step,
    required this.title,
    required this.body,
    required this.bottomBar,
    this.onBack,
  });

  /// 1-based step (1 … 6).
  final int step;
  final String title;
  final Widget body;
  final Widget bottomBar;
  final VoidCallback? onBack;

  static const int totalDriverSteps = 6;

  @override
  Widget build(BuildContext context) {
    return TmAuthHeroShell(
      bottom: bottomBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SignupStepHeader(
            step: step,
            totalSteps: totalDriverSteps,
            title: title,
            onBack: onBack,
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, c) {
                final pad = const EdgeInsets.fromLTRB(
                  SignupFlowLayout.hPad,
                  SignupFlowLayout.topPad,
                  SignupFlowLayout.hPad,
                  SignupFlowLayout.bottomPad,
                );
                return SingleChildScrollView(
                  padding: pad,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: c.maxHeight),
                    child: Align(
                      alignment: Alignment.center,
                      child: body,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Primary CTA — existing TripMates navy gradient (unchanged).
class DriverNavyCta extends StatelessWidget {
  const DriverNavyCta({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final active = enabled && onPressed != null;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: active ? onPressed : null,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: active
                  ? [TripMatesColors.blue, TripMatesColors.blueDark]
                  : [
                      scheme.onSurface.withValues(alpha: 0.18),
                      scheme.onSurface.withValues(alpha: 0.22),
                    ],
            ),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: TripMatesColors.blue.withValues(alpha: 0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
                color: TripMatesColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
