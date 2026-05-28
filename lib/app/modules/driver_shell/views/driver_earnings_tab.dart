import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../routes/app_pages.dart';

class DriverEarningsTab extends StatefulWidget {
  const DriverEarningsTab({super.key});

  @override
  State<DriverEarningsTab> createState() => _DriverEarningsTabState();
}

class _DriverEarningsTabState extends State<DriverEarningsTab> {
  String _range = 'week';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.backgroundLight;
    final card = isDark ? AppColors.darkSurfaceElevated : TripMatesColors.white;
    final scheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: bg,
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
          children: [
            Text(
              'driver_hub.earnings_title'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.darkTextPrimary : TripMatesColors.text2,
              ),
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _range,
                    borderRadius: BorderRadius.circular(12),
                    items: [
                      DropdownMenuItem(value: 'week', child: Text('driver_hub.filter_week'.tr)),
                      DropdownMenuItem(value: 'month', child: Text('driver_hub.filter_month'.tr)),
                    ],
                    onChanged: (v) => setState(() => _range = v ?? 'week'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: scheme.outline.withValues(alpha: 0.12)),
                boxShadow: TripMatesColors.cardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'driver_hub.total_earnings'.tr,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: TripMatesColors.text4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '₹3,200',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: TripMatesColors.green,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'driver_hub.chart_hint'.tr,
              style: GoogleFonts.inter(fontSize: 12, color: TripMatesColors.text4),
            ),
            const SizedBox(height: 10),
            _WeekBars(isDark: isDark),
            const SizedBox(height: 22),
            _EarningsLink(
              icon: Icons.account_balance_wallet_outlined,
              title: 'driver_hub.wallet_row'.tr,
              subtitle: 'driver_hub.wallet_sub'.tr,
              card: card,
              scheme: scheme,
              route: Routes.DRIVER_WALLET,
            ),
            const SizedBox(height: 10),
            _EarningsLink(
              icon: Icons.history,
              title: 'driver_hub.payout_row'.tr,
              subtitle: 'driver_hub.payout_sub'.tr,
              card: card,
              scheme: scheme,
              route: Routes.DRIVER_PAYOUT_HISTORY,
            ),
            const SizedBox(height: 10),
            _EarningsLink(
              icon: Icons.summarize_outlined,
              title: 'driver_hub.summary_row'.tr,
              subtitle: 'driver_hub.summary_sub'.tr,
              card: card,
              scheme: scheme,
              route: Routes.DRIVER_EARNINGS_SUMMARY,
            ),
          ],
        ),
      ),
    );
  }
}

class _WeekBars extends StatelessWidget {
  const _WeekBars({required this.isDark});

  final bool isDark;

  static const _heights = [0.35, 0.55, 0.42, 0.68, 0.5, 0.78, 0.62];
  static const _labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    final card = isDark ? AppColors.darkSurfaceElevated : TripMatesColors.white;
    return Container(
      height: 160,
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(7, (i) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: _heights[i],
                        widthFactor: 1,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                TripMatesColors.accent,
                                TripMatesColors.accent.withValues(alpha: 0.65),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _labels[i],
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: TripMatesColors.text4,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _EarningsLink extends StatelessWidget {
  const _EarningsLink({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.card,
    required this.scheme,
    required this.route,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color card;
  final ColorScheme scheme;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: card,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Get.toNamed<void>(route),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: TripMatesColors.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: TripMatesColors.accent),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: TripMatesColors.text4,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: scheme.onSurface.withValues(alpha: 0.35)),
            ],
          ),
        ),
      ),
    );
  }
}
