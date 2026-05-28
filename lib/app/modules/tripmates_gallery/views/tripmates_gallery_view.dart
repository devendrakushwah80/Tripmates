import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/tripmates/tm_phone_shell.dart';
import '../../account/views/account_view.dart';
import '../../chat_car_info/views/chat_car_info_view.dart';
import '../../countries/views/countries_view.dart';
import '../../date_time/views/date_time_view.dart';
import '../../home/views/home_view.dart';
import '../../make_new_ride/views/make_new_ride_view.dart';
import '../../my_garage/views/my_garage_view.dart';
import '../../my_rides/views/my_rides_view.dart';
import '../../origin_search/views/origin_search_view.dart';
import '../../passenger_mode/views/passenger_mode_view.dart';
import '../../rate_trip/views/rate_trip_view.dart';
import '../../ride_detail/views/ride_detail_view.dart';
import '../../search_rides/views/search_rides_view.dart';
import '../../settings/views/settings_view.dart';
import '../../trip_preferences/views/trip_preferences_view.dart';
import '../../live_trip/controllers/live_trip_controller.dart';
import '../../live_trip/views/live_trip_view.dart';
import '../../my_garage/controllers/my_garage_controller.dart';
import '../controllers/tripmates_gallery_controller.dart';

/// All 14 TripMates UI frames in one scroll (matches HTML gallery).
class TripmatesGalleryView extends GetView<TripmatesGalleryController> {
  const TripmatesGalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TripMatesColors.galleryBackdrop,
      appBar: AppBar(
        backgroundColor: TripMatesColors.blueDark,
        foregroundColor: TripMatesColors.white,
        title: const Text('TripMates â€” all screens'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                _label('1. Home'),
                TmPhoneFrame(selectedTab: 0, child: const HomeHubBody()),
                _label('2. Search Rides'),
                TmPhoneFrame(selectedTab: 1, child: SearchRidesScreenContent()),
                _label('3. Make a New Ride'),
                TmPhoneFrame(selectedTab: 0, child: MakeNewRideScreenContent()),
                _label('4. Date & Time'),
                TmPhoneFrame(selectedTab: 0, child: DateTimeScreenContent()),
                _label('5. My Rides'),
                TmPhoneFrame(
                  selectedTab: 2,
                  child: const MyRidesScreenContent(),
                ),
                _label('6. Ride Detail'),
                TmPhoneFrame(
                  selectedTab: 2,
                  child: const RideDetailScreenContent(),
                ),
                _label('7. Live Trip'),
                TmPhoneFrame(
                  selectedTab: 2,
                  child: GetBuilder<LiveTripController>(
                    init: LiveTripController(),
                    global: false,
                    autoRemove: true,
                    builder: (c) => LiveTripScreenContent(controller: c, showBack: false),
                  ),
                ),
                _label('8. Rate Trip'),
                TmPhoneFrame(
                  selectedTab: 2,
                  child: const RateTripScreenContent(),
                ),
                _label('9. Chat & Car Info'),
                TmPhoneFrame(
                  selectedTab: 2,
                  child: const ChatCarInfoScreenContent(),
                ),
                _label('10. Origin Search'),
                TmPhoneFrame(
                  selectedTab: 1,
                  child: const OriginSearchScreenContent(),
                ),
                _label('11. My Garage'),
                TmPhoneFrame(
                  selectedTab: 2,
                  child: GetBuilder<MyGarageController>(
                    init: MyGarageController(),
                    global: false,
                    autoRemove: true,
                    builder: (c) => MyGarageScreenContent(controller: c, showBack: false),
                  ),
                ),
                _label('12. Account'),
                TmPhoneFrame(
                  selectedTab: 3,
                  child: const AccountScreenContent(showBack: false),
                ),
                _label('13. Settings'),
                TmPhoneFrame(
                  selectedTab: 3,
                  child: const SettingsScreenContent(),
                ),
                _label('14. Countries'),
                TmPhoneFrame(
                  selectedTab: 3,
                  child: const CountriesScreenContent(),
                ),
                _label('15. Passenger Mode'),
                TmPhoneFrame(
                  selectedTab: 2,
                  child: const PassengerModeScreenContent(),
                ),
                _label('16. Trip Preferences'),
                TmPhoneFrame(
                  selectedTab: 0,
                  child: TripPreferencesScreenContent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
          color: const Color(0xFF3A5040),
        ),
      ),
    );
  }
}
