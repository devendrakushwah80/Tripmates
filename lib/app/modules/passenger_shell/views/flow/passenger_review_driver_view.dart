import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/widgets/tripmates/tm_mint_app_bar.dart';
import '../../controllers/passenger_flow_controller.dart';
import '../../theme/passenger_shell_theme.dart';

class PassengerReviewDriverView extends GetView<PassengerFlowController> {
  const PassengerReviewDriverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PassengerShellTheme.screenBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TmMintAppBar(
              title: 'passenger_review.title'.tr,
              showBack: true,
              onBack: controller.popFlowOrShell,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 100),
                children: [
                  Text(
                    'passenger_review.sub'.tr,
                    style: GoogleFonts.inter(
                      color: PassengerShellTheme.textSecondary,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'passenger_review.stars'.tr,
                    style: GoogleFonts.lexend(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: PassengerShellTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(() {
                    final s = controller.reviewStars.value;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (i) {
                        final n = i + 1;
                        return IconButton(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          onPressed: () => controller.reviewStars.value = n,
                          icon: PhosphorIcon(
                            n <= s
                                ? PhosphorIconsFill.star
                                : PhosphorIconsRegular.star,
                            color: const Color(0xFFEAB308),
                            size: 36,
                          ),
                        );
                      }),
                    );
                  }),
                  const SizedBox(height: 22),
                  Text(
                    'passenger_review.chips'.tr,
                    style: GoogleFonts.lexend(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: PassengerShellTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    controller.reviewChips;
                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _ReviewChip(
                          label: 'passenger_review.chip_safe'.tr,
                          selected: controller.reviewChips['safe'] == true,
                          onTap: () => controller.toggleReviewChip('safe'),
                        ),
                        _ReviewChip(
                          label: 'passenger_review.chip_clean'.tr,
                          selected: controller.reviewChips['clean'] == true,
                          onTap: () => controller.toggleReviewChip('clean'),
                        ),
                        _ReviewChip(
                          label: 'passenger_review.chip_friendly'.tr,
                          selected: controller.reviewChips['friendly'] == true,
                          onTap: () => controller.toggleReviewChip('friendly'),
                        ),
                        _ReviewChip(
                          label: 'passenger_review.chip_ontime'.tr,
                          selected: controller.reviewChips['ontime'] == true,
                          onTap: () => controller.toggleReviewChip('ontime'),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 20),
                  Text(
                    'passenger_review.comment'.tr,
                    style: GoogleFonts.lexend(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: PassengerShellTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.reviewComment,
                    maxLines: 4,
                    style: GoogleFonts.inter(
                      color: PassengerShellTheme.textPrimary,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: PassengerShellTheme.cardWhite,
                      hintText: '…',
                      hintStyle: GoogleFonts.inter(
                        color: PassengerShellTheme.textSecondary.withValues(
                          alpha: 0.5,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: PassengerShellTheme.textSecondary.withValues(
                            alpha: 0.15,
                          ),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: PassengerShellTheme.textSecondary.withValues(
                            alpha: 0.15,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: PassengerShellTheme.primaryGreen,
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: PassengerShellTheme.primaryGreen.withValues(
                    alpha: 0.22,
                  ),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: FilledButton(
              onPressed: controller.submitReview,
              style: FilledButton.styleFrom(
                backgroundColor: PassengerShellTheme.primaryGreen,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                'passenger_review.submit'.tr,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ReviewChip extends StatelessWidget {
  const _ReviewChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: PassengerShellTheme.softGreenBg,
      checkmarkColor: PassengerShellTheme.primaryGreen,
      labelStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        color: selected
            ? PassengerShellTheme.primaryGreen
            : PassengerShellTheme.textPrimary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: PassengerShellTheme.primaryGreen.withValues(
            alpha: selected ? 0.45 : 0.15,
          ),
        ),
      ),
    );
  }
}
