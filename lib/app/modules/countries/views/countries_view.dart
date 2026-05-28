import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../controllers/countries_controller.dart';

class CountriesScreenContent extends StatelessWidget {
  const CountriesScreenContent({super.key, this.showBack = false});

  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        TmMintAppBar(title: 'Region & language', showBack: showBack),
        Expanded(
          child: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              itemCount: CountriesController.rows.length,
              separatorBuilder: (context, index) => const SizedBox(height: 6),
              itemBuilder: (_, i) {
                final row = CountriesController.rows[i];
                return ListTile(
                  tileColor: scheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(color: scheme.outline.withValues(alpha: 0.28)),
                  ),
                  title: Text(row.name, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: scheme.onSurface)),
                  subtitle: Text(
                    '${row.languageCode.toUpperCase()} · billing ${row.billingCode}',
                    style: GoogleFonts.nunito(color: scheme.onSurface.withValues(alpha: 0.55), fontSize: 13),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Get.find<CountriesController>().select(i),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CountriesView extends GetView<CountriesController> {
  const CountriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(child: CountriesScreenContent(showBack: true)),
    );
  }
}
