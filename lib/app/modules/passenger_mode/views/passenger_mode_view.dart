import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/widgets/tripmates/tm_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_components.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/passenger_mode_controller.dart';

class PassengerModeScreenContent extends StatelessWidget {
  const PassengerModeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text('My rides', style: GoogleFonts.poppins(fontWeight: FontWeight.w800, color: TripMatesColors.blue, fontSize: 36)),
          const SizedBox(height: 4),
          Text('Driver · Passenger', style: GoogleFonts.nunito(color: TripMatesColors.text4)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: TripMatesColors.off, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Get.offAllNamed<void>(Routes.MY_RIDES),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      child: Text('Driver', style: GoogleFonts.poppins(color: TripMatesColors.text4, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: TripMatesColors.green, borderRadius: BorderRadius.circular(10), border: Border.all(color: TripMatesColors.blueDark, width: 1.2)),
                    child: Text('Passenger', style: GoogleFonts.poppins(color: TripMatesColors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(height: 48, child: ElevatedButton(onPressed: () => Get.toNamed<void>(Routes.SEARCH_RIDES), child: const Text('Search rides'))),
          const SizedBox(height: 14),
          Row(children: [Text('Upcoming', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: TripMatesColors.blue)), const Spacer(), _smallChip('Booked')]),
          const SizedBox(height: 8),
          TmCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Torp\nMoheda', style: GoogleFonts.nunito(color: TripMatesColors.text3)),
                const SizedBox(height: 6),
                Text('Fri · Apr 11 · departs 7:30', style: GoogleFonts.nunito(color: TripMatesColors.text4)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const CircleAvatar(radius: 13, backgroundColor: TripMatesColors.chipInfoBg, child: Text('S')),
                    const SizedBox(width: 8),
                    Expanded(child: Text('Salome\nVolvo V60 · 4.9 ★', style: GoogleFonts.nunito(color: TripMatesColors.text4))),
                    _smallChip('204 kr'),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: SizedBox(height: 42, child: ElevatedButton(onPressed: () => Get.toNamed<void>(Routes.LIVE_TRIP), child: const Text('Track trip')))),
                    const SizedBox(width: 10),
                    Expanded(child: SizedBox(height: 42, child: OutlinedButton(onPressed: () => Get.toNamed<void>(Routes.RIDE_DETAIL), child: const Text('Trip details')))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(children: [Text('Pending requests', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: TripMatesColors.blue)), const Spacer(), _smallChip('1')]),
          const SizedBox(height: 10),
          Row(children: [Text('Past', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: TripMatesColors.blue)), const Spacer(), Text('History', style: GoogleFonts.nunito(color: TripMatesColors.text4, fontWeight: FontWeight.w700))]),
          const SizedBox(height: 14),
          Text('My auto searches', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: TripMatesColors.blue)),
          const SizedBox(height: 10),
          TmCard(
            child: Row(
              children: [
                Expanded(child: Text('Setup auto search 1\nStockholm → Göteborg · weekdays', style: GoogleFonts.nunito(color: TripMatesColors.text4))),
                const Icon(Icons.chevron_right, color: TripMatesColors.text4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PassengerModeView extends GetView<PassengerModeController> {
  const PassengerModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const SafeArea(
        child: Column(
          children: [
            TmMintAppBar(title: 'My rides', showBack: false),
            Expanded(child: PassengerModeScreenContent()),
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

Widget _smallChip(String text) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(color: TripMatesColors.chipSuccess, borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: const TextStyle(fontSize: 11, color: TripMatesColors.green, fontWeight: FontWeight.w700)),
    );

