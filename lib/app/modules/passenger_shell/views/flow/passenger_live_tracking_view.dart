import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../controllers/passenger_flow_controller.dart';
import '../../theme/passenger_shell_theme.dart';
import '../../widgets/passenger_road_tracking_map.dart';

class PassengerLiveTrackingView extends StatelessWidget {
  const PassengerLiveTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PassengerFlowController>();
    return Scaffold(
      backgroundColor: PassengerShellTheme.screenBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TmMintAppBar(title: 'passenger_live.title'.tr, showBack: true, onBack: c.popFlowOrShell),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return PassengerRoadTrackingMap(
                              height: constraints.maxHeight,
                              animateDriver: true,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Obx(
                      () => Row(
                        children: [
                          Expanded(child: _StatTile(label: 'passenger_live.eta'.tr, value: c.etaLabel.value)),
                          const SizedBox(width: 10),
                          Expanded(child: _StatTile(label: 'passenger_live.progress'.tr, value: '62%')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: LinearProgressIndicator(
                        value: 0.58,
                        minHeight: 7,
                        backgroundColor: PassengerShellTheme.softGreenBg,
                        color: PassengerShellTheme.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Expanded(child: _MiniAction(icon: PhosphorIconsRegular.shareNetwork, label: 'passenger_live.share'.tr, onTap: c.dummyShareTrip)),
                  const SizedBox(width: 8),
                  Expanded(child: _MiniAction(icon: PhosphorIconsRegular.warningCircle, label: 'passenger_live.sos'.tr, onTap: c.goSafetySos)),
                  const SizedBox(width: 8),
                  Expanded(child: _MiniAction(icon: PhosphorIconsRegular.phone, label: 'passenger_live.call'.tr, onTap: c.dummyCallDriver)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
              child: OutlinedButton(
                onPressed: c.goTripCompleted,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 46),
                  side: BorderSide(color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.32)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text('passenger_live.end_demo'.tr, style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: PassengerShellTheme.primaryGreen)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PassengerShellTheme.cardWhite,
      borderRadius: BorderRadius.circular(14),
      elevation: 0,
      child: Ink(
        decoration: BoxDecoration(
          color: PassengerShellTheme.cardWhite,
          borderRadius: BorderRadius.circular(14),
          boxShadow: PassengerShellTheme.cardShadowSoft,
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: PassengerShellTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.lexend(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: PassengerShellTheme.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniAction extends StatelessWidget {
  const _MiniAction({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PassengerShellTheme.cardWhite,
      borderRadius: BorderRadius.circular(14),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          decoration: BoxDecoration(
            color: PassengerShellTheme.cardWhite,
            borderRadius: BorderRadius.circular(14),
            boxShadow: PassengerShellTheme.cardShadowSoft,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                PhosphorIcon(icon, color: PassengerShellTheme.primaryGreen.withValues(alpha: 0.88), size: 20),
                const SizedBox(height: 4),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: PassengerShellTheme.textPrimary,
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
