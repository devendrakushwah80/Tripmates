import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/widgets/live_trip_map.dart';
import '../../../core/widgets/tripmates/tm_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/live_trip_controller.dart';

class LiveTripScreenContent extends StatelessWidget {
  const LiveTripScreenContent({super.key, required this.controller, this.showBack = false});

  final LiveTripController controller;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleBlue = isDark ? scheme.onSurface : TripMatesColors.blue;
    return Column(
      children: [
        TmMintAppBar(title: 'Live trip', showBack: showBack),
        Expanded(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              padding: const EdgeInsets.all(14),
              children: [
                Row(
                  children: [
                    Text(
                      'Ludvika → Gävle',
                      style: GoogleFonts.nunito(color: scheme.onSurface.withValues(alpha: 0.55)),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: TripMatesColors.chipSuccess,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '~33 min',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          color: TripMatesColors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                LiveTripMap(driver: controller.driver, height: 236),
                const SizedBox(height: 12),
                Text(
                  'Live driver position updates before and during the trip (demo simulation).',
                  style: GoogleFonts.nunito(color: scheme.onSurface.withValues(alpha: 0.55)),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: scheme.outline.withValues(alpha: 0.28)),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: TripMatesColors.chipInfoBg,
                        child: Text('S'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Salome',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                color: titleBlue,
                              ),
                            ),
                            Text(
                              'Kia Ceed · 4.9 ★',
                              style: GoogleFonts.nunito(
                                color: scheme.onSurface.withValues(alpha: 0.55),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: titleBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed<void>(Routes.RATE_TRIP),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TripMatesColors.green,
                    ),
                    child: const Text('End trip & rate'),
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

class LiveTripView extends GetView<LiveTripController> {
  const LiveTripView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(child: LiveTripScreenContent(controller: controller, showBack: true)),
      bottomNavigationBar: TmBottomNav(
        selectedIndex: 2,
        onTap: (i) {
          if (i == 0) UserHomeNavigation.offAllToUserHome();
          if (i == 1) Get.offAllNamed<void>(Routes.SEARCH_RIDES);
          if (i == 3) Get.offAllNamed<void>(Routes.ACCOUNT);
        },
      ),
    );
  }
}
