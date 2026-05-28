import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/auth/tm_auth_hero_shell.dart';
import '../../../routes/app_pages.dart';
import '../../../services/local_storage_services/local_storage_services.dart';

const double _kWelcomeCardRadius = 16;

/// Premium welcome / entry — Lexend + Inter, brand greens & navy only.
class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  bool _accepted = false;

  late final TapGestureRecognizer _termsTap;
  late final TapGestureRecognizer _privacyTap;
  late final TapGestureRecognizer _rulesTap;

  static const String _iconBanknote = 'assets/icons/banknote-arrow-up.svg';
  static const String _iconLeaf = 'assets/icons/leaf (2).svg';
  static const String _iconShield = 'assets/icons/shield-check.svg';

  Future<void> _persistLegal() async {
    await LocalStorageService().setLegalGateAccepted(true);
  }

  void _requireAcceptance(VoidCallback next) {
    if (!_accepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please accept the Terms, Privacy Policy, and App Rules to continue.',
            style: GoogleFonts.inter(fontWeight: FontWeight.w500),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    next();
  }

  @override
  void initState() {
    super.initState();
    _termsTap = TapGestureRecognizer()
      ..onTap = () => Get.toNamed<void>(Routes.TERMS);
    _privacyTap = TapGestureRecognizer()
      ..onTap = () => Get.toNamed<void>(Routes.PRIVACY);
    _rulesTap = TapGestureRecognizer()
      ..onTap = () => Get.toNamed<void>(Routes.RULES);
  }

  @override
  void dispose() {
    _termsTap.dispose();
    _privacyTap.dispose();
    _rulesTap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;

    final headingColor =
        isDark ? AppColors.darkTextPrimary : TripMatesColors.text2;
    final subtitleColor =
        isDark ? AppColors.darkTextSecondary : TripMatesColors.text3;

    final cardSurface =
        isDark ? AppColors.darkSurfaceElevated : TripMatesColors.white;
    final cardShadow =
        isDark ? <BoxShadow>[] : TripMatesColors.cardShadow;

    return TmAuthHeroShell(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(
              TmAuthLayout.hPad,
              TmAuthLayout.topPad,
              TmAuthLayout.hPad,
              TmAuthLayout.bodyBottomPad,
            ),
            child: Align(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth,
                    maxHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const TmAuthBrandedLogo(bottomGutter: 4),
                      const SizedBox(height: 22),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _WelcomeFeatureCard(
                              assetPath: _iconBanknote,
                              line1: 'Reduce',
                              line2: 'Travel Cost',
                              cardSurface: cardSurface,
                              cardShadow: cardShadow,
                              labelColor: headingColor,
                              borderColor:
                                  scheme.outline.withValues(alpha: 0.14),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _WelcomeFeatureCard(
                              assetPath: _iconLeaf,
                              line1: 'Lower',
                              line2: 'CO₂ Emissions',
                              cardSurface: cardSurface,
                              cardShadow: cardShadow,
                              labelColor: headingColor,
                              borderColor:
                                  scheme.outline.withValues(alpha: 0.14),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _WelcomeFeatureCard(
                              assetPath: _iconShield,
                              line1: 'Trusted',
                              line2: 'Partners',
                              cardSurface: cardSurface,
                              cardShadow: cardShadow,
                              labelColor: headingColor,
                              borderColor:
                                  scheme.outline.withValues(alpha: 0.14),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
                      decoration: BoxDecoration(
                        color: cardSurface,
                        borderRadius:
                            BorderRadius.circular(_kWelcomeCardRadius),
                        border: Border.all(
                          color: scheme.outline
                              .withValues(alpha: isDark ? 0.22 : 0.12),
                        ),
                        boxShadow: cardShadow,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Legal consent',
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: headingColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _LegalCheckbox(
                                value: _accepted,
                                onChanged: (v) =>
                                    setState(() => _accepted = v ?? false),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      height: 1.55,
                                      fontWeight: FontWeight.w400,
                                      color: subtitleColor,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'I have read and agree to the ',
                                      ),
                                      TextSpan(
                                        text: 'Terms',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          height: 1.55,
                                          fontWeight: FontWeight.w600,
                                          color: TripMatesColors.accent,
                                        ),
                                        recognizer: _termsTap,
                                      ),
                                      const TextSpan(text: ', '),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          height: 1.55,
                                          fontWeight: FontWeight.w600,
                                          color: TripMatesColors.accent,
                                        ),
                                        recognizer: _privacyTap,
                                      ),
                                      const TextSpan(text: ', and '),
                                      TextSpan(
                                        text: 'App Rules',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          height: 1.55,
                                          fontWeight: FontWeight.w600,
                                          color: TripMatesColors.accent,
                                        ),
                                        recognizer: _rulesTap,
                                      ),
                                      const TextSpan(text: '.'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 22),
                  Text(
                    'Get started',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lexend(
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                      letterSpacing: -0.25,
                      color: headingColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _WelcomePrimaryButton(
                    label: 'Create account',
                    onPressed: () => _requireAcceptance(() async {
                      await _persistLegal();
                      Get.toNamed<void>(Routes.REGISTER);
                    }),
                  ),
                  const SizedBox(height: 10),
                  _WelcomeOutlinedButton(
                    label: 'Log in',
                    onPressed: () => _requireAcceptance(() async {
                      await _persistLegal();
                      Get.toNamed<void>(Routes.LOGIN);
                    }),
                  ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WelcomeFeatureCard extends StatelessWidget {
  const _WelcomeFeatureCard({
    required this.assetPath,
    required this.line1,
    required this.line2,
    required this.cardSurface,
    required this.cardShadow,
    required this.labelColor,
    required this.borderColor,
  });

  final String assetPath;
  final String line1;
  final String line2;
  final Color cardSurface;
  final List<BoxShadow> cardShadow;
  final Color labelColor;
  final Color borderColor;

  static const _iconFilter =
      ColorFilter.mode(TripMatesColors.green, BlendMode.srcIn);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 14, 8, 14),
      decoration: BoxDecoration(
        color: cardSurface,
        borderRadius: BorderRadius.circular(_kWelcomeCardRadius),
        border: Border.all(color: borderColor),
        boxShadow: cardShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            assetPath,
            width: 30,
            height: 30,
            colorFilter: _iconFilter,
          ),
          const SizedBox(height: 10),
          Text(
            line1,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              height: 1.2,
              color: labelColor,
            ),
          ),
          Text(
            line2,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              height: 1.2,
              color: labelColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _LegalCheckbox extends StatelessWidget {
  const _LegalCheckbox({
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      checked: value,
      label: 'Accept Terms, Privacy Policy, and App Rules',
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: TripMatesColors.green,
              width: 2,
            ),
            color: value ? TripMatesColors.green : Colors.transparent,
            boxShadow: value
                ? [
                    BoxShadow(
                      color: TripMatesColors.green.withValues(alpha: 0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: value
              ? Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: TripMatesColors.white,
                )
              : null,
        ),
      ),
    );
  }
}

class _WelcomePrimaryButton extends StatelessWidget {
  const _WelcomePrimaryButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(_kWelcomeCardRadius);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: r,
            boxShadow: TripMatesColors.primaryButtonShadow,
          ),
          child: Material(
            color: TripMatesColors.green,
            borderRadius: r,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onPressed,
              splashColor: Colors.white.withValues(alpha: 0.14),
              highlightColor: Colors.white.withValues(alpha: 0.07),
              child: SizedBox(
                height: 54,
                width: double.infinity,
                child: Center(
                  child: Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.15,
                      color: TripMatesColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomeOutlinedButton extends StatelessWidget {
  const _WelcomeOutlinedButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fill =
        isDark ? AppColors.darkSurface : TripMatesColors.white;
    final r = BorderRadius.circular(_kWelcomeCardRadius);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Material(
          color: fill,
          borderRadius: r,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            splashColor: TripMatesColors.green.withValues(alpha: 0.08),
            highlightColor: TripMatesColors.green.withValues(alpha: 0.05),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: r,
                border: Border.all(
                  color: TripMatesColors.green,
                  width: 1.75,
                ),
              ),
              child: SizedBox(
                height: 54,
                width: double.infinity,
                child: Center(
                  child: Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.15,
                      color: TripMatesColors.green,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
