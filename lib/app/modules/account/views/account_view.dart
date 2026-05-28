import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/widgets/tripmates/tm_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_components.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/account_controller.dart';

class AccountScreenContent extends StatelessWidget {
  const AccountScreenContent({
    super.key,
    this.showBack = false,
    this.controller,
  });

  final bool showBack;
  final AccountController? controller;

  @override
  Widget build(BuildContext context) {
    final c = controller;
    return Column(
      children: [
        TmMintAppBar(title: 'Account', showBack: showBack),
        Expanded(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [TripMatesColors.blueDark, TripMatesColors.blue],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundColor: TripMatesColors.white,
                        child: Text('YA'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Yassin Albawani',
                              style: GoogleFonts.poppins(
                                color: TripMatesColors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Växjö · Respect 4.9 · 67 rides',
                              style: GoogleFonts.nunito(
                                color: TripMatesColors.white.withValues(
                                  alpha: 0.85,
                                ),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _section('Trip management'),
                TmTile(
                  icon: Icons.history,
                  title: 'Trip history',
                  onTap: c?.openTripHistory,
                ),
                TmTile(
                  icon: Icons.directions_car,
                  title: 'My garage',
                  onTap: () => Get.toNamed<void>(Routes.MY_GARAGE),
                ),
                TmTile(
                  icon: Icons.account_tree_outlined,
                  title: 'Profile setup',
                  onTap: c?.openProfileSetup,
                ),
                const SizedBox(height: 10),
                _section('Settings & preferences'),
                TmTile(
                  icon: Icons.person_outline,
                  title: 'Edit profile',
                  onTap: c?.openEditProfile,
                ),
                TmTile(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Payments & pricing',
                  onTap: c?.openPaymentsWallet,
                ),
                TmTile(
                  icon: Icons.payment_outlined,
                  title: 'Payment history',
                  onTap: c?.openPaymentHistory,
                ),
                TmTile(
                  icon: Icons.public,
                  title: 'Countries',
                  onTap: c?.openCountries,
                ),
                TmTile(
                  icon: Icons.settings_outlined,
                  title: 'settings.title'.tr,
                  onTap: c?.openSettings,
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Logout'),
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

class AccountView extends GetView<AccountController> {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: AccountScreenContent(showBack: true, controller: controller),
      ),
      bottomNavigationBar: TmBottomNav(
        selectedIndex: 4,
        onTap: UserHomeNavigation.handleGlobalBottomTap,
      ),
    );
  }
}

Widget _section(String text) => Padding(
  padding: const EdgeInsets.only(left: 4, bottom: 6, top: 4),
  child: Text(
    text,
    style: GoogleFonts.poppins(
      color: TripMatesColors.blue,
      fontWeight: FontWeight.w700,
    ),
  ),
);
