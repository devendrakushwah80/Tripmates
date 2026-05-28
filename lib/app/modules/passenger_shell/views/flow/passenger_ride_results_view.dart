import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../controllers/passenger_flow_controller.dart';
import '../../theme/passenger_shell_theme.dart';
import '../../widgets/passenger_shell_assets.dart';

/// Ride search results — compact cards (no wide hero strip; avoids overflow).
class PassengerRideResultsView extends GetView<PassengerFlowController> {
  const PassengerRideResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PassengerShellTheme.screenBg,
      body: SafeArea(
        child: Column(
          children: [
            TmMintAppBar(title: 'passenger_results.title'.tr, showBack: true, onBack: controller.popFlowOrShell),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  Obx(
                    () => Text(
                      controller.dateLabel,
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: PassengerShellTheme.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Obx(
                    () => _ResultCard(
                      driverPhoto: PassengerShellAssets.driverPortrait,
                      name: controller.driverName.value,
                      rating: controller.driverRating.value,
                      vehicle: controller.vehicleName.value,
                      time: controller.departureTime.value,
                      seats: controller.seatsLeft.value,
                      price: controller.pricePerSeat.value,
                      onBook: controller.goRideDetail,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ResultCard(
                    driverPhoto: PassengerShellAssets.driverPortrait,
                    name: 'Priya Sharma',
                    rating: 4.9,
                    vehicle: 'Honda City',
                    time: '08:15 AM',
                    seats: 2,
                    price: 175,
                    onBook: controller.goRideDetail,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.driverPhoto,
    required this.name,
    required this.rating,
    required this.vehicle,
    required this.time,
    required this.seats,
    required this.price,
    required this.onBook,
  });

  final String driverPhoto;
  final String name;
  final double rating;
  final String vehicle;
  final String time;
  final int seats;
  final int price;
  final VoidCallback onBook;

  @override
  Widget build(BuildContext context) {
    final seatsLabel = 'passenger_results.seats'.trParams({'n': seats.toString()});
    return Material(
      color: PassengerShellTheme.cardWhite,
      borderRadius: BorderRadius.circular(20),
      elevation: 0,
      child: InkWell(
        onTap: onBook,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            color: PassengerShellTheme.cardWhite,
            borderRadius: BorderRadius.circular(20),
            boxShadow: PassengerShellTheme.cardShadowSoft,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(driverPhoto),
                  backgroundColor: PassengerShellTheme.softGreenBg,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: PassengerShellTheme.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Image.asset(
                            PassengerShellAssets.ratingIcon,
                            width: 16,
                            height: 16,
                            errorBuilder: (context, error, _) => Icon(Icons.favorite_border_rounded, size: 15, color: PassengerShellTheme.primaryGreen),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '$rating',
                            style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        vehicle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: PassengerShellTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.schedule_rounded, size: 15, color: PassengerShellTheme.textSecondary.withValues(alpha: 0.85)),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              time,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 12),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.event_seat_outlined, size: 15, color: PassengerShellTheme.textSecondary.withValues(alpha: 0.85)),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              seatsLabel,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$price SEK',
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: PassengerShellTheme.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
