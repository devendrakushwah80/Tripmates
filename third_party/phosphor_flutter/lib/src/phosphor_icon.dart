library phosphor_flutter;

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PhosphorIcon extends Icon {
  PhosphorIcon(
    Object icon, {
    Key? key,
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    Color? color,
    List<Shadow>? shadows,
    String? semanticLabel,
    TextDirection? textDirection,
    this.duotoneSecondaryOpacity = 0.20,
    this.duotoneSecondaryColor,
  })  : phosphorIcon = icon,
        super(
          _primaryIconData(icon),
          color: color,
          fill: fill,
          grade: grade,
          key: key,
          opticalSize: opticalSize,
          semanticLabel: semanticLabel,
          shadows: shadows,
          size: size,
          textDirection: textDirection,
          weight: weight,
        );

  final Object phosphorIcon;
  final double duotoneSecondaryOpacity;
  final Color? duotoneSecondaryColor;

  static IconData _primaryIconData(Object icon) {
    if (icon is IconData) return icon;
    if (icon is PhosphorIconData) return icon.iconData;
    throw ArgumentError.value(
        icon, 'icon', 'Expected IconData or PhosphorIconData');
  }

  @override
  Widget build(BuildContext context) {
    if (phosphorIcon is PhosphorDuotoneIconData) {
      final duotoneIcon = phosphorIcon as PhosphorDuotoneIconData;
      return Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: duotoneSecondaryOpacity,
            child: Icon(
              duotoneIcon.secondary.iconData,
              key: key,
              size: size,
              fill: fill,
              weight: weight,
              grade: grade,
              opticalSize: opticalSize,
              color: duotoneSecondaryColor ?? color,
              shadows: shadows,
              semanticLabel: semanticLabel,
              textDirection: textDirection,
            ),
          ),
          super.build(context),
        ],
      );
    }
    return super.build(context);
  }
}
