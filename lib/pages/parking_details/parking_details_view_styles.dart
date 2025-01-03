import 'package:flutter/material.dart';

class ParkingDetailsViewStyles {
  static const double imageHeight = 150.0;
  static const double normalSpacing = 12.0;
  static const double wideSpacing = 30.0;
  static const double actionButtonWidth = 200.0;

  static const BorderRadiusGeometry imageBorderRadius =
      BorderRadius.all(Radius.circular(20.0));

  static const EdgeInsetsGeometry padding =
      EdgeInsets.symmetric(horizontal: 22.0);
  static const EdgeInsetsGeometry infoRectanglePadding =
      EdgeInsets.symmetric(vertical: 8, horizontal: 16);
  static const EdgeInsetsGeometry bottomContainerPadding = EdgeInsets.only(
    top: 8.0,
    left: 16.0,
    right: 16.0,
    bottom: 16.0,
  );

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
}
