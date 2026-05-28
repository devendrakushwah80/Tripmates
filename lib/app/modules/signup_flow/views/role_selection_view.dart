import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/auth/tm_auth_hero_shell.dart';
import '../../../core/widgets/tripmates/tm_components.dart';
import '../controllers/role_selection_controller.dart';
import '../widgets/signup_flow_layout.dart';

class RoleSelectionView extends GetView<RoleSelectionController> {
  const RoleSelectionView({super.key});

  static const String _passengerPassportAsset = 'assets/passport (1).png';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SignupFlowPageScaffold(
      step: 7,
      title: 'signup.role.title'.tr,
      scrollable: LayoutBuilder(
        builder: (context, c) {
          const gapAfterSubtitle = 12.0;
          const gapTiles = 12.0;

          /// Subtitle + compact logo + gaps (keep tiles fitting without scroll).
          const reservedAboveTiles = 118.0;
          final usable = (c.maxHeight - reservedAboveTiles - gapTiles).clamp(
            120.0,
            400.0,
          );
          final tileH = (usable * 0.5).clamp(100.0, 148.0);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 18),
              Text(
                'signup.role.subtitle'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  height: 1.45,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.1,
                  color: isDark ? TripMatesColors.text4 : TripMatesColors.text3,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: tileH,
                child: Obx(() {
                  final sel = controller.selected.value;
                  return _RoleOptionTile(
                    title: 'signup.role.driver'.tr,
                    subtitle: 'signup.role.driver_sub'.tr,
                    leading: _RoleIconChip(
                      isDark: isDark,
                      selected: sel == 'driver',
                      child: PhosphorIcon(
                        PhosphorIconsRegular.steeringWheel,
                        size: 26,
                        color: sel == 'driver'
                            ? TripMatesColors.green
                            : (isDark
                                  ? scheme.onSurface.withValues(alpha: 0.72)
                                  : TripMatesColors.text3),
                      ),
                    ),
                    selected: sel == 'driver',
                    onTap: controller.selectDriver,
                    scheme: scheme,
                    isDark: isDark,
                  );
                }),
              ),
              const SizedBox(height: gapTiles),
              SizedBox(
                height: tileH,
                child: Obx(() {
                  final sel = controller.selected.value;
                  return _RoleOptionTile(
                    title: 'signup.role.passenger'.tr,
                    subtitle: 'signup.role.passenger_sub'.tr,
                    leading: _RoleIconChip(
                      isDark: isDark,
                      selected: sel == 'passenger',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Image.asset(
                            _passengerPassportAsset,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                            errorBuilder: (context, error, stackTrace) =>
                                PhosphorIcon(
                                  PhosphorIconsRegular.identificationCard,
                                  size: 28,
                                  color: TripMatesColors.green.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ),
                    selected: sel == 'passenger',
                    onTap: controller.selectPassenger,
                    scheme: scheme,
                    isDark: isDark,
                  );
                }),
              ),
            ],
          );
        },
      ),
      bottom: [
        TmPrimaryButton(
          label: 'signup.role.cta'.tr,
          onPressed: controller.finishAndEnterApp,
        ),
      ],
    );
  }
}

class _RoleIconChip extends StatelessWidget {
  const _RoleIconChip({
    required this.child,
    required this.selected,
    required this.isDark,
  });

  final Widget child;
  final bool selected;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final bg = TripMatesColors.green.withValues(alpha: selected ? 0.16 : 0.09);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: TripMatesColors.green.withValues(alpha: selected ? 0.22 : 0.1),
          width: 1,
        ),
      ),
      child: SizedBox(width: 52, height: 52, child: Center(child: child)),
    );
  }
}

class _RoleOptionTile extends StatelessWidget {
  const _RoleOptionTile({
    required this.title,
    required this.subtitle,
    required this.leading,
    required this.selected,
    required this.onTap,
    required this.scheme,
    required this.isDark,
  });

  final String title;
  final String subtitle;
  final Widget leading;
  final bool selected;
  final VoidCallback onTap;
  final ColorScheme scheme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final tileFill = isDark
        ? (selected
              ? scheme.surface.withValues(alpha: 0.98)
              : scheme.surface.withValues(alpha: 0.55))
        : TripMatesColors.white;

    final borderColor = selected
        ? TripMatesColors.green
        : (isDark
              ? scheme.outline.withValues(alpha: 0.32)
              : TripMatesColors.divider.withValues(alpha: 0.92));
    final double borderWidth = selected ? 2.0 : 1.0;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: TripMatesColors.green.withValues(alpha: 0.08),
        highlightColor: TripMatesColors.green.withValues(alpha: 0.04),
        child: Ink(
          decoration: BoxDecoration(
            color: tileFill,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: borderWidth),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.12 : 0.04),
                blurRadius: 14,
                offset: const Offset(0, 5),
                spreadRadius: -4,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                leading,
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lexend(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.22,
                          height: 1.2,
                          color: isDark
                              ? scheme.onSurface
                              : TripMatesColors.text2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          height: 1.35,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.02,
                          color: isDark
                              ? TripMatesColors.text4
                              : TripMatesColors.text3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  child: selected
                      ? Container(
                          key: const ValueKey<String>('on'),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: TripMatesColors.green,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: TripMatesColors.green.withValues(
                                  alpha: 0.28,
                                ),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: TripMatesColors.white,
                            size: 18,
                          ),
                        )
                      : SizedBox(
                          key: const ValueKey<String>('off'),
                          width: 30,
                          height: 30,
                          child: Icon(
                            Icons.circle_outlined,
                            size: 20,
                            color: scheme.outline.withValues(alpha: 0.32),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
