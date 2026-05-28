import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/widgets/tripmates/tm_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/ride_results_controller.dart';

class RideResultsView extends GetView<RideResultsController> {
  const RideResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const TmMintAppBar(title: 'Ride results', showBack: true),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  Text(
                    'Friday, April 10',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onSurface
                          : TripMatesColors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _RideCard(
                    time: '7:30',
                    from: 'Torp',
                    to: 'Moheda',
                    price: '204 kr',
                    seats: '3 seats left',
                    onBook: controller.openBooking,
                  ),
                  const SizedBox(height: 12),
                  _RideCard(
                    time: '16:00',
                    from: 'Cityterminalen',
                    to: 'Nils Ericson',
                    price: '326 kr',
                    seats: '2 seats left',
                    onBook: controller.openBooking,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TmBottomNav(
        selectedIndex: 1,
        onTap: UserHomeNavigation.handleGlobalBottomTap,
      ),
    );
  }
}

class _RideCard extends StatelessWidget {
  const _RideCard({
    required this.time,
    required this.from,
    required this.to,
    required this.price,
    required this.seats,
    required this.onBook,
  });

  final String time;
  final String from;
  final String to;
  final String price;
  final String seats;
  final VoidCallback onBook;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? scheme.onSurface : TripMatesColors.blue;
    final cardBg = isDark ? scheme.surfaceContainerHighest : scheme.surface;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                time,
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: accent,
                ),
              ),
              const Spacer(),
              Text(
                price,
                style: GoogleFonts.poppins(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '$from → $to',
            style: GoogleFonts.nunito(
              color: scheme.onSurface.withValues(alpha: 0.72),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? TripMatesColors.green.withValues(alpha: 0.15)
                      : TripMatesColors.chipSuccess,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  seats,
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w700,
                    color: TripMatesColors.green,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 110,
                height: 42,
                child: ElevatedButton(
                  onPressed: onBook,
                  child: const Text('Book ride'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
