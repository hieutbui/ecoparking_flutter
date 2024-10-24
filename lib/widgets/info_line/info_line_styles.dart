import 'package:flutter/material.dart';

class InfoLineStyles {
  static const BoxDecoration containerDecoration = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Color(0xFFA1A1A1),
        width: 1,
      ),
    ),
  );

  static TextStyle? titleStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: const Color(0xFFA1A1A1),
          );

  static TextStyle? infoStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge?.copyWith(
            color: const Color(0xFF000000),
          );
}
