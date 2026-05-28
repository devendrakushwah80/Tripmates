import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';

class RulesView extends StatelessWidget {
  const RulesView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            TmMintAppBar(title: 'Community Rules', showBack: true),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Community Rules',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: isDark ? AppColors.darkTextPrimary : TripMatesColors.blue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Our rules ensure a safe and respectful community for everyone.',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        color: isDark ? AppColors.darkTextSecondary : TripMatesColors.text3,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _RuleItem(
                      number: '1',
                      title: 'Be Respectful',
                      content: 'Treat all community members with kindness and respect. Discrimination, harassment, or offensive behavior will not be tolerated.',
                    ),
                    const SizedBox(height: 16),
                    _RuleItem(
                      number: '2',
                      title: 'Safety First',
                      content: 'Always prioritize safety. Follow traffic laws, wear seatbelts, and never drive under the influence of alcohol or drugs.',
                    ),
                    const SizedBox(height: 16),
                    _RuleItem(
                      number: '3',
                      title: 'Be On Time',
                      content: 'Arrive at the agreed pickup location on time. Communicate promptly if you need to make changes.',
                    ),
                    const SizedBox(height: 16),
                    _RuleItem(
                      number: '4',
                      title: 'Vehicle Requirements',
                      content: 'All vehicles must be properly registered, insured, and in good working condition. Drivers must have a valid driver\'s license.',
                    ),
                    const SizedBox(height: 16),
                    _RuleItem(
                      number: '5',
                      title: 'Honesty and Transparency',
                      content: 'Provide accurate information about yourself and your vehicle. Misrepresentation may result in account suspension.',
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

class _RuleItem extends StatelessWidget {
  const _RuleItem({required this.number, required this.title, required this.content});

  final String number;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
            color: TripMatesColors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: TripMatesColors.white,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
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
          ),
        ),
      ],
    );
  }
}
