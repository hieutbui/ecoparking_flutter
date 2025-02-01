import 'package:flutter/material.dart';

class BookParkingDetailsViewStyles {
  static const double spacing = 16.0;
  static const double wrapperSpacing = 8.0;
  static const double bottomOpacity = 0.0;
  static const double elevation = 0.0;

  static double segmentTabsWidth(BuildContext context) =>
      MediaQuery.of(context).size.width - 150;

  static const EdgeInsetsGeometry bottomContainerPadding = EdgeInsets.only(
    top: 8.0,
    left: spacing,
    right: spacing,
    bottom: spacing,
  );
  static const EdgeInsetsGeometry padding =
      EdgeInsets.symmetric(horizontal: 24.0);
  static const EdgeInsetsGeometry paddingText = EdgeInsets.only(
    left: 12.0,
    bottom: spacing,
  );
  static const EdgeInsetsGeometry calendarContainerPadding =
      EdgeInsets.all(8.0);

  static const BoxDecoration calendarContainerDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    color: calendarBackgroundColor,
  );

  static const Color calendarBackgroundColor = Color(0xF3F3F3F3);

  static List<BoxShadow> get bottomContainerShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, -2),
          spreadRadius: 2,
        ),
      ];

  static Decoration get bottomContainerDecoration => BoxDecoration(
        boxShadow: bottomContainerShadow,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      );

  static Border segmentTabsBorder(BuildContext context) => Border.all(
        color: Theme.of(context).colorScheme.primary,
        width: 1,
      );

  static const BorderRadius segmentTabsBorderRadius =
      BorderRadius.all(Radius.circular(5));

  static BoxDecoration segmentTabsIndicator(BuildContext context) =>
      BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      );
}
