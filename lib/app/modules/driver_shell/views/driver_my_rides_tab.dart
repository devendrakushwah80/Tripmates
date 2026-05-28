import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/driver_shell_theme.dart';

class DriverMyRidesTab extends StatefulWidget {
  const DriverMyRidesTab({super.key});

  @override
  State<DriverMyRidesTab> createState() => _DriverMyRidesTabState();
}

class _DriverMyRidesTabState extends State<DriverMyRidesTab> {
  int _segment = 0;

  @override
  Widget build(BuildContext context) {
    final bg = DriverShellTheme.screenBg;

    return ColoredBox(
      color: bg,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 8),
              child: Text(
                'driver_hub.rides_title'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: DriverShellTheme.textPrimary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SegmentedButton<int>(
                segments: [
                  ButtonSegment(
                    value: 0,
                    label: Text('driver_hub.rides_upcoming'.tr),
                  ),
                  ButtonSegment(
                    value: 1,
                    label: Text('driver_hub.rides_completed'.tr),
                  ),
                ],
                selected: {_segment},
                onSelectionChanged: (s) => setState(() => _segment = s.first),
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  textStyle: WidgetStateProperty.all(
                    GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
                children: _segment == 0 ? _upcoming(context) : _completed(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _upcoming(BuildContext context) {
    return [
      _DateBadge(label: 'driver_hub.badge_today'.tr),
      _RideRow(
        when: '25 May · 06:00',
        route: 'Jaipur → Delhi',
        meta: '2 seats · ₹800',
        pax: 'driver_hub.pax_booked'.trParams({'n': '1'}),
      ),
      const SizedBox(height: 14),
      _DateBadge(label: 'driver_hub.badge_tomorrow'.tr),
      _RideRow(
        when: '26 May · 09:30',
        route: 'Delhi → Agra',
        meta: '3 seats · ₹1,200',
        pax: 'driver_hub.pax_booked'.trParams({'n': '2'}),
      ),
    ];
  }

  List<Widget> _completed(BuildContext context) {
    return [
      _DateBadge(label: 'driver_hub.badge_last_week'.tr),
      _RideRow(
        when: '04 May · 14:00',
        route: 'Stockholm → Göteborg',
        meta: '4 seats · ₹4,200',
        pax: 'driver_hub.status_done'.tr,
      ),
      _RideRow(
        when: '01 May · 08:15',
        route: 'Jaipur → Udaipur',
        meta: '2 seats · ₹650',
        pax: 'driver_hub.status_done'.tr,
      ),
    ];
  }
}

class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: DriverShellTheme.softGreenBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: GoogleFonts.lexend(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: DriverShellTheme.primaryGreen,
            ),
          ),
        ),
      ),
    );
  }
}

class _RideRow extends StatelessWidget {
  const _RideRow({
    required this.when,
    required this.route,
    required this.meta,
    required this.pax,
  });

  final String when;
  final String route;
  final String meta;
  final String pax;

  @override
  Widget build(BuildContext context) {
    final card = DriverShellTheme.cardWhite;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: card,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  when,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: DriverShellTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  route,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: DriverShellTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  meta,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: DriverShellTheme.primaryGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pax,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: DriverShellTheme.textSecondary,
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
