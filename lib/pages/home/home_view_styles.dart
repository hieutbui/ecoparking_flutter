import 'package:ecoparking_flutter/pages/home/model/widget_position.dart';
import 'package:flutter/material.dart';

class HomeViewStyles {
  static const double initialZoom = 15.0;
  static const double topButtonSpacing = 16.0;
  static const double bottomButtonSpacing = 12.0;
  static const BorderRadiusGeometry buttonBorderRadius =
      BorderRadius.all(Radius.circular(50));
  static const BorderRadiusGeometry floatingButtonBorderRadius =
      BorderRadius.all(Radius.circular(30));

  static WidgetPosition topButtonRowPosition = WidgetPosition(
    top: 16.0,
    right: 30.0,
  );
  static WidgetPosition bottomButtonColumnPosition = WidgetPosition(
    bottom: 16.0,
    right: 16.0,
  );

  static Decoration getFloatingButtonDecoration(BuildContext context) =>
      BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0),
            Theme.of(context).colorScheme.primary,
          ],
          stops: const [0.0, 0.63],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: buttonBorderRadius,
      );

  static const ShapeBorder floatingButtonShape = RoundedRectangleBorder(
    borderRadius: floatingButtonBorderRadius,
  );
}
