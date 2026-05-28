import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../controllers/passenger_flow_controller.dart';
import '../../theme/passenger_shell_theme.dart';

class PassengerBookRideView extends GetView<PassengerFlowController> {
  const PassengerBookRideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PassengerShellTheme.screenBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TmMintAppBar(
              title: 'passenger_book.title'.tr,
              showBack: true,
              onBack: controller.popFlowOrShell,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 100),
                children: [
                  Obx(
                    () => _SummaryCard(
                      pickup: controller.origin.value,
                      drop: controller.destination.value,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'passenger_book.seats'.tr,
                    style: GoogleFonts.lexend(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: PassengerShellTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    final max = controller.seatsLeft.value;
                    return Wrap(
                      spacing: 8,
                      children: List.generate(max, (i) {
                        final n = i + 1;
                        final sel = controller.selectedSeats.value == n;
                        return ChoiceChip(
                          label: Text('$n'),
                          selected: sel,
                          onSelected: (_) => controller.setSeats(n),
                          selectedColor: PassengerShellTheme.primaryGreen
                              .withValues(alpha: 0.15),
                          labelStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w800,
                            color: sel
                                ? PassengerShellTheme.primaryGreen
                                : PassengerShellTheme.textPrimary,
                          ),
                          side: BorderSide(
                            color: sel
                                ? PassengerShellTheme.primaryGreen
                                : PassengerShellTheme.textSecondary.withValues(
                                    alpha: 0.25,
                                  ),
                          ),
                          backgroundColor: PassengerShellTheme.cardWhite,
                        );
                      }),
                    );
                  }),
                  const SizedBox(height: 22),
                  Text(
                    'passenger_book.summary'.tr,
                    style: GoogleFonts.lexend(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: PassengerShellTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    final per = controller.pricePerSeat.value;
                    final seats = controller.selectedSeats.value;
                    final total = per * seats;
                    return Material(
                      color: PassengerShellTheme.cardWhite,
                      borderRadius: BorderRadius.circular(16),
                      elevation: 0,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: PassengerShellTheme.cardWhite,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: PassengerShellTheme.cardShadowSoft,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _PriceRow(
                                'passenger_book.per_seat'.tr,
                                '$per SEK',
                              ),
                              _PriceRow('passenger_book.seats'.tr, '$seats'),
                              Divider(
                                height: 22,
                                color: PassengerShellTheme.textSecondary
                                    .withValues(alpha: 0.15),
                              ),
                              _PriceRow(
                                'passenger_book.total'.tr,
                                '$total SEK',
                                bold: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: PassengerShellTheme.primaryGreen.withValues(
                    alpha: 0.28,
                  ),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: FilledButton(
              onPressed: controller.confirmBooking,
              style: FilledButton.styleFrom(
                backgroundColor: PassengerShellTheme.primaryGreen,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                'passenger_book.confirm'.tr,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.pickup, required this.drop});

  final String pickup;
  final String drop;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PassengerShellTheme.cardWhite,
      borderRadius: BorderRadius.circular(16),
      elevation: 0,
      child: Ink(
        decoration: BoxDecoration(
          color: PassengerShellTheme.cardWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: PassengerShellTheme.cardShadowSoft,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  PhosphorIcon(
                    PhosphorIconsRegular.mapPinLine,
                    color: PassengerShellTheme.primaryGreen,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      pickup,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: PassengerShellTheme.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 4, bottom: 4),
                child: Container(
                  width: 2,
                  height: 18,
                  color: PassengerShellTheme.softGreenBg,
                ),
              ),
              Row(
                children: [
                  PhosphorIcon(
                    PhosphorIconsRegular.mapPin,
                    color: PassengerShellTheme.primaryGreen,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      drop,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: PassengerShellTheme.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow(this.label, this.value, {this.bold = false});

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
                color: PassengerShellTheme.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.w900,
              fontSize: bold ? 18 : 15,
              color: bold
                  ? PassengerShellTheme.primaryGreen
                  : PassengerShellTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
