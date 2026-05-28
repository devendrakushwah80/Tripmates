import 'package:get/get.dart';

import '../modules/account/bindings/account_binding.dart';
import '../modules/account/views/account_view.dart';
import '../modules/auth_screens/views/forgot_password_view.dart';
import '../modules/auth_screens/views/onboard_1_view.dart';
import '../modules/auth_screens/views/onboard_2_view.dart';
import '../modules/auth_screens/views/onboard_3_view.dart';
import '../modules/auth_screens/views/welcome_view.dart';
import '../modules/booking/bindings/booking_binding.dart';
import '../modules/booking/views/booking_view.dart';
import '../modules/chat_car_info/bindings/chat_car_info_binding.dart';
import '../modules/chat_car_info/views/chat_car_info_view.dart';
import '../modules/countries/bindings/countries_binding.dart';
import '../modules/countries/views/countries_view.dart';
import '../modules/date_time/bindings/date_time_binding.dart';
import '../modules/date_time/views/date_time_view.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/publish_ride/bindings/publish_ride_binding.dart';
import '../modules/publish_ride/views/publish_ride_view.dart';
import '../modules/my_garage/bindings/my_garage_binding.dart';
import '../modules/my_garage/views/my_garage_view.dart';
import '../modules/my_rides/bindings/my_rides_binding.dart';
import '../modules/my_rides/views/my_rides_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/origin_search/bindings/origin_search_binding.dart';
import '../modules/origin_search/views/origin_search_view.dart';
import '../modules/passenger_mode/bindings/passenger_mode_binding.dart';
import '../modules/passenger_mode/views/passenger_mode_view.dart';
import '../modules/passenger_shell/bindings/passenger_shell_binding.dart';
import '../modules/passenger_shell/theme/passenger_light_theme_scope.dart';
import '../modules/passenger_shell/views/flow/passenger_book_ride_view.dart';
import '../modules/passenger_shell/views/flow/passenger_booking_confirmed_view.dart';
import '../modules/passenger_shell/views/flow/passenger_live_tracking_view.dart';
import '../modules/passenger_shell/views/flow/passenger_personal_support_views.dart';
import '../modules/passenger_shell/views/flow/passenger_review_driver_view.dart';
import '../modules/passenger_shell/views/flow/passenger_ride_detail_view.dart';
import '../modules/passenger_shell/views/flow/passenger_ride_results_view.dart';
import '../modules/passenger_shell/views/flow/passenger_safety_views.dart';
import '../modules/passenger_shell/views/flow/passenger_trip_completed_view.dart';
import '../modules/passenger_shell/views/flow/passenger_trip_progress_view.dart';
import '../modules/passenger_shell/views/passenger_shell_view.dart';
import '../modules/payment_history/views/payment_history_view.dart';
import '../modules/profile_setup/views/profile_setup_view.dart';
import '../modules/rate_trip/bindings/rate_trip_binding.dart';
import '../modules/rate_trip/views/rate_trip_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/ride_results/bindings/ride_results_binding.dart';
import '../modules/ride_results/views/ride_results_view.dart';
import '../modules/ride_detail/bindings/ride_detail_binding.dart';
import '../modules/ride_detail/views/ride_detail_view.dart';
import '../modules/live_trip/bindings/live_trip_binding.dart';
import '../modules/live_trip/views/live_trip_view.dart';
import '../modules/otp_verify/bindings/otp_verify_binding.dart';
import '../modules/otp_verify/views/otp_verify_view.dart';
import '../modules/signup_flow/bindings/signup_flow_bindings.dart';
import '../modules/signup_flow/views/email_verify_view.dart';
import '../modules/signup_flow/views/profile_photo_signup_view.dart';
import '../modules/signup_flow/views/role_selection_view.dart';
import '../modules/signup_flow/views/selfie_signup_view.dart';
import '../modules/signup_flow/views/verification_complete_view.dart';
import '../modules/driver_onboarding/bindings/driver_onboarding_binding.dart';
import '../modules/driver_onboarding/views/driver_approved_view.dart';
import '../modules/driver_onboarding/views/driver_license_view.dart';
import '../modules/driver_onboarding/views/driver_rc_view.dart';
import '../modules/driver_onboarding/views/driver_review_view.dart';
import '../modules/driver_onboarding/views/driver_under_review_view.dart';
import '../modules/driver_onboarding/views/driver_vehicle_view.dart';
import '../modules/driver_shell/bindings/driver_shell_binding.dart';
import '../modules/driver_shell/views/driver_shell_view.dart';
import '../modules/search_rides/bindings/search_rides_binding.dart';
import '../modules/search_rides/views/search_rides_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/trip_preferences/bindings/trip_preferences_binding.dart';
import '../modules/trip_preferences/views/trip_preferences_view.dart';
import '../modules/trip_history/views/trip_history_view.dart';
import '../modules/tripmates_gallery/bindings/tripmates_gallery_binding.dart';
import '../modules/tripmates_gallery/views/tripmates_gallery_view.dart';
import '../modules/terms/views/terms_view.dart';
import '../modules/privacy/views/privacy_view.dart';
import '../modules/rules/views/rules_view.dart';
import '../modules/bank_details/bindings/bank_details_binding.dart';
import '../modules/bank_details/views/bank_details_view.dart';
import '../modules/driver_identity/bindings/driver_identity_binding.dart';
import '../modules/driver_identity/views/driver_identity_details_view.dart';
import '../modules/identity_verify/views/identity_verify_view.dart';
import '../modules/payments_wallet/views/payments_wallet_view.dart';
import '../modules/driver_shell/views/driver_earnings_detail_pages.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // Start in normal app flow (single screen at a time).
  static const INITIAL = Routes.SPLASH;

  static final routes = <GetPage<dynamic>>[
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(name: _Paths.ONBOARD_1, page: () => const Onboard1View()),
    GetPage(name: _Paths.ONBOARD_2, page: () => const Onboard2View()),
    GetPage(name: _Paths.ONBOARD_3, page: () => const Onboard3View()),
    GetPage(name: _Paths.WELCOME, page: () => const WelcomeView()),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.OTP_VERIFY,
      page: () => const OtpVerifyView(),
      binding: OtpVerifyBinding(),
    ),
    GetPage(
      name: _Paths.EMAIL_VERIFY,
      page: () => const EmailVerifyView(),
      binding: EmailVerifyBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PHOTO_SIGNUP,
      page: () => const ProfilePhotoSignupView(),
      binding: ProfilePhotoSignupBinding(),
    ),
    GetPage(
      name: _Paths.SELFIE_VERIFY_SIGNUP,
      page: () => const SelfieSignupView(),
      binding: SelfieSignupBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATION_COMPLETE,
      page: () => const VerificationCompleteView(),
      binding: VerificationCompleteBinding(),
    ),
    GetPage(
      name: _Paths.ROLE_SELECTION,
      page: () => const RoleSelectionView(),
      binding: RoleSelectionBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_LICENSE,
      page: () => const DriverLicenseView(),
      binding: DriverOnboardingBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_RC,
      page: () => const DriverRcView(),
      binding: DriverOnboardingBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_VEHICLE,
      page: () => const DriverVehicleView(),
      binding: DriverOnboardingBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_REVIEW,
      page: () => const DriverReviewView(),
      binding: DriverOnboardingBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_UNDER_REVIEW,
      page: () => const DriverUnderReviewView(),
      binding: DriverOnboardingBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_APPROVED,
      page: () => const DriverApprovedView(),
      binding: DriverOnboardingBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_HOME,
      page: () => const DriverShellView(),
      binding: DriverShellBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_RIDES,
      page: () => const SearchRidesView(),
      binding: SearchRidesBinding(),
    ),
    GetPage(
      name: _Paths.RIDE_RESULTS,
      page: () => const RideResultsView(),
      binding: RideResultsBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING,
      page: () => const BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.MAKE_NEW_RIDE,
      page: () => const PublishRideView(),
      binding: PublishRideBinding(),
    ),
    GetPage(
      name: _Paths.DATE_TIME,
      page: () => const DateTimeView(),
      binding: DateTimeBinding(),
    ),
    GetPage(
      name: _Paths.MY_RIDES,
      page: () => const MyRidesView(),
      binding: MyRidesBinding(),
    ),
    GetPage(
      name: _Paths.RIDE_DETAIL,
      page: () => const RideDetailView(),
      binding: RideDetailBinding(),
    ),
    GetPage(
      name: _Paths.LIVE_TRIP,
      page: () => const LiveTripView(),
      binding: LiveTripBinding(),
    ),
    GetPage(
      name: _Paths.RATE_TRIP,
      page: () => const RateTripView(),
      binding: RateTripBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_CAR_INFO,
      page: () => const ChatCarInfoView(),
      binding: ChatCarInfoBinding(),
    ),
    GetPage(
      name: _Paths.ORIGIN_SEARCH,
      page: () => const OriginSearchView(),
      binding: OriginSearchBinding(),
    ),
    GetPage(
      name: _Paths.MY_GARAGE,
      page: () => const MyGarageView(),
      binding: MyGarageBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => const AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.COUNTRIES,
      page: () => const CountriesView(),
      binding: CountriesBinding(),
    ),
    GetPage(name: _Paths.EDIT_PROFILE, page: () => const EditProfileView()),
    GetPage(name: _Paths.TRIP_HISTORY, page: () => const TripHistoryView()),
    GetPage(
      name: _Paths.PAYMENT_HISTORY,
      page: () => const PaymentHistoryView(),
    ),
    GetPage(name: _Paths.PROFILE_SETUP, page: () => const ProfileSetupView()),
    GetPage(
      name: _Paths.PASSENGER_MODE,
      page: () => const PassengerModeView(),
      binding: PassengerModeBinding(),
    ),
    GetPage(
      name: _Paths.TRIP_PREFERENCES,
      page: () => const TripPreferencesView(),
      binding: TripPreferencesBinding(),
    ),
    GetPage(
      name: _Paths.TRIPMATES_GALLERY,
      page: () => const TripmatesGalleryView(),
      binding: TripmatesGalleryBinding(),
    ),
    GetPage(name: _Paths.TERMS, page: () => const TermsView()),
    GetPage(name: _Paths.PRIVACY, page: () => const PrivacyView()),
    GetPage(name: _Paths.RULES, page: () => const RulesView()),
    GetPage(name: _Paths.IDENTITY_VERIFY, page: () => const IdentityVerifyView()),
    GetPage(name: _Paths.PAYMENTS_WALLET, page: () => const PaymentsWalletView()),
    GetPage(
      name: _Paths.DRIVER_IDENTITY_DETAILS,
      page: () => const DriverIdentityDetailsView(),
      binding: DriverIdentityBinding(),
    ),
    GetPage(
      name: _Paths.BANK_DETAILS,
      page: () => const BankDetailsView(),
      binding: BankDetailsBinding(),
    ),
    GetPage(name: _Paths.DRIVER_WALLET, page: () => const DriverWalletView()),
    GetPage(name: _Paths.DRIVER_PAYOUT_HISTORY, page: () => const DriverPayoutHistoryView()),
    GetPage(name: _Paths.DRIVER_EARNINGS_SUMMARY, page: () => const DriverEarningsSummaryView()),

    GetPage(
      name: _Paths.PASSENGER_SHELL,
      page: () => const PassengerLightThemeScope(child: PassengerShellView()),
      binding: PassengerShellBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_RIDE_RESULTS,
      page: () => const PassengerLightThemeScope(child: PassengerRideResultsView()),
      binding: PassengerFlowBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_RIDE_DETAIL,
      page: () => const PassengerLightThemeScope(child: PassengerRideDetailView()),
      binding: PassengerFlowBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_BOOK_RIDE,
      page: () => const PassengerLightThemeScope(child: PassengerBookRideView()),
      binding: PassengerFlowBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_BOOKING_CONFIRMED,
      page: () => const PassengerLightThemeScope(child: PassengerBookingConfirmedView()),
      binding: PassengerFlowBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_TRIP_PROGRESS,
      page: () => const PassengerLightThemeScope(child: PassengerTripProgressView()),
      binding: PassengerFlowBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_SAFETY_SHARE,
      page: () => const PassengerLightThemeScope(child: PassengerSafetyShareView()),
      binding: PassengerFlowBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_SAFETY_EMERGENCY,
      page: () => const PassengerLightThemeScope(child: PassengerSafetyEmergencyView()),
      binding: PassengerFlowBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_SAFETY_SOS,
      page: () => const PassengerLightThemeScope(child: PassengerSafetySosView()),
      binding: PassengerFlowBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_LIVE_TRACKING,
      page: () => const PassengerLightThemeScope(child: PassengerLiveTrackingView()),
      binding: PassengerFlowBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_TRIP_COMPLETED,
      page: () => const PassengerLightThemeScope(child: PassengerTripCompletedView()),
      binding: PassengerFlowBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_REVIEW_DRIVER,
      page: () => const PassengerLightThemeScope(child: PassengerReviewDriverView()),
      binding: PassengerFlowBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_PERSONAL_DETAILS,
      page: () => const PassengerLightThemeScope(child: PassengerPersonalDetailsView()),
      binding: PassengerFlowBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_SUPPORT,
      page: () => const PassengerLightThemeScope(child: PassengerSupportView()),
      binding: PassengerFlowBinding(),
    ),
  ];
}
