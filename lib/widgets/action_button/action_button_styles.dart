import 'package:ecoparking_flutter/widgets/action_button/action_button.dart';
import 'package:flutter/material.dart';

class AppButtonStyles {
  static const double defaultArrowSize = 16;
  static const double defaultButtonHeight = 51;
  static const double defaultButtonWidth = double.infinity;

  static const BorderRadiusGeometry defaultButtonBorderRadius =
      BorderRadius.all(Radius.circular(50));

  static BoxDecoration getButtonDecoration(
    BuildContext context,
    ActionButtonType type, {
    Color? backgroundColor,
    Color? hollowBorderColor,
    BorderRadiusGeometry? borderRadius,
  }) {
    switch (type) {
      case ActionButtonType.positive:
        return BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.primary,
          borderRadius: borderRadius ?? defaultButtonBorderRadius,
        );
      case ActionButtonType.negative:
        return BoxDecoration(
          color:
              backgroundColor ?? Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: borderRadius ?? defaultButtonBorderRadius,
        );
      case ActionButtonType.hollow:
        return BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          border: Border.all(
            color: hollowBorderColor ?? Theme.of(context).colorScheme.primary,
            width: 2,
          ),
          borderRadius: borderRadius ?? defaultButtonBorderRadius,
        );
      default:
        return const BoxDecoration();
    }
  }

  static Color getLabelColor(
    BuildContext context,
    ActionButtonType type, {
    Color? labelColor,
  }) {
    if (labelColor != null) return labelColor;

    switch (type) {
      case ActionButtonType.positive:
        return Theme.of(context).colorScheme.onPrimary;
      case ActionButtonType.negative:
        return Theme.of(context).colorScheme.onTertiary;
      case ActionButtonType.hollow:
        return Theme.of(context).colorScheme.primary;
      default:
        return Colors.black;
    }
  }
}
