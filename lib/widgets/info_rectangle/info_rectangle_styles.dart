import 'package:ecoparking_flutter/widgets/info_rectangle/info_rectangle.dart';
import 'package:flutter/material.dart';

class InfoRectangleStyle {
  static const double defaultSpacing = 8;
  static const double defaultIconSize = 16;

  static const BorderRadiusGeometry rectangleBorderRadius =
      BorderRadius.all(Radius.circular(50));

  static BoxDecoration getDecoration(
    BuildContext context,
    InfoRectangleType type,
  ) {
    switch (type) {
      case InfoRectangleType.filled:
        return BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: rectangleBorderRadius,
        );
      case InfoRectangleType.hollow:
        return BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
          borderRadius: rectangleBorderRadius,
        );
      default:
        return const BoxDecoration();
    }
  }

  static Color getLabelColor(
    BuildContext context,
    InfoRectangleType type,
  ) {
    switch (type) {
      case InfoRectangleType.filled:
        return Theme.of(context).colorScheme.onPrimary;
      case InfoRectangleType.hollow:
        return Theme.of(context).colorScheme.primary;
      default:
        return Colors.black;
    }
  }
}
