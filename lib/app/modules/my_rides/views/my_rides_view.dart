import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/widgets/tripmates/tm_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_components.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/my_rides_controller.dart';

class MyRidesScreenContent extends StatelessWidget {
  const MyRidesScreenContent({super.key, this.isLoading = false});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bg = Theme.of(context).scaffoldBackgroundColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isLoading) {
      return Container(
        color: bg,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _MyRidesSkeleton(height: 44, color: scheme.surfaceContainerHighest),
            const SizedBox(height: 12),
            _MyRidesSkeleton(
              height: 140,
              color: scheme.surfaceContainerHighest,
            ),
            const SizedBox(height: 10),
            _MyRidesSkeleton(
              height: 140,
              color: scheme.surfaceContainerHighest,
            ),
          ],
        ),
      );
    }
    final heading = Theme.of(context).brightness == Brightness.dark
        ? scheme.onSurface
        : TripMatesColors.blue;
    return Container(
      color: bg,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'My rides',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w800,
              color: heading,
              fontSize: 36,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Driver · Passenger',
            style: GoogleFonts.nunito(
              color: scheme.onSurface.withValues(alpha: 0.45),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: TripMatesColors.green,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: TripMatesColors.blueDark,
                      width: 1.2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Driver',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: TripMatesColors.white,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InkWell(
                  onTap: () => Get.offAllNamed<void>(Routes.PASSENGER_MODE),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Text(
                      'Passenger',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface.withValues(alpha: 0.55),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? scheme.surfaceContainerHighest : scheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thu, Apr 9',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color: heading,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '16:26 · Ludvika → Gävle',
                        style: GoogleFonts.nunito(
                          color: scheme.onSurface.withValues(alpha: 0.72),
                        ),
                      ),
                    ),
                    Text(
                      '120 kr/seat',
                      style: GoogleFonts.nunito(
                        color: heading,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'Finished',
                    style: GoogleFonts.poppins(
                      color: TripMatesColors.green,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Archive trip'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'My auto searches',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              color: heading,
            ),
          ),
          const SizedBox(height: 10),
          TmCard(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Setup auto search 1\nStockholm → Göteborg · weekdays',
                    style: GoogleFonts.nunito(
                      color: scheme.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: scheme.onSurface.withValues(alpha: 0.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyRidesView extends GetView<MyRidesController> {
  const MyRidesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const TmMintAppBar(title: 'My rides', showBack: false),
            Expanded(
              child: Obx(
                () =>
                    MyRidesScreenContent(isLoading: controller.isLoading.value),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TmBottomNav(
        selectedIndex: 2,
        onTap: UserHomeNavigation.handleGlobalBottomTap,
      ),
    );
  }
}

class _MyRidesSkeleton extends StatelessWidget {
  const _MyRidesSkeleton({required this.height, required this.color});

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}
