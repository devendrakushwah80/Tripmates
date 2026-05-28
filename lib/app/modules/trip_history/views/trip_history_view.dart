import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/widgets/tripmates/tm_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../../routes/app_pages.dart';

class TripHistoryView extends StatelessWidget {
  const TripHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headingColor = isDark ? scheme.onSurface : TripMatesColors.blue;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            TmMintAppBar(title: 'Trip history', showBack: true),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _HistoryCard(
                    badge: 'Completed',
                    badgeBg: TripMatesColors.chipSuccess,
                    title: 'Torp → Moheda',
                    subtitle: 'Fri, Apr 10 · with Salome',
                    receipt: 'Receipt #TM-2026-0410-01 · Swish',
                    amount: '204 kr',
                    headingColor: headingColor,
                  ),
                  const SizedBox(height: 12),
                  _HistoryCard(
                    badge: 'Archived',
                    badgeBg: isDark ? scheme.surfaceContainerHighest : TripMatesColors.off,
                    title: 'Ludvika → Gävle',
                    subtitle: 'Thu, Apr 9 · You drove',
                    receipt: 'Receipt #TM-2026-0409-14 · Payout to bank',
                    amount: '120 kr',
                    headingColor: headingColor,
                  ),
                  const SizedBox(height: 14),
                  SizedBox(height: 52, child: ElevatedButton(onPressed: () => Get.toNamed<void>(Routes.PAYMENT_HISTORY), child: const Text('Payment history & filters'))),
                  const SizedBox(height: 10),
                  SizedBox(height: 52, child: OutlinedButton(onPressed: () => Get.back<void>(), child: const Text('Back to account'))),
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

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.badge,
    required this.badgeBg,
    required this.title,
    required this.subtitle,
    required this.receipt,
    required this.amount,
    required this.headingColor,
  });

  final String badge;
  final Color badgeBg;
  final String title;
  final String subtitle;
  final String receipt;
  final String amount;
  final Color headingColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final body = scheme.onSurface.withValues(alpha: 0.82);
    final meta = scheme.onSurface.withValues(alpha: 0.55);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(8)),
                child: Text(badge, style: TextStyle(fontWeight: FontWeight.w700, color: TripMatesColors.green)),
              ),
              const Spacer(),
              Text(amount, style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w800, color: TripMatesColors.green)),
            ],
          ),
          const SizedBox(height: 8),
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: headingColor, fontSize: 28)),
          Text(subtitle, style: GoogleFonts.nunito(color: body)),
          const SizedBox(height: 4),
          Text(receipt, style: GoogleFonts.nunito(color: meta)),
        ],
      ),
    );
  }
}
