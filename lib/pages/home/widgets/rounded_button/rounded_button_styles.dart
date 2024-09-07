import 'package:flutter/material.dart';

class RoundedButtonStyles {
  static const Color backgroundColor = Color(0xFFEFECEC);

  static const BorderRadiusGeometry borderRadius =
      BorderRadius.all(Radius.circular(50));

  static Color getIconColor(BuildContext context) =>
      Theme.of(context).colorScheme.primary;
}
