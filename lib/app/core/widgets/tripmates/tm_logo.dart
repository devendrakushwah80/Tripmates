import 'package:flutter/material.dart';

import '../../const/app_colors.dart';

/// Central logo path + safe fallback if asset missing.
class AppAssetPaths {
  AppAssetPaths._();

  static const String logo = 'imagesss/logo.png';
}

class TmLogo extends StatelessWidget {
  const TmLogo({
    super.key,
    this.size = 28,
    this.trimWhitespace = true,
    this.scale = 1.28,
  });

  final double size;
  final bool trimWhitespace;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: ClipRect(
        child: Transform.scale(
          scale: trimWhitespace ? scale : 1,
          child: Image.asset(
            AppAssetPaths.logo,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.eco_rounded,
              size: size * 0.85,
              color: TripMatesColors.green,
            ),
          ),
        ),
      ),
    );
  }
}
