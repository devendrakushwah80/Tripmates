import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/widgets/tripmates/tm_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../../routes/app_pages.dart';

class PaymentHistoryView extends StatelessWidget {
  const PaymentHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? scheme.onSurface : TripMatesColors.blue;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            TmMintAppBar(title: 'Payment history', showBack: true),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  Row(
                    children: const [
                      _Tab('All', true),
                      SizedBox(width: 8),
                      _Tab('Rides', false),
                      SizedBox(width: 8),
                      _Tab('Refunds', false),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 180,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: scheme.outline.withValues(alpha: 0.22)),
                    ),
                    child: Text(
                      'Spend (last 6 weeks)',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: titleColor),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: scheme.outline.withValues(alpha: 0.22)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Transactions', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: titleColor)),
                        const SizedBox(height: 8),
                        _row(
                          context,
                          'Ride · Stockholm → Göteborg',
                          'Apr 10 · Swish',
                          '-204 kr',
                          TripMatesColors.blue,
                        ),
                        _row(
                          context,
                          'Ride · Torp → Moheda',
                          'Apr 8 · Card *4242',
                          '-189 kr',
                          TripMatesColors.blue,
                        ),
                        _row(
                          context,
                          'Refund · Cancelled booking',
                          'Apr 6 · Original Swish',
                          '+120 kr',
                          TripMatesColors.green,
                        ),
                        _row(
                          context,
                          'Driver payout · Ludvika → Gävle',
                          'Apr 5 · Bank transfer',
                          '+96 kr',
                          TripMatesColors.green,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TmBottomNav(
        selectedIndex: 3,
        onTap: (i) {
          if (i == 0) UserHomeNavigation.offAllToUserHome();
          if (i == 1) Get.offAllNamed<void>(Routes.SEARCH_RIDES);
          if (i == 2) Get.offAllNamed<void>(Routes.MY_RIDES);
        },
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab(this.text, this.on);
  final String text;
  final bool on;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: on ? TripMatesColors.green : scheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: scheme.outline.withValues(alpha: on ? 0 : 0.35)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: on ? TripMatesColors.white : scheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

Widget _row(
  BuildContext context,
  String title,
  String sub,
  String amount,
  Color amountColor,
) {
  final scheme = Theme.of(context).colorScheme;
  final bodyMuted = scheme.onSurface.withValues(alpha: 0.72);
  final subMuted = scheme.onSurface.withValues(alpha: 0.55);
  return Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.nunito(fontSize: 18, color: bodyMuted)),
              Text(sub, style: GoogleFonts.nunito(color: subMuted)),
            ],
          ),
        ),
        Text(amount, style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w800, color: amountColor)),
      ],
    ),
  );
}
