import 'package:flutter/material.dart';

class BookParkingDetailsViewStyles {
  static const double calendarContainerBottomSpacing = 32.0;

  static const EdgeInsetsGeometry padding =
      EdgeInsets.symmetric(horizontal: 24.0);
  static const EdgeInsetsGeometry paddingText = EdgeInsets.only(
    left: 12.0,
    top: 16.0,
    bottom: 16.0,
  );
  static const EdgeInsetsGeometry calendarContainerPadding =
      EdgeInsets.all(8.0);

  static const BoxDecoration calendarContainerDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    color: calendarBackgroundColor,
  );

  static const Color calendarBackgroundColor = Color(0xF3F3F3F3);
}
