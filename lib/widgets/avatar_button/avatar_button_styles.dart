import 'dart:typed_data';
import 'package:flutter/material.dart';

class AvatarButtonStyles {
  static const double avatarSize = 132.0;
  static const double iconPersonWidth = 95.0;
  static const double iconPersonHeight = 100.0;
  static const double editRectanglesSize = 25.0;
  static const double iconEditSize = 12.0;

  static const Offset editRectanglesOffset = Offset(-2, -10);

  static const EdgeInsetsGeometry iconPersonPadding = EdgeInsets.only(top: 33);

  static Decoration getDecoration({
    required BuildContext context,
    Uint8List? imageDate,
  }) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.tertiary,
      shape: BoxShape.circle,
      image: getDecorationImage(imageDate),
    );
  }

  static Decoration getEditRectangleDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: const BorderRadius.all(Radius.circular(5)),
    );
  }

  static DecorationImage? getDecorationImage(Uint8List? imageData) {
    if (imageData != null) {
      return DecorationImage(
        image: MemoryImage(imageData),
        fit: BoxFit.cover,
      );
    }

    return null;
  }
}
