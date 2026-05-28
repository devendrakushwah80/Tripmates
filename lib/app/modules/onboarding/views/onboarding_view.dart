import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/tripmates/tm_components.dart';
import '../../../core/widgets/tripmates/tm_logo.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final canvas = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: canvas,
      appBar: AppBar(
        backgroundColor: canvas,
        elevation: 0,
        title: const TmLogo(size: 42),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              children: const [
                _OnboardPage(
                  title: 'Pedal & pool',
                  subtitle:
                      'Green routes and shared seats â€” cut emissions together.',
                  icon: Icons.pedal_bike,
                ),
                _OnboardPage(
                  title: 'Trust & safety',
                  subtitle: 'Verified drivers, clear pricing, in-app chat.',
                  icon: Icons.verified_user_outlined,
                ),
                _OnboardPage(
                  title: 'Ready to roll?',
                  subtitle:
                      'Sign in or create an account to book or publish rides.',
                  icon: Icons.directions_car_outlined,
                ),
              ],
            ),
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                OnboardingController.pageCount,
                (i) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: controller.currentPage.value == i ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: controller.currentPage.value == i
                        ? TripMatesColors.green
                        : TripMatesColors.divider,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            child: TmPrimaryButton(label: 'onboarding.next'.tr, onPressed: controller.next),
          ),
        ],
      ),
    );
  }
}

class _OnboardPage extends StatelessWidget {
  const _OnboardPage({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: TripMatesColors.mint,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 64, color: TripMatesColors.green),
          ),
          const SizedBox(height: 32),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: TripMatesColors.blue,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              fontSize: 15,
              height: 1.45,
              color: TripMatesColors.text3,
            ),
          ),
        ],
      ),
    );
  }
}

