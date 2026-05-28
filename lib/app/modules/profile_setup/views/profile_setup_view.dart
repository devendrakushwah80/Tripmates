import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/widgets/tripmates/tm_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../../routes/app_pages.dart';
import '../../../services/local_storage_services/local_storage_services.dart';

class ProfileSetupView extends StatelessWidget {
  const ProfileSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            TmMintAppBar(title: 'Profile setup', showBack: true),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: TripMatesColors.blueDark,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Create your best profile on TripMates',
                          style: GoogleFonts.nunito(
                            color: TripMatesColors.white.withValues(alpha: 0.9),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            _Step('Account', true),
                            _Step('Profile', true),
                            _Step('Verify', false),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Your profile',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMain,
                      fontSize: 34,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Bio for travelers',
                      hintText: 'Eco commuter, quiet ride preferred...',
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Upload photo (demo)'),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: OutlinedButton(
                            onPressed: () => Get.back<void>(),
                            child: const Text('Back'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!LocalStorageService().getSelfieVerified()) {
                                Get.toNamed<void>(Routes.IDENTITY_VERIFY);
                              } else {
                                UserHomeNavigation.offAllToUserHome();
                              }
                            },
                            child: const Text('Continue'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TmBottomNav(
        selectedIndex: 3,
        onTap: UserHomeNavigation.handleGlobalBottomTap,
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step(this.text, this.done);
  final String text;
  final bool done;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 17,
          backgroundColor: done
              ? TripMatesColors.chipInfoBg
              : TripMatesColors.divider,
          child: done
              ? const Icon(Icons.check, color: TripMatesColors.green)
              : const Icon(Icons.circle_outlined, color: TripMatesColors.text4),
        ),
        const SizedBox(height: 4),
        Text(text, style: const TextStyle(color: TripMatesColors.white)),
      ],
    );
  }
}
