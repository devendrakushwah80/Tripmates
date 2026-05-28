import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/navigation/user_home_navigation.dart';
import '../../../core/widgets/tripmates/tm_bottom_nav.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/search_rides_controller.dart';

/// HTML screen 2 â€” also used inside [TripmatesGalleryView].
class SearchRidesScreenContent extends StatelessWidget {
  const SearchRidesScreenContent({
    super.key,
    this.showBack = false,
    this.controller,
  });

  final bool showBack;
  final SearchRidesController? controller;

  @override
  Widget build(BuildContext context) {
    final SearchRidesController c = controller ?? Get.put(SearchRidesController());
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headingBlue = isDark ? scheme.onSurface : TripMatesColors.blue;
    final muted = isDark ? scheme.onSurface.withValues(alpha: 0.65) : TripMatesColors.text4;
    return Column(
      children: [
        TmMintAppBar(title: 'screen.search_rides'.tr, showBack: showBack),
        Expanded(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: scheme.outline.withValues(alpha: 0.22)),
                  ),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TRIP ROUTE',
                          style: TextStyle(
                            color: isDark ? muted.withValues(alpha: 0.85) : TripMatesColors.text4.withValues(alpha: 0.8),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.radio_button_checked,
                              size: 14,
                              color: Color(0xFF3B82F6),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'FROM',
                              style: TextStyle(
                                color: muted,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          c.origin.value,
                          style: TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.w800,
                            color: headingBlue,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.radio_button_checked,
                              size: 14,
                              color: TripMatesColors.green,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'TO',
                              style: TextStyle(
                                color: muted,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          c.destination.value,
                          style: TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.w800,
                            color: headingBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text('Origin'),
                const SizedBox(height: 6),
                Obx(
                  () => TextField(
                    controller: TextEditingController(
                      text: c.origin.value,
                    ),
                    onChanged: (v) => c.origin.value = v,
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Destination'),
                const SizedBox(height: 6),
                Obx(
                  () => TextField(
                    controller: TextEditingController(
                      text: c.destination.value,
                    ),
                    onChanged: (v) => c.destination.value = v,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 54,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: c.swapRoute,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Icon(Icons.swap_vert),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: c.openResults,
                          child: const Text('Search'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 96,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: c.openResults,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TripMatesColors.greenDark,
                        ),
                        child: const Icon(Icons.tune),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? scheme.secondaryContainer.withValues(alpha: 0.45) : const Color(0xFFF0F8FF),
                    border: Border.all(
                      color: isDark ? scheme.outline.withValues(alpha: 0.45) : const Color(0xFFBFDBFE),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Include auto searches',
                            style: TextStyle(color: isDark ? scheme.onSecondaryContainer : TripMatesColors.accent),
                          ),
                        ),
                        Switch(
                          value: c.includeAuto.value,
                          onChanged: (v) => c.includeAuto.value = v,
                          activeThumbColor: TripMatesColors.green,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Active filters',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: headingBlue,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: const [
                    _FilterChip('Fri · Apr 10'),
                    _FilterChip('40 km radius'),
                    _FilterChip('Sort: Date'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SearchRidesView extends GetView<SearchRidesController> {
  const SearchRidesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SearchRidesScreenContent(showBack: true, controller: controller),
      ),
      bottomNavigationBar: TmBottomNav(
        selectedIndex: 1,
        onTap: UserHomeNavigation.handleGlobalBottomTap,
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip(this.label);
  final String label;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? scheme.surfaceContainerHighest : TripMatesColors.sky,
        borderRadius: BorderRadius.circular(9),
        border: isDark ? Border.all(color: scheme.outline.withValues(alpha: 0.35)) : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isDark ? scheme.onSurface.withValues(alpha: 0.88) : TripMatesColors.accent,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
