import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/auth/tm_auth_hero_shell.dart';
import '../../../core/widgets/tripmates/tm_components.dart';
import '../../../services/signup_flow_service/signup_flow_service.dart';
import '../../signup_flow/widgets/signup_flow_layout.dart';
import '../controllers/otp_verify_controller.dart';

class OtpVerifyView extends GetView<OtpVerifyController> {
  const OtpVerifyView({super.key});

  static const double _boxGap = 8;
  static const int _digitCount = 6;
  static const double _maxCell = 48;
  static const double _minCell = 40;

  TextStyle _line1Style(BuildContext context, bool isDark) {
    return GoogleFonts.inter(
      fontSize: 15,
      height: 1.55,
      fontWeight: FontWeight.w400,
      color: isDark ? TripMatesColors.text4 : TripMatesColors.text3,
    );
  }

  TextStyle _phoneStyle(BuildContext context, bool isDark) {
    return GoogleFonts.lexend(
      fontSize: 17,
      height: 1.3,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2,
      color: isDark ? TripMatesColors.white : TripMatesColors.text2,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final borderlessInput = Theme.of(context).copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.transparent,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        isDense: true,
      ),
    );

    return SignupFlowPageScaffold(
      step: 2,
      title: 'otp.screen_title'.tr,
      scrollable: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          Text(
            'otp.instruction_line1'.tr,
            textAlign: TextAlign.center,
            style: _line1Style(context, isDark),
          ),
          const SizedBox(height: 16),
          Obx(() {
            final raw = SignupFlowService.I.phone.value.trim();
            return Text(
              raw.isEmpty ? '—' : raw,
              textAlign: TextAlign.center,
              style: _phoneStyle(context, isDark),
            );
          }),
          const SizedBox(height: 32),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxW = constraints.maxWidth;
                var cell = _maxCell;
                var rowWidth = _digitCount * cell + (_digitCount - 1) * _boxGap;
                if (rowWidth > maxW) {
                  cell = ((maxW - (_digitCount - 1) * _boxGap) / _digitCount)
                      .clamp(_minCell, _maxCell)
                      .toDouble();
                  rowWidth = _digitCount * cell + (_digitCount - 1) * _boxGap;
                }
                final digitFont = (cell * 0.44).clamp(18.0, 22.0).toDouble();

                return Center(
                  child: SizedBox(
                    width: rowWidth,
                    height: cell,
                    child: Stack(
                      children: [
                        // 1. The boxes - visible but ignore pointers so they don't block hits
                        Positioned.fill(
                          child: IgnorePointer(
                            child: Obx(
                              () => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  for (var i = 0; i < _digitCount; i++)
                                    SizedBox(
                                      width: cell,
                                      height: cell,
                                      child: _OtpDigitCell(
                                        digit: i < controller.code.value.length
                                            ? controller.code.value[i]
                                            : '',
                                        cell: cell,
                                        digitFont: digitFont,
                                        scheme: scheme,
                                        isDark: isDark,
                                        isFocused:
                                            controller.isFocused.value &&
                                            (i ==
                                                    controller
                                                        .code
                                                        .value
                                                        .length ||
                                                (i == _digitCount - 1 &&
                                                    controller
                                                            .code
                                                            .value
                                                            .length ==
                                                        _digitCount)),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // 2. The actual input - on top, transparent, handles focus and typing
                        Positioned.fill(
                          child: Theme(
                            data: borderlessInput,
                            child: TextField(
                              controller: controller.hiddenInput,
                              focusNode: controller.focusNode,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              maxLength: 6,
                              style: GoogleFonts.lexend(
                                fontSize: digitFont,
                                color: Colors.transparent,
                                height: 1,
                              ),
                              decoration: const InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                isCollapsed: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              cursorColor: Colors.transparent,
                              showCursor: false,
                              autofocus: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: SignupFlowLayout.tightGap),
          Align(
            alignment: Alignment.center,
            child: Text(
              'otp.resend_hint'.tr,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: TmAuthTokens.primaryGreen,
              ),
            ),
          ),
        ],
      ),
      bottom: [
        TmPrimaryButton(
          label: 'otp.verify_cta'.tr,
          onPressed: controller.verify,
        ),
      ],
    );
  }
}

class _OtpDigitCell extends StatelessWidget {
  const _OtpDigitCell({
    required this.digit,
    required this.cell,
    required this.digitFont,
    required this.scheme,
    required this.isDark,
    this.isFocused = false,
  });

  final String digit;
  final double cell;
  final double digitFont;
  final ColorScheme scheme;
  final bool isDark;
  final bool isFocused;

  @override
  Widget build(BuildContext context) {
    final hasDigit = digit.isNotEmpty;

    // More prominent colors for visibility
    final Color activeBorderColor = TripMatesColors.green;
    final Color inactiveBorderColor = isDark
        ? scheme.outline.withValues(alpha: 0.6)
        : scheme.outline.withValues(alpha: 0.8);
    final Color focusBorderColor = TripMatesColors.green;

    final borderColor = isFocused
        ? focusBorderColor
        : (hasDigit ? activeBorderColor : inactiveBorderColor);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: isDark
            ? (isFocused
                  ? scheme.surfaceContainerHighest.withValues(alpha: 1.0)
                  : scheme.surfaceContainerHighest.withValues(alpha: 0.6))
            : (isFocused ? Colors.white : const Color(0xFFEDF5F2)),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
          width: isFocused || hasDigit ? 2.2 : 1.5,
        ),
        boxShadow: isFocused || hasDigit
            ? [
                BoxShadow(
                  color: TripMatesColors.green.withValues(alpha: 0.25),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isFocused && !hasDigit) _CursorBlinker(height: digitFont * 1.2),
            Text(
              digit,
              textAlign: TextAlign.center,
              style: GoogleFonts.lexend(
                fontSize: digitFont,
                fontWeight: FontWeight.w700,
                height: 1,
                color: isDark ? scheme.onSurface : TripMatesColors.text2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CursorBlinker extends StatefulWidget {
  const _CursorBlinker({required this.height});
  final double height;

  @override
  State<_CursorBlinker> createState() => _CursorBlinkerState();
}

class _CursorBlinkerState extends State<_CursorBlinker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 2,
        height: widget.height,
        color: TripMatesColors.green,
      ),
    );
  }
}
