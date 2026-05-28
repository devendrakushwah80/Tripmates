import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/widgets/tripmates/tm_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/rate_trip_controller.dart';

class RateTripScreenContent extends GetView<RateTripController> {
  const RateTripScreenContent({super.key, this.showBack = false});

  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final heading = isDark ? scheme.onSurface : TripMatesColors.blue;
    return Column(
      children: [
        TmMintAppBar(title: 'Rate trip', showBack: showBack),
        Expanded(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              padding: const EdgeInsets.all(14),
              children: [
                Text('How was the ride?', style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w700, color: heading)),
                const SizedBox(height: 4),
                Text('Salome · Torp → Moheda', style: GoogleFonts.nunito(color: scheme.onSurface.withValues(alpha: 0.55))),
                const SizedBox(height: 12),
                Obx(
                  () => Row(
                    children: List.generate(5, (index) {
                      final on = index < controller.stars.value;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => controller.stars.value = index + 1,
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            height: 46,
                            decoration: BoxDecoration(
                              color: on
                                  ? const Color(0xFFFFF8E9)
                                  : (isDark ? scheme.surfaceContainerHighest : TripMatesColors.white),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFF2B548)),
                            ),
                            child: Icon(Icons.star, color: on ? const Color(0xFFF59E0B) : const Color(0xFFF2B548)),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 8),
                Text('Excellent — 5 stars', style: GoogleFonts.poppins(color: heading, fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Comment (optional)',
                    hintText: 'Smooth ride, on time...',
                    filled: true,
                    fillColor: scheme.surface,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: scheme.outline.withValues(alpha: 0.35))),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => Get.offAllNamed<void>(Routes.MY_RIDES),
                    style: ElevatedButton.styleFrom(backgroundColor: TripMatesColors.green),
                    child: const Text('Submit review'),
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

class RateTripView extends GetView<RateTripController> {
  const RateTripView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(child: RateTripScreenContent(showBack: true)),
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

