import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            TmMintAppBar(title: 'Terms of Use', showBack: true),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Terms of Use',
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
                      title: '1. Acceptance of Terms',
                      content:
                          'By downloading, installing, and using TripMates, you agree to be bound by these Terms of Use. If you do not agree to these terms, please do not use the app.',
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      title: '2. Eligibility',
                      content:
                          'You must be at least 18 years old to use TripMates. By using the app, you confirm that you meet this age requirement.',
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      title: '3. User Accounts',
                      content:
                          'You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.',
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      title: '4. Safety and Conduct',
                      content:
                          'TripMates prioritizes safety. All users must comply with local traffic laws, treat others with respect, and follow our community guidelines.',
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      title: '5. Payments',
                      content:
                          'Drivers pay a 15 SEK fee per trip announcement. The app may also require a one-time purchase fee of 99 SEK. All payments are processed securely through our payment providers.',
                    ),
                    const SizedBox(height: 16),
                    _Section(
                      title: '6. Limitation of Liability',
                      content:
                          'TripMates is not responsible for any damages, losses, or injuries that occur while using the app. We provide a platform for connecting users, but do not control the actions of individual users.',
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
