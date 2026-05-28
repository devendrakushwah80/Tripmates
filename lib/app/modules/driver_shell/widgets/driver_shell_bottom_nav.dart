import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../theme/driver_shell_theme.dart';

/// Five destinations: Home, My rides, Publish (action), Earnings, Profile.
class DriverShellBottomNav extends StatelessWidget {
  const DriverShellBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Material(
        color: DriverShellTheme.cardWhite,
        elevation: 12,
        shadowColor: Colors.black.withValues(alpha: 0.06),
        child: Container(
          height: 64,
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
          decoration: BoxDecoration(
            color: DriverShellTheme.cardWhite,
            border: Border(
              top: BorderSide(
                color: DriverShellTheme.textSecondary.withValues(alpha: 0.12),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _Item(
                icon: PhosphorIconsRegular.house,
                label: 'driver_hub.nav_home'.tr,
                on: selectedIndex == 0,
                onTap: () => onTap(0),
              ),
              _Item(
                icon: PhosphorIconsRegular.calendarBlank,
                label: 'driver_hub.nav_rides'.tr,
                on: selectedIndex == 1,
                onTap: () => onTap(1),
              ),
              _PublishItem(onTap: () => onTap(2)),
              _Item(
                icon: PhosphorIconsRegular.wallet,
                label: 'driver_hub.nav_earnings'.tr,
                on: selectedIndex == 3,
                onTap: () => onTap(3),
              ),
              _Item(
                icon: PhosphorIconsRegular.user,
                label: 'driver_hub.nav_profile'.tr,
                on: selectedIndex == 4,
                onTap: () => onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.icon,
    required this.label,
    required this.on,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool on;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = on
        ? DriverShellTheme.primaryGreen
        : DriverShellTheme.textSecondary;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PhosphorIcon(icon, size: 22, color: c),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: c,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PublishItem extends StatelessWidget {
  const _PublishItem({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Center(
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  DriverShellTheme.primaryGreen,
                  DriverShellTheme.primaryGreenDark,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: DriverShellTheme.primaryGreen.withValues(alpha: 0.4),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}
