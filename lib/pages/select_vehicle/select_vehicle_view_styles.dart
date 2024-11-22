import 'package:flutter/material.dart';

class SelectVehicleViewStyles {
  static const double listViewSpacing = 22.0;

  static const EdgeInsetsGeometry padding = EdgeInsets.symmetric(
    horizontal: 16.0,
  );
  static const EdgeInsetsGeometry paddingBottom = EdgeInsets.only(
    top: 8.0,
    left: 16.0,
    right: 16.0,
    bottom: 16.0,
  );
  static const EdgeInsetsGeometry emptyVehiclePadding = EdgeInsets.only(
    top: 32.0,
    left: 16.0,
    right: 16.0,
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
