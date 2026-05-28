import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tm_bottom_nav.dart';
import 'tm_status_bar.dart';

/// Gallery label + phone frame â€” HTML `.wrap` + `.phone`.
class TmGalleryPhone extends StatelessWidget {
  const TmGalleryPhone({
    super.key,
    required this.label,
    required this.child,
    this.selectedTab = 0,
  });

  final String label;
  final Widget child;
  final int selectedTab;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: const Color(0xFF3A5040),
            ),
          ),
          const SizedBox(height: 10),
          TmPhoneFrame(selectedTab: selectedTab, child: child),
        ],
      ),
    );
  }
}

class TmPhoneFrame extends StatelessWidget {
  const TmPhoneFrame({super.key, required this.child, this.selectedTab = 0});

  final Widget child;
  final int selectedTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 812,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(44),
        border: Border.all(color: const Color(0xFF2A2A2E), width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 80,
            offset: const Offset(0, 36),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            children: [
              const TmStatusBar(),
              Expanded(child: child),
              TmBottomNav(selectedIndex: selectedTab),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 110,
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFF1A1A1E),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
