import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/widgets/tripmates/tm_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const TmMintAppBar(title: 'Booking', showBack: true),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const CircleAvatar(
                      radius: 26,
                      backgroundColor: TripMatesColors.chipSuccess,
                      child: Icon(Icons.check_rounded, color: TripMatesColors.green, size: 28),
                    ),
                    const SizedBox(height: 16),
                    Text('You’re in', style: GoogleFonts.poppins(fontSize: 42, fontWeight: FontWeight.w800, color: TripMatesColors.blue)),
                    const SizedBox(height: 8),
                    Text('Salome · Torp → Moheda · 204 kr', style: GoogleFonts.nunito(color: TripMatesColors.text3)),
                    const SizedBox(height: 30),
                    SizedBox(height: 54, width: double.infinity, child: ElevatedButton(onPressed: controller.openLiveMap, child: const Text('View route on map'))),
                    const SizedBox(height: 12),
                    SizedBox(height: 54, width: double.infinity, child: OutlinedButton(onPressed: controller.openMyRides, child: const Text('View my rides'))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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

