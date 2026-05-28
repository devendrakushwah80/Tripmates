import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../theme/passenger_shell_theme.dart';

class PassengerBottomNav extends StatelessWidget {
  const PassengerBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PassengerShellTheme.cardWhite,
      elevation: 0,
      shadowColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: PassengerShellTheme.cardWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
            child: Row(
              children: [
                _Item(i: 0, labelKey: 'passenger_nav.home', icon: PhosphorIconsRegular.house, selected: currentIndex == 0, onTap: onTap),
                _Item(i: 1, labelKey: 'passenger_nav.search', icon: PhosphorIconsRegular.magnifyingGlass, selected: currentIndex == 1, onTap: onTap),
                _Item(i: 2, labelKey: 'passenger_nav.rides', icon: PhosphorIconsRegular.car, selected: currentIndex == 2, onTap: onTap),
                _Item(i: 3, labelKey: 'passenger_nav.safety', icon: PhosphorIconsRegular.shieldCheck, selected: currentIndex == 3, onTap: onTap),
                _Item(i: 4, labelKey: 'passenger_nav.profile', icon: PhosphorIconsRegular.user, selected: currentIndex == 4, onTap: onTap),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.i,
    required this.labelKey,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final int i;
  final String labelKey;
  final IconData icon;
  final bool selected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? PassengerShellTheme.primaryGreen : PassengerShellTheme.textSecondary.withValues(alpha: 0.72);
    return Expanded(
      child: InkWell(
        onTap: () => onTap(i),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PhosphorIcon(icon, size: 22, color: color),
              const SizedBox(height: 4),
              Text(
                labelKey.tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const SizedBox(height: 5),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                height: 2.5,
                width: selected ? 22 : 0,
                decoration: BoxDecoration(
                  color: PassengerShellTheme.primaryGreen,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
