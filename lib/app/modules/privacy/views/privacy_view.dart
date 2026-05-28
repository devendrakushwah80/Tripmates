import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            TmMintAppBar(title: 'Privacy Policy', showBack: true),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Privacy Policy',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: isDark ? AppColors.darkTextPrimary : TripMatesColors.blue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Last updated: April 2026',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: isDark ? AppColors.darkTextSecondary : TripMatesColors.text3,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _Section(
                      title: '1. Information We Collect',
                      content:
                          'We collect personal information including your name, email, phone number, profile picture, and location data to provide and improve our services.',
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      title: '2. How We Use Your Information',
                      content:
                          'Your information is used to connect you with other users, process payments, ensure safety, and improve the app experience.',
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      title: '3. Data Sharing',
                      content:
                          'We do not sell your personal information. We may share data with trusted service providers for payment processing, identity verification, and analytics.',
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      title: '4. Data Security',
                      content:
                          'We implement industry-standard security measures to protect your data. However, no method of transmission over the internet is 100% secure.',
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      title: '5. Your Rights',
                      content:
                          'You have the right to access, update, or delete your personal information. Contact us at privacy@tripmates.com for assistance.',
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.darkTextPrimary : TripMatesColors.blue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: GoogleFonts.nunito(
            fontSize: 15,
            height: 1.5,
            color: isDark ? AppColors.darkTextSecondary : TripMatesColors.text3,
          ),
        ),
      ],
    );
  }
}
