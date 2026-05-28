import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../controllers/origin_search_controller.dart';

class OriginSearchScreenContent extends StatelessWidget {
  const OriginSearchScreenContent({super.key, this.showBack = false});

  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        TmMintAppBar(title: 'Search Rides', showBack: showBack),
        Expanded(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search originâ€¦',
                filled: true,
                fillColor: scheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OriginSearchView extends GetView<OriginSearchController> {
  const OriginSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(child: OriginSearchScreenContent(showBack: true)),
    );
  }
}

