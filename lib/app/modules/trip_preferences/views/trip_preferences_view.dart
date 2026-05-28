import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/feedback/global_success_feedback.dart';
import '../../../core/widgets/driver_aware_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_components.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../controllers/trip_preferences_controller.dart';

class TripPreferencesScreenContent extends StatelessWidget {
  const TripPreferencesScreenContent({super.key, this.showBack = false});

  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        TmMintAppBar(title: 'Trip preferences', showBack: showBack),
        Expanded(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: scheme.outline.withValues(alpha: 0.28)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _Step(label: 'ROUTE', icon: Icons.route_outlined, done: true),
                      _Step(label: 'DATE', icon: Icons.check, done: true),
                      _Step(label: 'PREFS', text: '3', active: true),
                      _Step(label: 'PUBLISH', text: '4'),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const TmRowToggle(label: 'Smoking', on: false),
                const TmRowToggle(label: 'Pets welcome', on: true),
                const TmRowToggle(label: 'Music OK', on: true),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Max detour',
                    hintText: '15 min',
                    filled: true,
                    fillColor: scheme.surface,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: 'Notes to passengers',
                    hintText: 'Luggage space, quiet ride...',
                    filled: true,
                    fillColor: scheme.surface,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 18),
                TmPrimaryButton(
                  label: 'Publish ride',
                  onPressed: () async {
                    await GlobalSuccessFeedback.presentRidePublished();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TripPreferencesView extends GetView<TripPreferencesController> {
  const TripPreferencesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(child: TripPreferencesScreenContent(showBack: true)),
      bottomNavigationBar: const DriverAwareBottomNav(highlightPublishInFlow: true),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({
    required this.label,
    this.icon,
    this.text,
    this.active = false,
    this.done = false,
  });

  final String label;
  final IconData? icon;
  final String? text;
  final bool active;
  final bool done;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = active
        ? TripMatesColors.green
        : done
            ? TripMatesColors.chipSuccess
            : (isDark ? scheme.surfaceContainerHighest : TripMatesColors.off);
    final fg = active
        ? TripMatesColors.white
        : (isDark ? scheme.onSurface.withValues(alpha: 0.78) : TripMatesColors.text3);

    return Column(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: bg,
          child: icon != null
              ? Icon(icon, size: 14, color: fg)
              : Text(
                  text ?? '',
                  style: TextStyle(
                    color: fg,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 10,
            color: scheme.onSurface.withValues(alpha: 0.55),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

