import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/driver_aware_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/date_time_controller.dart';

class DateTimeScreenContent extends StatelessWidget {
  const DateTimeScreenContent({super.key, this.showBack = false, this.showNav = false});

  final bool showBack;
  final bool showNav;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleBlue = isDark ? scheme.onSurface : TripMatesColors.blue;
    return Column(
      children: [
        TmMintAppBar(title: 'Date & time', showBack: showBack),
        Expanded(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.all(14),
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
                      _Step(label: 'ROUTE', index: '1', done: true),
                      _Step(label: 'DATE', index: '2', active: true),
                      _Step(label: 'PREFS', index: '3'),
                      _Step(label: 'PUBLISH', index: '4'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Spacer(),
                    Text('Time: 17:15 · Edit', style: GoogleFonts.nunito(color: scheme.onSurface.withValues(alpha: 0.55))),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: scheme.outline.withValues(alpha: 0.28)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _CalArrow(s: '‹'),
                          const Spacer(),
                          Text('April 2026', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: titleBlue)),
                          const Spacer(),
                          _CalArrow(s: '›'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          _Week('Mon'), _Week('Tue'), _Week('Wed'), _Week('Thu'), _Week('Fri'), _Week('Sat'), _Week('Sun', red: true),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          _Day('6'), _Day('7'), _Day('8'), _Day('9', active: true), _Day('10'), _Day('11'), _Day('12'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Text('Return trips & multiple dates', style: GoogleFonts.nunito(color: scheme.onSurface.withValues(alpha: 0.78))),
                    const Spacer(),
                    Switch(value: false, onChanged: (_) {}),
                  ],
                ),
                const SizedBox(height: 6),
                const Divider(height: 1),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const _Pill('Back'),
                    const SizedBox(width: 8),
                    const _Pill('Flex'),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed<void>(Routes.TRIP_PREFERENCES),
                    child: const Text('Trip preferences →'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DateTimeView extends GetView<DateTimeController> {
  const DateTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const SafeArea(child: DateTimeScreenContent(showBack: true, showNav: false)),
      bottomNavigationBar: const DriverAwareBottomNav(highlightPublishInFlow: true),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.label, required this.index, this.active = false, this.done = false});
  final String label;
  final String index;
  final bool active;
  final bool done;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inactiveBg = isDark ? scheme.surfaceContainerHighest : TripMatesColors.off;
    final inactiveFg = isDark ? scheme.onSurface.withValues(alpha: 0.78) : TripMatesColors.text3;
    return Column(
      children: [
        CircleAvatar(
          radius: 13,
          backgroundColor: done ? TripMatesColors.chipSuccess : (active ? TripMatesColors.green : inactiveBg),
          child: Text(
            done ? '✓' : index,
            style: TextStyle(color: active ? TripMatesColors.white : inactiveFg, fontWeight: FontWeight.w700, fontSize: 12),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: scheme.onSurface.withValues(alpha: 0.55)),
        ),
      ],
    );
  }
}

class _CalArrow extends StatelessWidget {
  const _CalArrow({required this.s});
  final String s;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark ? scheme.surfaceContainerHighest : TripMatesColors.off,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(s, style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.8))),
    );
  }
}

class _Week extends StatelessWidget {
  const _Week(this.label, {this.red = false});
  final String label;
  final bool red;
  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.55);
    return Text(label, style: TextStyle(fontSize: 11, color: red ? Colors.redAccent : muted));
  }
}

class _Day extends StatelessWidget {
  const _Day(this.day, {this.active = false});
  final String day;
  final bool active;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = active ? TripMatesColors.white : (isDark ? scheme.onSurface.withValues(alpha: 0.82) : TripMatesColors.text3);
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? TripMatesColors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(day, style: TextStyle(color: fg)),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? scheme.surfaceContainerHighest : TripMatesColors.sky,
        borderRadius: BorderRadius.circular(8),
        border: isDark ? Border.all(color: scheme.outline.withValues(alpha: 0.28)) : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isDark ? scheme.onSurface.withValues(alpha: 0.88) : TripMatesColors.accent,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

