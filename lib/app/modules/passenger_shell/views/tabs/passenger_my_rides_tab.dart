import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../controllers/passenger_flow_controller.dart';
import '../../theme/passenger_shell_theme.dart';

class PassengerMyRidesTab extends StatelessWidget {
  const PassengerMyRidesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: ColoredBox(
        color: PassengerShellTheme.screenBg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                18,
                PassengerShellTheme.topContentPadding(context),
                18,
                0,
              ),
              child: Text(
                'passenger_rides.title'.tr,
                style: GoogleFonts.lexend(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: PassengerShellTheme.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Material(
                color: PassengerShellTheme.cardWhite,
                borderRadius: BorderRadius.circular(14),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: PassengerShellTheme.softGreenBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: PassengerShellTheme.primaryGreen,
                  unselectedLabelColor: PassengerShellTheme.textSecondary,
                  labelStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                  tabs: [
                    Tab(text: 'passenger_rides.upcoming'.tr),
                    Tab(text: 'passenger_rides.past'.tr),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TabBarView(
                children: [
                  _RideList(upcoming: true),
                  _RideList(upcoming: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RideList extends StatelessWidget {
  const _RideList({required this.upcoming});

  final bool upcoming;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PassengerFlowController>();
    if (upcoming) {
      return ListView(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
        children: [
          _RideCard(
            route: '${c.origin.value} → ${c.destination.value}',
            date: c.dateLabel,
            status: 'passenger_rides.status_upcoming'.tr,
            statusColor: const Color(0xFF2563EB),
            driver: c.driverName.value,
            onTap: () => c.goTripProgress(),
          ),
        ],
      );
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
      children: [
        _RideCard(
          route: 'Ludvika → Gävle',
          date: '8 Apr 2026',
          status: 'passenger_rides.status_done'.tr,
          statusColor: PassengerShellTheme.success,
          driver: 'Anna S.',
          onTap: () {},
        ),
        const SizedBox(height: 10),
        _RideCard(
          route: 'Torp → Moheda',
          date: '1 Mar 2026',
          status: 'passenger_rides.status_done'.tr,
          statusColor: PassengerShellTheme.success,
          driver: 'Yassin A.',
          onTap: () {},
        ),
      ],
    );
  }
}

class _RideCard extends StatelessWidget {
  const _RideCard({
    required this.route,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.driver,
    required this.onTap,
  });

  final String route;
  final String date;
  final String status;
  final Color statusColor;
  final String driver;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PassengerShellTheme.cardWhite,
      borderRadius: BorderRadius.circular(18),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            color: PassengerShellTheme.cardWhite,
            borderRadius: BorderRadius.circular(18),
            boxShadow: PassengerShellTheme.cardShadowSoft,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        status,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: statusColor,
                        ),
                      ),
                    ),
                    const Spacer(),
                    PhosphorIcon(
                      PhosphorIconsRegular.caretRight,
                      color: PassengerShellTheme.textSecondary,
                      size: 18,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  route,
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: PassengerShellTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: PassengerShellTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    PhosphorIcon(
                      PhosphorIconsRegular.user,
                      size: 18,
                      color: PassengerShellTheme.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      driver,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        color: PassengerShellTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
