import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/widgets/tripmates/tm_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/ride_detail_controller.dart';

class RideDetailScreenContent extends StatelessWidget {
  const RideDetailScreenContent({super.key, this.showBack = false});

  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleBlue = isDark ? scheme.onSurface : TripMatesColors.blue;
    final cardBg = isDark
        ? scheme.surfaceContainerHighest
        : TripMatesColors.white;

    return Column(
      children: [
        TmMintAppBar(title: "Yassin's Ride", showBack: showBack),
        Expanded(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    _chip(
                      'Finished',
                      TripMatesColors.chipSuccess,
                      TripMatesColors.green,
                    ),
                    const SizedBox(width: 8),
                    _chip(
                      'Driver view',
                      isDark
                          ? scheme.surfaceContainerHighest
                          : TripMatesColors.sky,
                      isDark
                          ? scheme.onSurface.withValues(alpha: 0.88)
                          : TripMatesColors.accent,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: scheme.outline.withValues(alpha: 0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: isDark ? 0.2 : 0.05,
                        ),
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
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: titleBlue,
                        ),
                      ),
                      Text(
                        'Depart 16:26 · ~2h 10m',
                        style: GoogleFonts.nunito(
                          color: scheme.onSurface.withValues(alpha: 0.55),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Passed · Ludvika, Lykivägen 3\nGävle, Sweden',
                        style: GoogleFonts.nunito(
                          color: scheme.onSurface.withValues(alpha: 0.78),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _rowKV(context, 'Contribution', '120 kr / seat'),
                      _rowKV(context, 'Vehicle', 'Kia Sorento · 5 seats · AC'),
                      _rowKV(context, 'Passengers', '1 booked · 4 free'),
                      _rowKV(context, 'Your respect', '4.9 ★'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Archive trip'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => Get.toNamed<void>(Routes.LIVE_TRIP),
                    child: const Text('Open live map'),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: isDark
                        ? scheme.surfaceContainerHighest
                        : TripMatesColors.sky,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: scheme.outline.withValues(alpha: 0.2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Map',
                    style: GoogleFonts.nunito(
                      color: isDark
                          ? scheme.onSurface.withValues(alpha: 0.75)
                          : TripMatesColors.accent,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Passenger feedback',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color: titleBlue,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: scheme.outline.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    'Anna · 5 ★ · Apr 9\nSmooth drive, good music volume. Thanks!',
                    style: GoogleFonts.nunito(
                      color: scheme.onSurface.withValues(alpha: 0.78),
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Reviews appear here after riders submit them.',
                  style: GoogleFonts.nunito(
                    color: scheme.onSurface.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _chip(String label, Color bg, Color fg) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
  child: Text(
    label,
    style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 12),
  ),
);

Widget _rowKV(BuildContext context, String k, String v) {
  final scheme = Theme.of(context).colorScheme;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Text(
          k,
          style: GoogleFonts.nunito(
            color: scheme.onSurface.withValues(alpha: 0.55),
          ),
        ),
        const Spacer(),
        Text(
          v,
          style: GoogleFonts.nunito(
            color: scheme.onSurface.withValues(alpha: 0.78),
          ),
        ),
      ],
    ),
  );
}

class RideDetailView extends GetView<RideDetailController> {
  const RideDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(child: RideDetailScreenContent(showBack: true)),
      bottomNavigationBar: TmBottomNav(
        selectedIndex: 2,
        onTap: UserHomeNavigation.handleGlobalBottomTap,
      ),
    );
  }
}
