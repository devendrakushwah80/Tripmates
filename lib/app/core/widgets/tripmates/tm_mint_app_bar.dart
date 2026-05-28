import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/app_colors.dart';
import 'tm_logo.dart';

/// Mint app bar + green line — matches HTML `.appbar` + `.appbar-line`.
/// Title stays on one line; works in light and dark theme.
class TmMintAppBar extends StatelessWidget {
  const TmMintAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.onBack,
    /// Small mark on the right — off by default so auth headers stay balanced.
    this.showTrailingBrand = false,
  });

  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final bool showTrailingBrand;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final barColor = isDark ? AppColors.darkSurface : const Color(0xFFF2F9F5);
    final iconColor = isDark ? AppColors.darkTextPrimary : TripMatesColors.blue;
    final titleColor = isDark ? AppColors.darkTextPrimary : TripMatesColors.blue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: barColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 12, 10),
            child: Row(
              children: [
                if (showBack)
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                    icon: Icon(Icons.chevron_left, color: iconColor, size: 26),
                    onPressed: onBack ?? () => Get.back<void>(),
                  )
                else
                  const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),
                ),
                if (showTrailingBrand) ...[
                  const SizedBox(width: 8),
                  const TmLogo(size: 26),
                ],
              ],
            ),
          ),
        ),
        Container(
          height: 2,
          color: TripMatesColors.green.withValues(alpha: isDark ? 0.55 : 0.42),
        ),
      ],
    );
  }
}
