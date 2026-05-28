import 'package:flutter/material.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/widgets/tripmates/tm_components.dart';
import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';

/// Static gallery preview only (see [PublishRideView] for the real publish flow).
class MakeNewRideScreenContent extends StatelessWidget {
  const MakeNewRideScreenContent({super.key, this.showBack = false});

  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        TmMintAppBar(title: 'Make a New Ride', showBack: showBack),
        Expanded(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              padding: const EdgeInsets.all(14),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: scheme.outline.withValues(alpha: 0.28)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StepBadge(label: 'ROUTE', active: true, index: '1'),
                      _StepBadge(label: 'DATE', index: '2'),
                      _StepBadge(label: 'PREFS', index: '3'),
                      _StepBadge(label: 'PUBLISH', index: '4'),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const TmFakeField(label: 'Route', hint: 'Origin'),
                const SizedBox(height: 8),
                const TmFakeField(label: 'Destination', hint: 'Where to?'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StepBadge extends StatelessWidget {
  const _StepBadge({required this.label, required this.index, this.active = false});
  final String label;
  final String index;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: active ? TripMatesColors.green : TripMatesColors.off,
          child: Text(
            index,
            style: TextStyle(color: active ? TripMatesColors.white : TripMatesColors.text3, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10, color: TripMatesColors.text4)),
      ],
    );
  }
}
