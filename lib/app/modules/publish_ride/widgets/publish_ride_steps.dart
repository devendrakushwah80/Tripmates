import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart';

import '../../../core/widgets/publish_route_map.dart';
import '../../driver_shell/theme/driver_shell_theme.dart';
import '../controllers/publish_ride_controller.dart';
import 'publish_ride_location_sheet.dart';

class PublishFlowStepper extends StatelessWidget {
  const PublishFlowStepper({super.key, required this.stepIndex});

  /// 0–5 (success = 5).
  final int stepIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 10),
      child: Row(
        children: [
          for (int i = 0; i < 6; i++) ...[
            _node(
              done: stepIndex > i || stepIndex >= 5,
              active: stepIndex == i && stepIndex < 5,
              label: '${i + 1}',
            ),
            if (i < 5)
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeOutCubic,
                  height: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    color: stepIndex > i || stepIndex >= 5
                        ? DriverShellTheme.primaryGreen
                        : DriverShellTheme.textSecondary.withValues(
                            alpha: 0.15,
                          ),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _node({
    required bool done,
    required bool active,
    required String label,
  }) {
    final bg = done
        ? DriverShellTheme.primaryGreen
        : active
        ? DriverShellTheme.primaryGreen
        : DriverShellTheme.textSecondary.withValues(alpha: 0.12);
    final fg = done || active ? Colors.white : DriverShellTheme.textSecondary;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        boxShadow: active && !done
            ? [
                BoxShadow(
                  color: DriverShellTheme.primaryGreen.withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: fg,
        ),
      ),
    );
  }
}

class PublishRouteStep extends GetView<PublishRideController> {
  const PublishRouteStep({super.key});

  void _open(bool origin) {
    Get.bottomSheet<void>(
      PublishRideLocationSheet(forOrigin: origin),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const kRouteCardH = 64.0;
    const kRouteGutter = 48.0;
    const kSwapFab = 56.0;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
      children: [
        Text(
          'publish_ride.route_intro'.tr,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: DriverShellTheme.textSecondary,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: kRouteCardH + kRouteGutter + kRouteCardH,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Obx(
                    () => _LocCard(
                      label: 'publish_ride.origin'.tr,
                      value: controller.originPlace.value?.shortLabel,
                      hint: 'publish_ride.tap_origin'.tr,
                      onTap: () => _open(true),
                    ),
                  ),
                  const SizedBox(height: kRouteGutter),
                  Obx(
                    () => _LocCard(
                      label: 'publish_ride.destination'.tr,
                      value: controller.destPlace.value?.shortLabel,
                      hint: 'publish_ride.tap_destination'.tr,
                      onTap: () => _open(false),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: kRouteCardH + kRouteGutter / 2 - kSwapFab / 2,
                left: 0,
                right: 0,
                child: Center(
                  child: Material(
                    elevation: 6,
                    shadowColor: DriverShellTheme.primaryGreen.withValues(
                      alpha: 0.35,
                    ),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: controller.swapEndpoints,
                      child: Ink(
                        width: kSwapFab,
                        height: kSwapFab,
                        decoration: BoxDecoration(
                          color: DriverShellTheme.primaryGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.swap_vert_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Obx(() {
          final pts = controller.routePoints.toList();
          final o = controller.originPlace.value;
          final d = controller.destPlace.value;
          final LatLng? oL = o != null ? LatLng(o.lat, o.lon) : null;
          final LatLng? dL = d != null ? LatLng(d.lat, d.lon) : null;
          return PublishRouteMap(
            routePoints: pts,
            origin: oL,
            destination: dL,
            height: 220,
            loading: controller.routeLoading.value,
          );
        }),
        const SizedBox(height: 8),
        Text(
          'publish_ride.map_hint'.tr,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: DriverShellTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => controller.goBack(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: DriverShellTheme.primaryGreen,
                  side: BorderSide(
                    color: DriverShellTheme.primaryGreen,
                    width: 1.2,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'publish_ride.back'.tr,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: Obx(() {
                final ok = controller.canContinueRoute;
                return FilledButton(
                  onPressed: ok ? () => controller.goNextFromRoute() : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: DriverShellTheme.primaryGreen,
                    disabledBackgroundColor: scheme.surfaceContainerHighest,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'publish_ride.continue_btn'.tr,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }
}

class _LocCard extends StatelessWidget {
  const _LocCard({
    required this.label,
    required this.value,
    required this.hint,
    required this.onTap,
  });

  final String label;
  final String? value;
  final String hint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final has = value != null && value!.isNotEmpty;
    return Material(
      color: DriverShellTheme.cardWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: has
              ? DriverShellTheme.primaryGreen.withValues(alpha: 0.45)
              : scheme.outline.withValues(alpha: 0.22),
          width: has ? 1.4 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 64,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Icon(
                  Icons.place_outlined,
                  color: has
                      ? DriverShellTheme.primaryGreen
                      : DriverShellTheme.textSecondary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: DriverShellTheme.textSecondary,
                        ),
                      ),
                      Text(
                        has ? value! : hint,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: has
                              ? DriverShellTheme.textPrimary
                              : DriverShellTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: DriverShellTheme.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PublishDateStep extends GetView<PublishRideController> {
  const PublishDateStep({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = MaterialLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
      children: [
        Text(
          'publish_ride.date_intro'.tr,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: DriverShellTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 16),
        Obx(() {
          final d = controller.travelDate.value;
          final label = DateFormat.yMMMd().format(d);
          return _PickerTile(
            icon: Icons.calendar_month_rounded,
            title: 'publish_ride.travel_date'.tr,
            value: label,
            onTap: () => controller.pickDate(context),
          );
        }),
        const SizedBox(height: 12),
        Obx(() {
          final t = controller.pickupTime.value;
          final label = loc.formatTimeOfDay(t, alwaysUse24HourFormat: false);
          return _PickerTile(
            icon: Icons.schedule_rounded,
            title: 'publish_ride.pickup_time'.tr,
            value: label,
            onTap: () => controller.pickTime(context),
          );
        }),
        const SizedBox(height: 28),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => controller.goBack(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: DriverShellTheme.primaryGreen,
                  side: BorderSide(
                    color: DriverShellTheme.primaryGreen,
                    width: 1.2,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'publish_ride.back'.tr,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: FilledButton(
                onPressed: () => controller.goNextFromDate(),
                style: FilledButton.styleFrom(
                  backgroundColor: DriverShellTheme.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'publish_ride.continue_btn'.tr,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PickerTile extends StatelessWidget {
  const _PickerTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: DriverShellTheme.cardWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outline.withValues(alpha: 0.2)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Icon(icon, color: DriverShellTheme.primaryGreen),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: DriverShellTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: DriverShellTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.edit_calendar_outlined,
                color: DriverShellTheme.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PublishDetailsStep extends GetView<PublishRideController> {
  const PublishDetailsStep({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
      children: [
        Text(
          'publish_ride.details_intro'.tr,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: DriverShellTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'publish_ride.seats'.tr,
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Obx(() {
          return Row(
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: scheme.surfaceContainerHighest,
                ),
                onPressed: controller.seats.value > 1
                    ? () => controller.setSeats(controller.seats.value - 1)
                    : null,
                icon: const Icon(Icons.remove_rounded),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '${controller.seats.value}',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: scheme.surfaceContainerHighest,
                ),
                onPressed: controller.seats.value < 8
                    ? () => controller.setSeats(controller.seats.value + 1)
                    : null,
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          );
        }),
        const SizedBox(height: 18),
        Text(
          'publish_ride.price_hint'.tr,
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller.priceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            prefixText: '₹ ',
            filled: true,
            fillColor: scheme.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'publish_ride.ride_type'.tr,
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Obx(() {
          final rt = controller.isRoundTrip.value;
          return Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: Text('publish_ride.one_way'.tr),
                  selected: !rt,
                  onSelected: (_) => controller.isRoundTrip.value = false,
                  selectedColor: DriverShellTheme.softGreenBg,
                  labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ChoiceChip(
                  label: Text('publish_ride.round_trip'.tr),
                  selected: rt,
                  onSelected: (_) => controller.isRoundTrip.value = true,
                  selectedColor: DriverShellTheme.softGreenBg,
                  labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          );
        }),
        const SizedBox(height: 16),
        Text(
          'publish_ride.options'.tr,
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilterChip(
                label: Text('publish_ride.opt_luggage'.tr),
                selected: controller.luggageOk.value,
                onSelected: (v) => controller.luggageOk.value = v,
              ),
              FilterChip(
                label: Text('publish_ride.opt_women'.tr),
                selected: controller.womenOnly.value,
                onSelected: (v) => controller.womenOnly.value = v,
              ),
              FilterChip(
                label: Text('publish_ride.opt_pets'.tr),
                selected: controller.petsOk.value,
                onSelected: (v) => controller.petsOk.value = v,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => controller.goBack(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: DriverShellTheme.primaryGreen,
                  side: BorderSide(
                    color: DriverShellTheme.primaryGreen,
                    width: 1.2,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'publish_ride.back'.tr,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: Obx(() {
                final ok = controller.canContinueDetails;
                return FilledButton(
                  onPressed: ok ? () => controller.goNextFromDetails() : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: DriverShellTheme.primaryGreen,
                    disabledBackgroundColor: scheme.surfaceContainerHighest,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'publish_ride.continue_btn'.tr,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }
}

class PublishReviewStep extends GetView<PublishRideController> {
  const PublishReviewStep({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = MaterialLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
      children: [
        Text(
          'publish_ride.review_intro'.tr,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: DriverShellTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          final o = controller.originPlace.value;
          final d = controller.destPlace.value;
          final pts = controller.routePoints.toList();
          final LatLng? oL = o != null ? LatLng(o.lat, o.lon) : null;
          final LatLng? dL = d != null ? LatLng(d.lat, d.lon) : null;
          return PublishRouteMap(
            routePoints: pts,
            origin: oL,
            destination: dL,
            height: 160,
            loading: false,
          );
        }),
        const SizedBox(height: 14),
        Obx(() {
          final o = controller.originPlace.value;
          final d = controller.destPlace.value;
          final dt = controller.combinedDateTime;
          final t = controller.pickupTime.value;
          final timeStr = loc.formatTimeOfDay(t, alwaysUse24HourFormat: false);
          final dateStr = DateFormat.yMMMd().format(dt);
          final price = controller.priceController.text.replaceAll(
            RegExp(r'[^0-9]'),
            '',
          );
          final rt = controller.isRoundTrip.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ReviewRow('publish_ride.origin', o?.shortLabel ?? '—'),
              _ReviewRow('publish_ride.destination', d?.shortLabel ?? '—'),
              _ReviewRow('publish_ride.travel_date', dateStr),
              _ReviewRow('publish_ride.pickup_time', timeStr),
              _ReviewRow('publish_ride.seats', '${controller.seats.value}'),
              _ReviewRow('publish_ride.price_label', '₹$price'),
              _ReviewRow(
                'publish_ride.ride_type',
                rt ? 'publish_ride.round_trip'.tr : 'publish_ride.one_way'.tr,
              ),
              if (controller.luggageOk.value)
                _ReviewRow('publish_ride.opt_luggage', '✓'),
              if (controller.womenOnly.value)
                _ReviewRow('publish_ride.opt_women', '✓'),
              if (controller.petsOk.value)
                _ReviewRow('publish_ride.opt_pets', '✓'),
            ],
          );
        }),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => controller.goBack(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: DriverShellTheme.primaryGreen,
                  side: BorderSide(
                    color: DriverShellTheme.primaryGreen,
                    width: 1.2,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'publish_ride.back'.tr,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: FilledButton(
                onPressed: () => controller.goNextFromReview(),
                style: FilledButton.styleFrom(
                  backgroundColor: DriverShellTheme.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'publish_ride.proceed_payment'.tr,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PublishPaymentStep extends GetView<PublishRideController> {
  const PublishPaymentStep({super.key});

  static const _kCard = 'assets/icons/credit-card (1).png';
  static const _kPaypal = 'assets/icons/social.png';
  static const _kSwish = 'assets/icons/swish.svg';

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: DriverShellTheme.screenBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              children: [
                Text(
                  'publish_ride.payment_title'.tr,
                  style: GoogleFonts.lexend(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: DriverShellTheme.textPrimary,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'publish_ride.payment_subtitle'.tr,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: DriverShellTheme.textSecondary,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 22),
                Center(
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 360),
                    padding: const EdgeInsets.symmetric(
                      vertical: 26,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: DriverShellTheme.softGreenBg,
                      boxShadow: [
                        BoxShadow(
                          color: DriverShellTheme.primaryGreen.withValues(
                            alpha: 0.12,
                          ),
                          blurRadius: 28,
                          spreadRadius: 2,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Text(
                      'publish_ride.payment_amount'.tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lexend(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: DriverShellTheme.primaryGreen,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                Text(
                  'publish_ride.payment_methods_heading'.tr,
                  style: GoogleFonts.lexend(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: DriverShellTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Obx(() {
                  final sel = controller.selectedPaymentMethod.value;
                  return Column(
                    children: [
                      _PayMethodRow(
                        title: 'publish_ride.pay_card'.tr,
                        subtitle: null,
                        selected: sel == 'card',
                        leading: Image.asset(
                          _kCard,
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
                        ),
                        onTap: () => controller.selectPaymentMethod('card'),
                      ),
                      const SizedBox(height: 10),
                      _PayMethodRow(
                        title: 'publish_ride.pay_paypal'.tr,
                        subtitle: null,
                        selected: sel == 'paypal',
                        leading: Image.asset(
                          _kPaypal,
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
                        ),
                        onTap: () => controller.selectPaymentMethod('paypal'),
                      ),
                      const SizedBox(height: 10),
                      _PayMethodRow(
                        title: 'publish_ride.pay_swish'.tr,
                        subtitle: 'publish_ride.pay_swish_region'.tr,
                        selected: sel == 'swish',
                        leading: SvgPicture.asset(
                          _kSwish,
                          width: 40,
                          height: 40,
                        ),
                        onTap: () => controller.selectPaymentMethod('swish'),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      size: 16,
                      color: DriverShellTheme.textSecondary.withValues(
                        alpha: 0.85,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'publish_ride.payment_secure_note'.tr,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          height: 1.35,
                          color: DriverShellTheme.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Material(
            color: DriverShellTheme.screenBg,
            elevation: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => controller.goBack(),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: DriverShellTheme.primaryGreen,
                              side: BorderSide(
                                color: DriverShellTheme.primaryGreen,
                                width: 1.2,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              'publish_ride.back'.tr,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Obx(() {
                            final busy = controller.paying.value;
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: DriverShellTheme.primaryGreen
                                        .withValues(alpha: 0.35),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: FilledButton(
                                onPressed: busy
                                    ? null
                                    : () => controller.payAndPublishRide(),
                                style: FilledButton.styleFrom(
                                  backgroundColor:
                                      DriverShellTheme.primaryGreen,
                                  disabledBackgroundColor: DriverShellTheme
                                      .primaryGreen
                                      .withValues(alpha: 0.55),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: busy
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        'publish_ride.pay_publish_cta'.tr,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PayMethodRow extends StatelessWidget {
  const _PayMethodRow({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.leading,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final bool selected;
  final Widget leading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: DriverShellTheme.cardWhite,
      elevation: selected ? 2 : 0,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: selected
              ? DriverShellTheme.primaryGreen
              : const Color(0xFFE2E8F0),
          width: selected ? 1.8 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              SizedBox(width: 44, height: 44, child: Center(child: leading)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: DriverShellTheme.textPrimary,
                      ),
                    ),
                    if (subtitle != null && subtitle!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          subtitle!,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: DriverShellTheme.textSecondary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: DriverShellTheme.textSecondary.withValues(alpha: 0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow(this.labelKey, this.v);
  final String labelKey;
  final String v;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              labelKey.tr,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: DriverShellTheme.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              v,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: DriverShellTheme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PublishSuccessStep extends GetView<PublishRideController> {
  const PublishSuccessStep({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = MaterialLocalizations.of(context);
    return ColoredBox(
      color: DriverShellTheme.screenBg,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          Center(
            child: SizedBox(
              height: 140,
              child: Lottie.asset(
                'assets/lottie/Success.json',
                repeat: false,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'ride_flow.publish_success_title'.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: DriverShellTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ride_flow.publish_success_sub'.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              height: 1.45,
              color: DriverShellTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 22),
          Material(
            color: DriverShellTheme.cardWhite,
            elevation: 0,
            shadowColor: Colors.black.withValues(alpha: 0.06),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: DriverShellTheme.textSecondary.withValues(alpha: 0.12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(() {
                final o = controller.originPlace.value;
                final d = controller.destPlace.value;
                final dt = controller.combinedDateTime;
                final t = controller.pickupTime.value;
                final timeStr = loc.formatTimeOfDay(
                  t,
                  alwaysUse24HourFormat: false,
                );
                final dateStr = DateFormat.yMMMd().format(dt);
                final price = controller.priceController.text.replaceAll(
                  RegExp(r'[^0-9]'),
                  '',
                );
                final rt = controller.isRoundTrip.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'publish_ride.success_route_heading'.tr,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: DriverShellTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _ReviewRow('publish_ride.origin', o?.shortLabel ?? '—'),
                    _ReviewRow(
                      'publish_ride.destination',
                      d?.shortLabel ?? '—',
                    ),
                    _ReviewRow('publish_ride.travel_date', dateStr),
                    _ReviewRow('publish_ride.pickup_time', timeStr),
                    _ReviewRow(
                      'publish_ride.seats',
                      '${controller.seats.value}',
                    ),
                    _ReviewRow('publish_ride.price_label', '₹$price'),
                    _ReviewRow(
                      'publish_ride.ride_type',
                      rt
                          ? 'publish_ride.round_trip'.tr
                          : 'publish_ride.one_way'.tr,
                    ),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(height: 24),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: DriverShellTheme.primaryGreen.withValues(alpha: 0.28),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: FilledButton(
              onPressed: controller.finishToMyRidesTab,
              style: FilledButton.styleFrom(
                backgroundColor: DriverShellTheme.primaryGreen,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                'publish_ride.view_my_rides'.tr,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: controller.finishToDriverHomeTab,
            child: Text(
              'publish_ride.go_home'.tr,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                color: DriverShellTheme.primaryGreen,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
